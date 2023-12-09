#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
# Get ANCMSP
"""

import datetime
import os
from subprocess import Popen, PIPE

import feedgenerator
import mechanicalsoup

def get_pass(path):
    """Get pass value"""

    pass_show = Popen(['pass', 'show', path], stdout=PIPE)
    return pass_show.stdout.read().decode('utf-8').strip()

class SympaBase:

    def __init__(self, data):
        self._data = data
        self.feed = feedgenerator.Rss201rev2Feed(title="ANCMSP",
                                                 link="http://listes.ancmsp.com/wws/",
                                                 description="Liste de diffusion de l'ANCMSP",
                                                 language="fr")
        self.rss = os.path.expanduser('~/.rss/{}.rss'.format(data['title'].lower()))
        self.br = mechanicalsoup.StatefulBrowser()

    def login(self):
        pwd = get_pass(self._data['pwd'])

        self.br.select_form('form[action="/wws"]')
        self.br['email'] = self._data['username']
        self.br['passwd'] = pwd
        self.br.submit_selected()

    def get_chrono_link(self):
        return self.br.find_link(text="Chronologique")

    def retrieve_emails(self):
        self.br.open(self._data['sympa_url'])
        self.login()

        url = '{}/arc/{}/'.format(self._data['sympa_url'], self._data['listname'])
        self.br.open(url)

        date = str(datetime.datetime.now().year) + '-' + str(datetime.datetime.now().month)
        date = '{}-{:02}'.format(datetime.datetime.now().year, datetime.datetime.now().month)

        link = self.get_chrono_link()
        self.br.open(url + date + '/' + link.get('href'))

        emails = self.br.links(url_regex="msg")

        for email in reversed(emails):
            print(email)
            self.feed.add_item(title=email.text,
                               link=url + date + email.get('href'),
                               author_name=email.get('em'),
                               description='')

        with open(self.rss, 'w') as rss_file:
            self.feed.write(rss_file, 'utf-8')

class SympaRenater(SympaBase):

    def __init__(self, data):
        super().__init__(data)

    def login(self):
        pwd = get_pass(self._data['pwd'])

        self.br.select_form('form[action="/wws"]')
        self.br.submit_selected()

        self.br.select_form()
        self.br['username'] = self._data['username']
        self.br['password'] = pwd
        self.br.submit_selected()

        self.br.launch_browser()

    def get_chrono_link(self):
        return self.br.find_link(text="Chronologique")

#  ANCMSP = SympaBase({'title': 'ANCMSP',
#                      'description': 'Liste de diffusion de l\'ANCMSP',
#                      'username': 'gabriel.alcaras@ehess.fr',
#                      'pwd': 'www/listes.ancmsp.com/gabriel.alcaras@ehess.fr',
#                      'sympa_url': 'http://listes.ancmsp.com/wws',
#                      'listname':'diffusion'})

#  ANCMSP.retrieve_emails()

TEUTH = SympaRenater({'title': 'Teuth',
                   'description': 'Histoire et sociologie des sciences',
                   'username': 'gabriel.alcaras@ehess.fr',
                   'pwd': 'www/listes.univ-rennes1.fr/gabriel.alcaras@ehess.fr',
                   'sympa_url': 'https://listes.univ-rennes1.fr/wws',
                   'listname': 'teuth'})
TEUTH.retrieve_emails()
