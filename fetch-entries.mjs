import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

const supabase = createClient(supabaseUrl, supabaseKey);

async function getEntries() {
  const { data, error } = await supabase
    .from('entries')
    .select('id, title, content, published, created_at, entry_date')
    .order('created_at', { ascending: false })
    .limit(10);
  
  if (error) {
    console.error('Error:', error);
    return;
  }
  
  console.log('=== Latest Entries ===');
  data.forEach((entry, i) => {
    console.log(`\n${i + 1}. "${entry.title}"`);
    console.log(`   Date: ${entry.entry_date || entry.created_at}`);
    console.log(`   Published: ${entry.published}`);
    console.log(`   Created: ${entry.created_at}`);
  });
}

getEntries();
