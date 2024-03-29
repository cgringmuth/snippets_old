############################################################################
# shebang (https://en.wikipedia.org/wiki/Shebang_(Unix))
############################################################################
#!/usr/bin/env python


############################################################################
# enum in python
############################################################################
def enum(*sequential, **named):
    '''
    Example:  num = enum(ONE=1, TWO=2, THREE='three')
              num.ONE >>> 1
    Support for converting the values back to names can be added this way:
              num.reverse_mapping[2] >> 'TWO'
    Source: http://stackoverflow.com/a/1695250
    '''
    enums = dict(zip(sequential, range(len(sequential))), **named)
    reverse = dict((value, key) for key, value in enums.iteritems())
    enums['reverse_mapping'] = reverse
    return type('Enum', (), enums)



############################################################################
# Python Imaging Library (PIL)
# http://www.pythonware.com/products/pil/
############################################################################

For ubuntu 64 bit

It turns out that the APT installations put the libraries under /usr/lib/x86_64-linux-gnu and PIL will search for them in /usr/lib/. So you have to create symlinks for PIL to see them.

# ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib
# ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib
# ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib
# http://jj.isgeek.net/2011/09/install-pil-with-jpeg-support-on-ubuntu-oneiric-64bits/



############################################################################
# Importing libs if called as main
############################################################################
if __name__ == '__main__':
    from paste import httpserver    # Paste <http://pythonpaste.org>
    httpserver.serve(app, host='127.0.0.1', port=8080)  


############################################################################
# Use "with" for files (http://docs.python.org/2/tutorial/inputoutput.html#methods-of-file-objects)
############################################################################
It is good practice to use the with keyword when dealing with file objects. This has the advantage that the file is properly closed after its suite finishes, even if an exception is raised on the way. It is also much shorter than writing equivalent try-finally blocks:

with open('workfile', 'r') as f:
    read_data = f.read()
f.closed  # -> True



############################################################################
# Use __all__ mechanism to prevent name clashes if you import a module by
# form M import *
# http://www.python.org/dev/peps/pep-0008/#global-variable-names
############################################################################
# Specify what is visible from other modules if current module imported by
# form M import *
__all__ = ['foobar'] # only foobar is visible


foobar = 'hey'
foobarprivate = 'should not be seen'


############################################################################
# Class to handle a bunch of different variables
# http://code.activestate.com/recipes/52308-the-simple-but-handy-collector-of-a-bunch-of-named/?in=user-97991
############################################################################
class Bunch(dict):
    def __init__(self, **kw):
        dict.__init__(self, kw)         # This has the added benefit that it can directly be printed and it shows its contents in interactive environments like ipython.
        self.__dict__.update(kw)

# that's it!  Now, you can create a Bunch
# whenever you want to group a few variables:

point = Bunch(datum=y, squared=y*y, coord=x)

# and of course you can read/write the named
# attributes you just created, add others, del
# some of them, etc, etc:
if point.squared > threshold:
    point.isok = 1


############################################################################
# Dictionary default value
# Source: http://stackoverflow.com/questions/101268/hidden-features-of-python
############################################################################
d = {}                      # empty dictionary
dafaultKey = 1234           # default value for key
d['key']                    # -> exception 'KeyError'
d.get('key')                # -> None
d.get('key', dafaultKey)    # -> defaultKey = 1234
# Great for:
d['key'] = d.get('key', dafaultKey) + 1



############################################################################
# How to write binary bits to a file
############################################################################
import struct   # http://docs.python.org/2/library/struct.html

num = [1,2,3,4]

# http://docs.python.org/2/library/struct.html#struct.pack
# 'B' : unsigned byte -> 0..255
data = struct.pack('BBBB', *num)
# more general:
data = struct.pack('B' * len(num), *num)

filename = 'test.bin'
with open(filename, 'wb') as f:
    f.write(data)


############################################################################
# Mandatory vs. Optional Arguments
############################################################################ 
def func(v1, v2, **args):
    defaultV3 = -1
    v3 = args.get('v3', defaultV3)
    print v1, v2, v3

>>> func(1,2,v3=22)
1 2 22
>>> func(1,2)
1 2 -1




# Copy this
############################################################################
# 
############################################################################            