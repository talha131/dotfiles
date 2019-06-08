#!/usr/bin/python

# Imageoptim crashed when I tried to optimize thousands of images on an
# external drive. It made all the files hidden.
# DSC_1252.JPG became .DSC_1252~imageoptim.JPG
# This script removes the leading dot and ~imageoptim

import sys
import os
import re


def main(file):
    current = os.getcwd()
    folder = os.path.dirname(file)
    filename = os.path.basename(file)
    # complete = os.path.join(current, folder, filename)
    f, ext = os.path.splitext(filename)
    newf = f.replace('~imageoptim', '')
    newf = re.sub(r'^\.', '', newf)
    dest = os.path.join(current, folder, newf + ext)

    if not os.path.exists(dest):
        print('{} -> {}'.format(file, dest))
        os.rename(file, dest)


if __name__ == "__main__":
    main(sys.argv[1])
