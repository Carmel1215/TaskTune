import json, numpy as np, torch, torch.nn as nn
from pathlib import Path
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

# uvicorn server:app --reload --port 8000

MODEL_PATH = Path("met_fatigue_minimal.pt")

FEATS = ["met", "duration_min", "preference01"]

class InputItem(BaseModel):
    met: float = Field(ge=0)
    duration_min: int = Field(ge=0)
    preference01: float = Field(ge=0.0, le=1.0)

class OutputItem(BaseModel):
    fatigue: float

class FatigueNet(nn.Module):
    def __init__(self, d=3):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(d, 128), nn.ReLU(),
            nn.BatchNorm1d(128), nn.Dropout(0.2),
            nn.Linear(128, 64), nn.ReLU(),
            nn.BatchNorm1d(64), nn.Dropout(0.2),
            nn.Linear(64, 32), nn.ReLU(),
            nn.Linear(32, 1), nn.Sigmoid()
        )
    def forward(self, x):  # 0~100 범위
        return self.net(x) * 100.0

app = FastAPI(title="TaskTune Fatigue API", version="1.0.0")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 배포 시 도메인으로 제한 권장
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ----- 모델 로드 -----
ck = torch.load(MODEL_PATH, map_location="cpu")
mu = np.array(ck["mu"], dtype=np.float32)
sigma = np.array(ck["sigma"], dtype=np.float32)
net = FatigueNet(len(FEATS))
net.load_state_dict(ck["state_dict"])
net.eval()

@app.get("/health")
def health():
    return {"ok": True}

@app.post("/predict", response_model=OutputItem)
def predict(item: InputItem):
    try:
        x = np.array([getattr(item, f) for f in FEATS], dtype=np.float32)
        xz = (x - mu) / (sigma + 1e-6)
        with torch.no_grad():
            y = net(torch.tensor(xz).unsqueeze(0)).item()
        y = float(max(0.0, min(100.0, y)))
        return {"fatigue": y}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))