SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'your_table_name' AND table_schema = 'your_table_schema';
