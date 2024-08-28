-- Criando a tabela TB_USER
CREATE TABLE IF NOT EXISTS TB_USER (
    id UUID PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    password VARCHAR NOT NULL,
    createdAt TIMESTAMP NOT NULL
);

-- Criando índice para a coluna email
CREATE INDEX idx_email ON TB_USER (email);

-- Criando a tabela TB_EXPENSE_LIMIT
CREATE TABLE IF NOT EXISTS TB_EXPENSE_LIMIT (
    id UUID PRIMARY KEY,
    amount NUMERIC(10,2) NOT NULL,
    userId UUID NOT NULL,
    CONSTRAINT fk_userid FOREIGN KEY (userId) REFERENCES TB_USER(id),
    CONSTRAINT idx_userid UNIQUE (userId)
);

-- Criando índice para a coluna userId
CREATE INDEX idx_userId_limit ON TB_EXPENSE_LIMIT (userId);

-- Criando o tipo ENUM para TB_TYPE
CREATE TYPE TB_TYPE_ENUM AS ENUM ('income', 'outcome');

-- Criando a tabela TB_TYPE
CREATE TABLE IF NOT EXISTS TB_TYPE (
    id UUID PRIMARY KEY,
    name TB_TYPE_ENUM NOT NULL
);

-- Criando o tipo ENUM para TB_FREQUENCY
CREATE TYPE TB_FREQUENCY_ENUM AS ENUM ('recurring', 'occasional');

-- Criando a tabela TB_FREQUENCY
CREATE TABLE IF NOT EXISTS TB_FREQUENCY (
    id UUID PRIMARY KEY,
    name TB_FREQUENCY_ENUM NOT NULL
);

-- Criando o tipo ENUM para TB_CATEGORY
CREATE TYPE TB_CATEGORY_ENUM AS ENUM ('food', 'car', 'home', 'investments', 'leisure', 'studies', 'health', 'subscriptions', 'others');

-- Criando a tabela TB_CATEGORY
CREATE TABLE IF NOT EXISTS TB_CATEGORY (
    id UUID PRIMARY KEY,
    name TB_CATEGORY_ENUM NOT NULL
);

-- Criando a tabela TB_TRANSACTION
CREATE TABLE IF NOT EXISTS TB_TRANSACTION (
    id UUID PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    createdAt TIMESTAMP NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    description VARCHAR(250),
    userId UUID NOT NULL,
    typeId UUID NOT NULL,
    frequencyId UUID NOT NULL,
    categoryId UUID NOT NULL,
    CONSTRAINT fk_userid FOREIGN KEY (userId) REFERENCES TB_USER(id),
    CONSTRAINT fk_typeid FOREIGN KEY (typeId) REFERENCES TB_TYPE(id),
    CONSTRAINT fk_frequencyid FOREIGN KEY (frequencyId) REFERENCES TB_FREQUENCY(id),
    CONSTRAINT fk_categoryid FOREIGN KEY (categoryId) REFERENCES TB_CATEGORY(id)
);

-- Criando índice para as colunas createdAt
CREATE INDEX idx_createdAt ON TB_TRANSACTION (createdAt);

-- Criando índice para as colunas userId e createdAt
CREATE INDEX idx_user_createdAt ON TB_TRANSACTION (userId, createdAt);

-- Criando índice para as colunas typeId e categoryId
CREATE INDEX idx_type_categoryId ON TB_TRANSACTION (typeId, categoryId);