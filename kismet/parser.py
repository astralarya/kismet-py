from typing import Tuple
from os import path
from lark import Lark, Transformer
import torch
from torch.distributions.categorical import Categorical

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


def pretty(tensor):
    prefix = len("tensor(")
    string = str(tensor)
    return "\n".join(line[prefix:] for line in string.splitlines())[:-1]


class Expr:
    def __init__(self, expr: any, args: Tuple["Expr"] = ()):
        self.expr: any = expr if callable(expr) else lambda: (expr, str(expr))
        self.args: Tuple["Expr"] = args
        self.value: any = None
        self.repr: str = None

    def __call__(self):
        self.value, self.repr = self.expr(*[arg() for arg in self.args])
        return self

    def __repr__(self):
        return "Expr(" + repr(self.value) + ", " + repr(self.args) + ")"

    def __str__(self):
        value = str(self.value)
        _repr = str(self.repr)
        if value == _repr:
            return pretty(value)
        else:
            return pretty(value) + " = " + _repr


class KismetTransformer(Transformer):
    # Tokens
    def int(self, args):
        return Expr(int(args[0]))

    def die_count(self, args):
        return Expr(int(args[0]))

    def float(self, args):
        return Expr(float(args[0]))

    def string(self, args):
        return Expr(str(args[0])[1:-1].encode().decode("unicode_escape"))

    # Rules
    def number(self, args):
        return args[0]

    def d_number(self, args):
        def f(x):
            return (
                lambda shape: Categorical(torch.ones([x.value])).sample(shape) + 1,
                "d%s" % x.repr,
            )

        return Expr(f, (args[1],))

    def sample(self, args):
        def f(x, y):
            samples = list(y.value(()) for i in range(x.value))
            strings = list(pretty(sample) for sample in samples)
            return (sum(samples), "[" + " + ".join(strings) + "]")

        return Expr(f, (args[0], args[1]))

    def sample1(self, args):
        def f(x):
            samples = list(x.value(()) for i in range(1))
            strings = list(pretty(sample) for sample in samples)
            return (sum(samples), "[" + " + ".join(strings) + "]")

        return Expr(f, (args[0],))

    def value(self, args):
        return args[0]

    def start(self, args):
        return "\n".join(str(arg()) for arg in args)
