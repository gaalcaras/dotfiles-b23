#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Listing all buku entries for rofi to parse
"""

import buku

bdb = buku.BukuDb()
bookmarks = bdb.get_rec_all()

bid_lmax = len(str(bookmarks[-1][0]))

for b in bookmarks:
    bid = b[0]
    url = b[1]
    title = b[2]
    tags = b[3][1:-1]
    desc = b[4].replace('\n', ' ')

    try:
        print(f"{bid:0{bid_lmax}d}: {title:50.50}   {desc:100.100} + {tags:60} -> {url}")
    except TypeError:
        continue
