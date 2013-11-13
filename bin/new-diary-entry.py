import sys
import os
from datetime import date


def make_file(filename, text):
    """
    Creates a file and inserts text in it.
    It prints error if file already exists or cannot be created.

    :Parameter:
        - `filename`: file name
        - `text`: text to insert in the file
    """

    if not os.path.exists(filename):
        try:
            with open(filename, 'w') as f:
                f.write(text)
        except IOError:
            print >> sys.stderr, 'Failed to create %', filename
    else:
        print >> sys.stderr, 'File exists'


def main():
    filename = date.today().strftime('%Y-%m-%d.md')
    text = date.today().strftime('%A, %b %d, %Y')
    text = text + '\n' + '=' * len(text)
    text = text + '\n' * 2
    make_file(filename, text)


if __name__ == '__main__':
    main()
