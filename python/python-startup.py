# https://docs.python.org/3/tutorial/appendix.html#the-interactive-startup-file
# https://github.com/prompt-toolkit/ptpython/issues/284#issuecomment-510446925
# https://stackoverflow.com/questions/59936089/how-to-read-history-in-ptpython-console
import sys
from os import environ
from pathlib import Path
from importlib import import_module


def path_from_env(path):
    return str(Path(environ[path]).expanduser().resolve())

try:
    from ptpython.repl import embed
    sys.path.append(path_from_env('PTPYTHON_CONFIG_HOME'))
    config = import_module("config")
except ImportError:
    print("ptpython is not available: falling back to standard prompt")
else:
    sys.exit(
        embed(
            globals(),
            locals(),
            configure=config.configure,
            history_filename=path_from_env('PTPYTHON_HISTORY'),
        )
    )
