import 'dotenv/config.js';
import express from 'express';

import { PostgresHelper } from './database/postgres/client.js';

const app = express();
const PORT = process.env.PORT;

app.get('/', async (req, res) => {
  const results = await PostgresHelper.query('SELECT * FROM TB_USER;');

  res.send(JSON.stringify(results));
});

app.listen(PORT, () =>
  // eslint-disable-next-line no-console
  console.log(`🔥 Server started at http://localhost:${PORT}`)
);
