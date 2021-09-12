# https://docs.python.org/3/tutorial/appendix.html#the-interactive-startup-file
# https://github.com/prompt-toolkit/ptpython/issues/284#issuecomment-510446925
import os
import sys
from importlib import import_module


try:
    from ptpython.repl import embed
    sys.path.append(os.path.expanduser(os.environ['PTPYTHON_CONFIG_HOME']))
    config = import_module("config")
except ImportError:
    print("ptpython is not available: falling back to standard prompt")
else:
    sys.exit(embed(globals(), locals(), configure=config.configure))

