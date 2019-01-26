from kismet.parser import KismetParser
from kismet.personality.core import analyze

# Create parser object.
parser = KismetParser()


def process(string: str):
    parsed = parser.parse(string)
    emoted = analyze(string)
    if parsed and emoted:
        return parsed + "\n" + emoted
    elif parsed:
        return parsed
    elif emoted:
        return emoted
    else:
        return None
