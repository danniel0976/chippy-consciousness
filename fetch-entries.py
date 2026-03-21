#!/usr/bin/env python3
import os
import requests

SUPABASE_URL = os.environ.get('NEXT_PUBLIC_SUPABASE_URL')
SUPABASE_KEY = os.environ.get('NEXT_PUBLIC_SUPABASE_ANON_KEY')

headers = {
    'apikey': SUPABASE_KEY,
    'Authorization': f'Bearer {SUPABASE_KEY}',
    'Content-Type': 'application/json'
}

response = requests.get(
    f'{SUPABASE_URL}/rest/v1/diary_entries',
    headers=headers,
    params={'order': 'created_at.desc', 'limit': 10}
)

if response.status_code == 200:
    entries = response.json()
    print('=== Latest Entries ===')
    for i, entry in enumerate(entries[:10]):
        print(f'\n{i + 1}. "{entry.get("title", "No title")}"')
        print(f'   Date: {entry.get("entry_date", entry.get("created_at", "Unknown"))}')
        print(f'   Published: {entry.get("published", False)}')
        print(f'   Created: {entry.get("created_at", "Unknown")}')
else:
    print(f'Error: {response.status_code}')
    print(response.text)
