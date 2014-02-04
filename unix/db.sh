

# Find: How to avoid printing to screen Permission denied errors
find / -name art  2>&1 | grep -v "Permission denied"
# or pipe stderr to null
find / -name art  2>/dev/null

# find libglut* in all folders but /home
find / -name "libglut*" -not -path "/home/*" 2>/dev/null
