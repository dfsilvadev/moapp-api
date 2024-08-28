import pg from 'pg';

const { Pool } = pg;

const pool = new Pool({
  user: process.env.PSQL_USER,
  password: process.env.PSQL_PASSWORD,
  port: process.env.PSQL_PORT,
  database: process.env.PSQL_DATABASE
});

const PostgresHelper = {
  query: async (query, values) => {
    const client = await pool.connect();
    const { rows } = await client.query(query, values);

    await client.release();
    return rows;
  }
};

export { pool, PostgresHelper };
