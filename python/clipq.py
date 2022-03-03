#!/usr/bin/env python3

import asyncio
import sys


binary = '/usr/local/bin/copyq'
delimiter=';:;:;'

async def row(idx):
    proc = await asyncio.create_subprocess_exec(
        binary, 'read', str(idx), 'text/plain', stdout=asyncio.subprocess.PIPE)
    stdout, stderr = await proc.communicate()
    if not proc.returncode and stdout:
        result = stdout.decode("utf8")
        if result:
            return f'{str(idx)}{delimiter}{result}'

async def clipboard_rows():
    proc = await asyncio.create_subprocess_exec(binary, 'count', stdout=asyncio.subprocess.PIPE)
    stdout, stderr = await proc.communicate()
    c = int(stdout.decode("utf8"))
    return await asyncio.gather(*[row(i) for i in range(c)])

async def select_row(idx):
    proc = await asyncio.create_subprocess_exec(binary, 'select', idx)
    await proc.communicate()

if __name__ == "__main__":
    if len(sys.argv) == 2 and sys.argv[1] == 'select':
        asyncio.run(select_row(sys.stdin.readline().split(delimiter)[0]))
    else:
        result = asyncio.run(clipboard_rows())
        print('\0'.join([i for i in result if i is not None]))

