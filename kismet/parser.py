from os import path
from lark import Lark, Transformer
from .distributions import DiscreteUniform

grammar_file = "kismet.lark"

parser = Lark(
    open(path.join(path.dirname(__file__), grammar_file)), parser="lalr", debug=True
)


class KismetParser:
    def __init__(self):
        pass

    def parse(self, text: str):
        tree = parser.parse(text)
        tree = KismetTransformer().transform(tree)
        return tree


class Expr:
    def __init__(self, value, expr):
        self.value = value
        self.expr = expr

    def __repr__(self):
        return "Expr(" + repr(self.value) + ", " + repr(self.expr) + ")"

    def __str__(self):
        value = str(self.value)
        expr = str(self.expr)
        if value == expr:
            return value
        else:
            return value + " = " + expr


class KismetTransformer(Transformer):
    # Tokens
    def int(self, args):
        return Expr(int(args[0]), args[0])

    def die_count(self, args):
        return Expr(int(args[0]), args[0])

    # Rules
    def number(self, args):
        return Expr(args[0].value, args[0].expr)

    def d_number(self, args):
        return Expr(DiscreteUniform(1, args[1].value), "d" + args[1].expr)

    def sample(self, args):
        value = list(args[1].value.sample() for i in range(args[0].value))
        return Expr(
            sum(value).tolist(),
            "[" + " + ".join(str(item.tolist()) for item in value) + "]",
        )

    def sample1(self, args):
        value = args[0].value.sample().tolist()
        return Expr(value, "[" + str(value) + "]")

    def value(self, args):
        return Expr(args[0].value, args[0].expr)

    def start(self, args):
        return "\n".join(str(arg) for arg in args)
