import regex
import torch
from torch.distributions.gamma import Gamma
from torch.distributions.categorical import Categorical
import numpy
import math
from typing import List
from kismet.personality.responses import responses as responses_


class Responder:
    def __init__(self, responses=responses_):
        self.categorical = Categorical(torch.ones(len(responses_)))
        self.responses = responses

    def respond(self, excitement: int):
        if excitement < 1:
            return None

        response = [
            self.responses[self.categorical.sample()]
            for _ in range(excitement)
        ]
        return " ".join(response)


responder_ = Responder()


def analyze(string: str, responder: Responder = responder_):
    return responder.respond(excitement(string))

def excitement(string: str):
    mentions = len(
        regex.findall(r"[Kk]+\s*[Ii]+\s*[Ss]+\s*[Mm]+\s*[Ee]+\s*[Tt]+", string)
    )
    if mentions:
        attention = numpy.arcsinh(mentions) * numpy.arcsinh(
            math.log(len(string.replace(r"\s", "")))
        )
        return int(torch.ceil(Gamma(1.2, 2 / attention).sample()).tolist())
    else:
        return 0