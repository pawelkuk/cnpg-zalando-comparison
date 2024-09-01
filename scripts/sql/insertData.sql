CREATE TABLE IF NOT EXISTS large_data (
    id SERIAL PRIMARY KEY,
    random_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DO $$
DECLARE num_rows INTEGER := 100000;
-- Adjust this to control total size
i INTEGER := 0;
insert_text TEXT := repeat('A', 1024);
-- A 1KB string of repeated 'A'
BEGIN FOR i IN 1..num_rows LOOP
INSERT INTO large_data (random_text)
VALUES (insert_text);
END LOOP;
END $$;