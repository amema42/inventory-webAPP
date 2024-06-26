-- Creazione della tabella (main) articles
CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  description TEXT,
  quantity INT,
  size VARCHAR(1) CHECK (size IN ('L', 'S', 'M'))
);

-- nuova tabella per lo storico delle azioni sui prodotti
CREATE TABLE history (
  id SERIAL PRIMARY KEY,
  article_id INT REFERENCES articles(id),
  action_type VARCHAR(50), -- def. tipo di azione: sggiuynta/rimozione...
  action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  details TEXT -- Dettagli ipertext aggiuntivi, se necessario
);

-- Insert: alcuni articoli di esempio, preInseriti
INSERT INTO articles (name, description, quantity, size) VALUES
('Article 1', 'Description for Article 1', 10, 'L'),
('Article 2', 'Description for Article 2', 20, 'S'),
('Article 3', 'Description for Article 3', 30, 'M');

-- Rimuovi il vincolo di chiave esterna esistente
ALTER TABLE history DROP CONSTRAINT history_article_id_fkey;

-- aggiungo il nuovo ***vincolo*** di chiave esterna con ON DELETE CASCADE
-- app.delete -> in backend/index.js modificata (aggiunto controllo per delete article)
ALTER TABLE history
ADD CONSTRAINT history_article_id_fkey FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE;
