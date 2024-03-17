-- Criar tabela Clientes
CREATE TABLE CLIENTES
(
    ID INT PRIMARY KEY,
    NOME VARCHAR(100),
    TELEFONE VARCHAR(20)
);

-- Criar tabela Filmes
CREATE TABLE FILMES
(
    ID INT PRIMARY KEY,
    TITULO VARCHAR(100),
    ANOLANCAMENTO INT,
    DURACAO INT
);

-- Criar tabela Generos
CREATE TABLE GENEROS
(
    ID INT PRIMARY KEY,
    DESCRICAO VARCHAR(50)
);

-- Criar tabela Emprestimos
CREATE TABLE EMPRESTIMOS
(
    ID INT PRIMARY KEY,
    CLIENTEID INT,
    FILMEID INT,
    DATARETIRADA DATE,
    DATADEVOLUCAO DATE,
    VALORPAGO DECIMAL(10, 2),
    FOREIGN KEY ( CLIENTEID )
        REFERENCES CLIENTES ( ID ),
    FOREIGN KEY ( FILMEID )
        REFERENCES FILMES ( ID )
);

-- Inserir alguns registros de exemplo na tabela Clientes
INSERT INTO CLIENTES
    (ID, NOME, TELEFONE)
VALUES
    (1, 'João Silva', '(21)1234567890'),
    (2, 'Maria Oliveira', '(21)9876543210'),
    (3, 'Carlos Santos', '(11)55556666');


-- Inserir alguns registros de exemplo na tabela Filmes
INSERT INTO FILMES
    (ID, TITULO, ANOLANCAMENTO, DURACAO)
VALUES
    (1, 'Matrix', 1999, 136),
    (2, 'O Poderoso Chefão', 1972, 175),
    (3, 'Interestelar', 2014, 169);

-- Inserir alguns registros de exemplo na tabela Generos
INSERT INTO GENEROS
    (ID, DESCRICAO)
VALUES
    (1, 'Aventura'),
    (2, 'Drama'),
    (3, 'Ficção Científica');

-- Inserir alguns registros de exemplo na tabela Emprestimos
INSERT INTO EMPRESTIMOS
    (ID, CLIENTEID, FILMEID, DATARETIRADA, DATADEVOLUCAO, VALORPAGO)
VALUES
    (1, 1, 1, '2013-06-01', '2013-06-10', 5.00),
    (2, 2, 2, '2013-04-15', '2013-04-20', 4.50),
    (3, 1, 3, '2013-01-20', '2013-01-25', 3.75);

-- Lista de clientes cujo telefone seja do Rio de Janeiro (código de área 21)
SELECT *
FROM CLIENTES
WHERE TELEFONE LIKE '(21)%';

-- Empréstimos feitos no primeiro semestre de 2013, exibidos do mais recente para o mais antigo.
SELECT *
FROM EMPRESTIMOS
WHERE YEAR(DATARETIRADA) = 2013
    AND MONTH(DATARETIRADA) <= 6
ORDER BY DATARETIRADA DESC;

-- Clientes cujo nome (incluindo espaços) tenha mais de 15 caracteres.
SELECT *
FROM CLIENTES
WHERE LENGTH (NOME) > 15;

-- Nomes de pessoas no banco de dados incluindo atores, diretores de filmes e clientes.
    SELECT NOME
    FROM CLIENTES
UNION
    SELECT NOME
    FROM ATORES
UNION
    SELECT NOME
    FROM DIRETORES;

-- Empréstimos cuja data de devolução está, pelo menos, 7 dias posterior em relação à data de retirada.
SELECT *
FROM EMPRESTIMOS
WHERE DATEDIFF(DATADEVOLUCAO, DATARETIRADA) >= 7;

-- Filmes de aventura ou drama com duração superior a duas horas.
SELECT DISTINCT FILMES.TITULO
FROM FILMES
    JOIN GENEROS ON FILMES.IDGENERO = GENEROS.ID
WHERE GENEROS.DESCRICAO IN ( 'Aventura', 'Drama' )
    AND FILMES.DURACAO > 120;

-- 5 filmes mais antigos do acervo.
SELECT *
FROM FILMES
ORDER BY AnoLancamento ASC LIMIT 1;

-- Menor valor pago por um empréstimo.
SELECT MIN
(ValorPago) AS MenorValorPago FROM Emprestimos;

-- Empréstimos realizados no ano de 2013.
SELECT COUNT(*) AS NumEmprestimos
FROM Emprestimos
WHERE YEAR(DataRetirada) = 2013;

-- Média da diferença entre data de retorno e data de devolução dos empréstimos.
SELECT AVG(DATEDIFF(DataDevolucao, DataRetirada)) AS MediaDiasDevolucao
FROM Emprestimos;