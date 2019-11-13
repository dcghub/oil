from typing import IO, Any

CPP: bool
PYTHON: bool

def NewStr(s: str) -> str: ...

class LineReader:
  def readline(self) -> str: ...

class BufLineReader(LineReader):
  def __init__(self, s: str): ...
  def readline(self) -> str: ...

def Stdin() -> LineReader: ...


class Writer:
  def write(self, s: str) -> None: ...
  def isatty(self) -> bool: ...

class BufWriter(Writer):
  def write(self, s: str) -> None: ...
  def getvalue(self) -> str: ...

def Stdout() -> Writer: ...


def log(msg: str, *args: Any) -> None: ...


class typeswitch(object):
  def __init__(self, value: int): ...

  def __enter__(self) -> typeswitch: ...

  def __exit__(self, type: Any, value: Any, traceback: Any) -> bool: ...

  def __call__(self, *cases: Any) -> bool: ...
