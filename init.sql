-- init.sql — PetNuvem
-- Script de inicialização do banco de dados PostgreSQL.
-- Executado automaticamente pelo entrypoint do container na primeira inicialização.

-- ============================================================
-- Requisito 1: tabela categorias com chave primária
-- ============================================================
CREATE TABLE categorias (
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    descricao   TEXT
);

-- ============================================================
-- Requisito 2 e 3: tabela produtos com chave primária,
-- chave estrangeira para categorias e coluna imagem_url
-- para armazenar o endereço da imagem no Amazon S3.
-- ============================================================
CREATE TABLE produtos (
    id           SERIAL PRIMARY KEY,
    nome         VARCHAR(150)   NOT NULL,
    descricao    TEXT,
    preco        NUMERIC(10, 2) NOT NULL,
    estoque      INTEGER        NOT NULL DEFAULT 0,
    categoria_id INTEGER        NOT NULL
                     REFERENCES categorias (id) ON DELETE RESTRICT,
    imagem_url   VARCHAR(500),          -- endereço do objeto no Amazon S3
    criado_em    TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================
-- Requisito 4: pelo menos cinco registros em categorias
-- ============================================================
INSERT INTO categorias (nome, descricao) VALUES
    ('Alimentação',    'Rações, petiscos e suplementos para pets'),
    ('Higiene',        'Produtos de banho, tosa e limpeza'),
    ('Saúde',          'Medicamentos, vitaminas e acessórios veterinários'),
    ('Brinquedos',     'Brinquedos e itens de entretenimento para pets'),
    ('Cama e Repouso', 'Camas, casinhas e cobertores para o descanso dos pets'),
    ('Coleiras e Guias', 'Coleiras, guias e acessórios de passeio');

-- ============================================================
-- Requisito 4 e 5: pelo menos cinco registros em produtos,
-- com categoria_id correspondendo a categorias existentes.
--
-- As URLs abaixo são FICTÍCIAS e servem apenas como exemplo
-- do padrão de endereço de objetos armazenados no Amazon S3.
-- Os arquivos NÃO existem em nenhum bucket real.
-- ============================================================
INSERT INTO produtos (nome, descricao, preco, estoque, categoria_id, imagem_url) VALUES
    (
        'Ração Premium Cães Adultos 15 kg',
        'Ração super-premium para cães adultos de raças médias e grandes',
        189.90,
        50,
        1,  -- Alimentação
        'https://s3.amazonaws.com/petnuvem-produtos-exemplo/alimentacao/racao-premium-caes-adultos.jpg'
    ),
    (
        'Petisco Bifinho Frango 500 g',
        'Petisco natural de frango, ideal para treinamento e recompensa',
        34.50,
        120,
        1,  -- Alimentação
        'https://s3.amazonaws.com/petnuvem-produtos-exemplo/alimentacao/petisco-bifinho-frango.jpg'
    ),
    (
        'Shampoo Neutro para Cães e Gatos 500 ml',
        'Shampoo hipoalergênico de pH neutro, ideal para peles sensíveis',
        28.90,
        80,
        2,  -- Higiene
        'https://s3.amazonaws.com/petnuvem-produtos-exemplo/higiene/shampoo-neutro-pets.jpg'
    ),
    (
        'Vermífugo Oral para Cães até 10 kg',
        'Comprimido vermífugo de amplo espectro para cães de pequeno porte',
        22.00,
        200,
        3,  -- Saúde
        'https://s3.amazonaws.com/petnuvem-produtos-exemplo/saude/vermifugo-oral-caes-10kg.jpg'
    ),
    (
        'Bola de Borracha Natural com Apito',
        'Bola resistente com apito interno, perfeita para cães agitados',
        19.90,
        150,
        4,  -- Brinquedos
        'https://s3.amazonaws.com/petnuvem-produtos-exemplo/brinquedos/bola-borracha-apito.jpg'
    ),
    (
        'Cama Ortopédica Pet G',
        'Cama com espuma de alta densidade para o conforto de pets de grande porte',
        249.00,
        30,
        5,  -- Cama e Repouso
        'https://s3.amazonaws.com/petnuvem-produtos-exemplo/cama-repouso/cama-ortopedica-g.jpg'
    ),
    (
        'Coleira Regulável com Fivela de Segurança P',
        'Coleira leve e resistente para cães e gatos de pequeno porte',
        39.90,
        90,
        6,  -- Coleiras e Guias
        'https://s3.amazonaws.com/petnuvem-produtos-exemplo/coleiras/coleira-regulavel-seguranca-p.jpg'
    );
