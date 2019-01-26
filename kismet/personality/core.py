import regex
import torch
from torch.distributions.gamma import Gamma
from torch.distributions.categorical import Categorical
import math
from typing import List
from kismet.personality.responses import responses


def analyze(string: str, responses_: List[str] = responses):
    mentions = len(
        regex.findall(r"[Kk]+\s*[Ii]+\s*[Ss]+\s*[Mm]+\s*[Ee]+\s*[Tt]+", string)
    )
    attention = math.log(mentions + 0.5) * math.log10(len(string.replace(r"\s", "")))
    excitement = int(torch.ceil(Gamma(2.5, 1 / attention).sample()).tolist())

    categorical = Categorical(torch.ones(len(responses_)))
    response = []
    for i in range(excitement):
        response.append(responses_[categorical.sample()])

    return " ".join(response)
