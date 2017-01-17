#!/usr/bin/env python3
import argparse
import gzip
import os
import shutil
import subprocess as sp
import sys
import tempfile

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('path')
    return parser.parse_args()

def main():
    path = parse_args().path
    tdir = tempfile.mkdtemp()
    dest = os.path.join(tdir, os.path.basename(path))
    shutil.copyfile(path, dest)

    sp.check_call(['xar', '-xf', dest], cwd=tdir)
    with gzip.open(os.path.join(tdir, 'agent.pkg', 'Payload')) as gzfile:
        data = gzfile.read()
    where = data.find(b'/opt/jc/version.txt')
    version = data[where+20:-1].split(b'\n')[0]
    print(version.decode('ascii'))
    shutil.rmtree(tdir)

if __name__ == '__main__':
    main()
