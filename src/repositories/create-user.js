import { psql } from '../database/postgres/client';
import bcrypt from 'bcrypt';

export class CreateUserRepository {
  async execute({ name, email, password }) {
    const salt = bcrypt.genSalt();
    const encryptedPassword = await bcrypt.hash(password, salt);

    const row = await psql.query(
      `
      INSERT INTO contacts (name, email, password, createdAt)
      VALUES($1, $2, $3, $4)
      RETURNING *`,
      [name, email, encryptedPassword, new Date()]
    );

    return row;
  }
}
