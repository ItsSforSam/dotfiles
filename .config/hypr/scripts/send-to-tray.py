#!/bin/env python
# -*- Encoding: UTF-* -*-
# Reason to use python, it's faster

import json
import subprocess
import typing as t
# Must be the initial class and used as a sainity check
TRAYABLE:t.Final[list[t.LiteralString]] = [""]