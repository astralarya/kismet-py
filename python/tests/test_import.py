import os
import pytest
from pathlib import Path
from setuptools.config import read_configuration

pardir = Path(__file__).parent.parent
modname = next(
    f.name
    for f in (pardir).iterdir()
    if f.is_dir()
    and f.name not in ["__pycache__", "tests"]
    and not f.name.startswith(".")
    and not f.name.endswith(".egg-info")
)


@pytest.fixture(scope="module")
def pkgname_from_dirs():
    return modname


@pytest.fixture(scope="module")
def pkgname_from_config():
    conf = read_configuration("setup.cfg")
    return conf["metadata"]["name"]


def test_import(pkgname_from_dirs):
    """
    This test demonstrates the use of a _fixture_. It's not super useful in this case, but in general if you have
    tests that depend on some mutable state that you want to reinitialize each time, or some object that is immutable
    but expensive to instantiate, or a connection to a database, file, or other I/O, this is a good way to do it.
    The argument name 'pkgname_from_dirs' here tells pytest to call the above function with the same name, and pass
    that value in for the argument's value. With the scope='module' specification up there we're telling pytest it only
    needs to evaluate that fixture once for the duration of this test suite."""
    print(pkgname_from_dirs)
    __import__(pkgname_from_dirs)


def test_import_from_config(pkgname_from_config):
    __import__(pkgname_from_config)


def test_equal_pkgnames(pkgname_from_dirs, pkgname_from_config):
    assert pkgname_from_dirs == pkgname_from_config


def test_something():
    """This is the basic structure of a test using `pytest`.
    It's really just as simple as defining a function whose name starts with 'test_', and then making assertions in
    the body of the function.
    It's good to break up your tests over a lot of little functions, but pytest will run them either way and give
    informative output about the nature of any failures."""
    some_fact_that_should_be_true = True

    assert some_fact_that_should_be_true
    assert len([1, 2, 3]) == 3


@pytest.mark.parametrize("list_,len_", [([1], 1), ([1, 2], 2), ([1, 2, 3], 3)])
def test_lots_of_things(list_, len_):
    """You can decorate a test function with @pytest.mark.parametrize like so to run the same test over many inputs.
    You can also nest these decorators to iterate over a product set of values, kind of like
        for list_ in [<list of values for list_>]:
            for len_ in [<list of values for len_>]:
                test_lots_of_things(list_, len_)"""
    assert len(list_) == len_
