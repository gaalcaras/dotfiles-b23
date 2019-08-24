#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
# Feed input from bookmark-cmd of newsboat to wallabag.
"""

import argparse
from subprocess import Popen, PIPE

import asyncio
import aiohttp
from wallabag_api.wallabag import Wallabag

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

client_id = get_pass('computers/batlab/wallabag/client_id')
secret_id = get_pass('computers/batlab/wallabag/client_secret')
password = get_pass('www/wallabag.batlab.me/gaalcaras')
username = 'gaalcaras'

redirect_uri = 'https://wallabag.batlab.me/'
scope = 'https://wallabag.batlab.me/api/entries.json'

args = parser.parse_args()

my_host = 'https://wallabag.batlab.me'

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

        url = args.url.strip()
        title = args.title.strip()

        if args.body:
            body = args.body
            body = body.split('\n \n')
            body = ['<p>{}</p>'.format(p) for p in body]
            body = ''.join(body)

            authors = args.author.strip()

            await wall.post_entries(url, title, '', 0, 0, content=body, authors=authors)
        else:
            await wall.post_entries(url, title, '', 0, 0)

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main(loop))
