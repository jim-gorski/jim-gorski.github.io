```
#!/usr/bin/env python3

# Nikola configuration file for jim-gorski.github.io
#
# This file sets up the basic site settings, content paths,
# output directory, plugins, and Markdown options.
#
# Place this file at the root of your repository.

import os

# ---------- Basic site settings ----------
SITEURL = 'https://jgorski.github.io'   # Replace with your GitHub Pages URL
AUTHOR = 'Jim Gorski'
SITENAME = 'Jim Gorski Blog'

# ---------- Paths ----------
CONTENT_PATHS = ['content']          # Source content lives in ./content/
OUTPUT_DIR = 'output'                 # Nikola writes the static site here
STATIC_PATHS = ['content/static']     # Copy these files unchanged

# ---------- Plugins ----------
PLUGINS = [
    'blog',
    'pages',
    # Add more plugins here if needed, e.g.:
    # 'search',
]

# ---------- Markdown ----------
MARKDOWN_EXTENSIONS = ['extra', 'codehilite']

# ---------- Other settings ----------
TIMEZONE = 'UTC'
DEFAULT_LANG = 'en'

# If you want to enable the search plugin, uncomment the line above and
# install it with: pip install nikola-search

# End of configuration
