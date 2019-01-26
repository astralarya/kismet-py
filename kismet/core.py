from kismet.parser import KismetParser

# Create parser object.
parser = KismetParser()

def process(string: str):
    return parser.parse(string)
