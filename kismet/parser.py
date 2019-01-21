from os import path
from lark import Lark, Transformer

grammar_file = "kismet.lark"

parser = Lark(
    open(path.join(path.dirname(__file__), grammar_file)), parser="lalr", debug=True
)


class KismetParser:
    def __init__(self):
        pass

    def parse(self, text: str):
        tree = parser.parse(text)
        print(tree)
        tree = KismetTransformer().transform(tree)
        return tree

class KismetTransformer(Transformer):
    def int(self, args):
        return int(args[0])
    def number(self, args):
        return args[0]
