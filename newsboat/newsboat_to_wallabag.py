#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
# Feed input from bookmark-cmd of newsboat to wallabag.
"""

import argparse
import sys

import aiohttp
import asyncio
from wallabag_api.wallabag import Wallabag

from subprocess import Popen, PIPE

parser = argparse.ArgumentParser()

parser.add_argument("url")
parser.add_argument("title")
parser.add_argument("desc")
parser.add_argument("feed")

parser.add_argument('-a', '--author')
parser.add_argument('-b', '--body')

def get_pass(path):
    """Get pass value"""

    pass_show = Popen(['pass', 'show', path], stdout=PIPE)
    return pass_show.stdout.read().decode('utf-8').strip()

client_id = get_pass('computers/batcave/wallabag/client_id')
secret_id = get_pass('computers/batcave/wallabag/client_secret')
url = get_pass('computers/batcave/wallabag/url')
ids = get_pass(url).split('\n')
password = ids[0]
username = ids[1].replace('user: ', '')

redirect_uri = 'https://batcloud.me/wallabag/'
scope = 'https://batcloud.me/wallabag/api/entries.json'

args = parser.parse_args()

my_host = 'https://batcloud.me/wallabag'

async def main(loop):

    params = {'username': username,
              'password': password,
              'client_id': client_id,
              'client_secret': secret_id}

    # get a new token
    token = await Wallabag.get_token(host=my_host, **params)

    # initializing
    async with aiohttp.ClientSession(loop=loop) as session:
        wall = Wallabag(host=my_host,
                        client_secret=params.get('client_secret'),
                        client_id=params.get('client_id'),
                        token=token,
                        aio_sess=session)

        url = args.url
        title = args.title

        if args.body:
            body = args.body
            body = body.split('\n \n')
            body = ['<p>{}</p>'.format(p) for p in body]
            body = ''.join(body)

            authors = args.author

            await wall.post_entries(url, title, '', 0, 0, content=body, authors=authors)
        else:
            await wall.post_entries(url, title, '', 0, 0)

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main(loop))
