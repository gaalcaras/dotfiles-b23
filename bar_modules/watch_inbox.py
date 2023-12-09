"""
Watch local mail inbox
"""

import os
import email
import re
import datetime

from glob import glob
from subprocess import Popen, PIPE

EMAIL = '~/.email'
SENDQUEUE = '~/.msmtpqueue'
EARLIER = '09:30'
LATER = '19:30'

def get_my_emails(accounts):
    """Get email addresses from accounts"""

    my_emails = []
    for account in accounts:
        pass_show = Popen(['pass', 'show', 'email/{}/user'.format(account)], stdout=PIPE)
        my_emails.append(pass_show.stdout.read().decode('utf-8').strip())

    return my_emails

MY_EMAILS = get_my_emails(['gmail.com', 'ehess.fr', 'telecom-paristech.fr'])

def run_function_between(callback, earlier='', later=''):
    """Print msg between set times"""

    now = datetime.datetime.now()
    earlier = datetime.datetime.strptime(earlier, '%H:%M')
    later = datetime.datetime.strptime(later, '%H:%M')

    today_earlier = now.replace(hour=earlier.hour, minute=earlier.minute, second=0)
    today_later = now.replace(hour=later.hour, minute=later.minute, second=0)

    if (today_earlier <= now <= today_later) and (now.isoweekday() in range(1, 6)):
        callback()
    else:
        print('')

def get_inbox_emails(email_root):
    """Return list of all emails in inboxes at the email root directory"""

    email_dir = os.path.expanduser(email_root)
    return glob(email_dir + '/*/inbox/*/*')

def get_new_emails(emails):
    """Return new emails in inboxes"""

    return [e for e in emails if '/new/' in e]

def get_header_field(msg, field):
    """Return decoded header field from msg"""

    field = email.header.decode_header(msg[field])[0][0]
    if not isinstance(field, str):
        field = field.decode('utf-8')

    return field

def get_direct_emails(emails, addresses):
    """Return emails directly sent to addresses in given emails"""

    direct = []
    cced = []
    for msg_path in emails:
        try:
            msg_f = open(msg_path, 'r', encoding='utf8')
            msg = email.message_from_file(msg_f)
        except UnicodeDecodeError:
            msg_f = open(msg_path, 'r', encoding='latin1')
            msg = email.message_from_file(msg_f)

        try:
            msg_to = get_header_field(msg, 'To')
            msg_cc = get_header_field(msg, 'Cc')
            recipients = msg_to + '\n' + msg_cc

            if any(e in recipients for e in addresses):
                if any(e in msg_to for e in addresses) and len(re.split(r'[\n,]', msg_to)) == 1:
                    direct.append(msg_path)
                else:
                    cced.append(msg_path)
        except:
            continue

    return (direct, cced)

def get_nb_new(emails):
    """Return formatted string with number of new emails"""

    if emails:
        return '{}/'.format(len(emails))

    return ''

def fmt_section(prefix='', total='', new='', suffix=' · '):
    """Return formatted section"""

    section = ''
    if total or new:
        section = '{}{}{}{}'.format(prefix, new, total, suffix)

    return section

def get_inbox_status():
    """Return current inbox status"""

    emails = get_inbox_emails(EMAIL)
    new = get_new_emails(emails)
    (direct, cced) = get_direct_emails(emails, MY_EMAILS)

    nb_total = len(emails)
    nb_direct = len(direct)
    nb_cced = len(cced)

    nb_total_new = get_nb_new(new)
    nb_direct_new = get_nb_new(get_new_emails(direct))
    nb_cced_new = get_nb_new(get_new_emails(cced))

    direct = fmt_section(' ', nb_direct, nb_direct_new)
    cced = fmt_section(' ', nb_cced, nb_cced_new)
    total = fmt_section(' ', nb_total, nb_total_new, '')

    msg = '{}{}{}'.format(direct, cced, total)

    return msg

def get_send_queue():
    """Return status of sending queue"""

    msmtp = os.path.expanduser(SENDQUEUE)


    msg = ''
    nb_inqueue = len(glob(msmtp + '/*.mail'))
    if nb_inqueue > 0:
        if os.path.isfile(msmtp + '/.lock'):
            symbol = ''
        else:
            symbol = ''

        msg = '{} {}'.format(symbol, nb_inqueue)

    return msg

def generate_message():
    """Generate_message for polybar module"""

    message = get_inbox_status()

    queue = get_send_queue()

    if queue and message:
        message += ' · ' + queue
    else:
        message += queue

    print(message)

run_function_between(generate_message, EARLIER, LATER)
