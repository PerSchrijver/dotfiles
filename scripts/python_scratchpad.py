from pwn import *
import random
import time
import json
import os
import sys
import itertools
import clipboard
import pickle
import math
import string
import requests
from rich import print, inspect, pretty
from rich.console import Console
from prettyprinter import pformat, pprint as pp
from pathlib import Path
from fn import _ as X
from fn.iters import *
from funcy import take, group_by, walk, walk_keys, walk_values, print_exits, ignore, suppress, retry, cached_property

console = Console(highlight=False)
pretty.install()
os.chdir("/tmp")
console.print(f"Python {sys.version.split(' ', 1)[0]} scratchpad at [green]/tmp[/green].")
del console
