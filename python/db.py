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