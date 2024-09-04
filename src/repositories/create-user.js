import { psql } from '../database/postgres/client';

export class CreateUserRepository {
  async execute({ id, name, email, password, createdAt }) {
    const row = await psql.query(
      `
      INSERT INTO contacts (id, name, email, password, createdAt)
      VALUES($1, $2, $3, $4, $5)
      RETURNING *`,
      [id, name, email, password, createdAt]
    );

    return row;
  }
}
