#!/usr/bin/env python3
"""
Mark an entry as email_sent = true in Supabase

Usage:
    python mark-entry-sent.py --slug "yan-i-broke-your-trust"
"""

import argparse
import os
import requests

SUPABASE_URL = 'https://rtvrfzfgudmqanhqkxir.supabase.co'
SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ0dnJmemZndWRtcWFuaHFreGlyIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MzU0MTg4NywiZXhwIjoyMDg5MTE3ODg3fQ.J7-u-w8XSmtTb0tNJascYA1S0PUcEBVQjNpIu7uXJoc'

def mark_entry_sent(slug):
    headers = {
        'apikey': SUPABASE_KEY,
        'Authorization': f'Bearer {SUPABASE_KEY}',
        'Content-Type': 'application/json',
        'Prefer': 'return=representation'
    }
    
    # First get the entry id
    response = requests.get(
        f'{SUPABASE_URL}/rest/v1/diary_entries?slug=eq.{slug}&select=id,email_sent',
        headers=headers
    )
    
    if response.status_code != 200:
        print(f'Error fetching entry: {response.status_code}')
        print(response.text)
        return False
    
    entries = response.json()
    if not entries or len(entries) == 0:
        print(f'No entry found with slug: {slug}')
        return False
    
    entry = entries[0]
    entry_id = entry['id']
    already_sent = entry.get('email_sent', False)
    
    if already_sent:
        print(f'Entry "{entry.get("title")}" already marked as email_sent=true')
        return True
    
    # Update to mark as sent
    response = requests.patch(
        f'{SUPABASE_URL}/rest/v1/diary_entries?id=eq.{entry_id}',
        headers=headers,
        json={'email_sent': True}
    )
    
    if response.status_code in [200, 204]:
        print(f'✅ Marked entry as email_sent=true')
        print(f'   Entry: {entry.get("title")}')
        print(f'   Slug: {slug}')
        print(f'   ID: {entry_id}')
        return True
    else:
        print(f'Error updating entry: {response.status_code}')
        print(response.text)
        return False

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Mark entry as email sent')
    parser.add_argument('--slug', required=True, help='Entry slug')
    args = parser.parse_args()
    
    mark_entry_sent(args.slug)
