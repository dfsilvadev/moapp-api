import { v4 as uuidv4 } from 'uuid';
import bcrypt from 'bcrypt';
import { CreateUserRepository } from '../repositories/create-user';

export class CreateUserUseCase {
  async execute({ name, email, password, createdAt }) {
    const userId = uuidv4();
    const salt = bcrypt.genSalt();
    const encryptedPassword = await bcrypt.hash(password, salt);

    const user = {
      id: userId,
      name,
      email,
      password: encryptedPassword,
      createdAt
    };

    const createUserRepository = new CreateUserRepository();
    return await createUserRepository.execute(user);
  }
}
