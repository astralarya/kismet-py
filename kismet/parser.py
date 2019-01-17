from os import path
from lark import Lark

grammar_file = "kismet.lark"

parser = Lark(
    open(path.join(path.dirname(__file__), grammar_file)), parser="lalr", debug=True
)


class KismetParser:
    def __init__(self):
        pass

    def parse(self, text: str):
        return parser.parse(text)
