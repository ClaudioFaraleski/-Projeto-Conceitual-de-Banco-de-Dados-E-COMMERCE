-- Criação da tabela de Clientes
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,      -- Identificador único para cada cliente
    nome VARCHAR(255) NOT NULL,                      -- Nome do cliente
    cpf_cnpj VARCHAR(18) NOT NULL,                   -- CPF ou CNPJ do cliente (formato variável)
    tipo_cliente ENUM('PF', 'PJ') NOT NULL,          -- Tipo de cliente (Pessoa Física ou Jurídica)
    endereco VARCHAR(255),                           -- Endereço do cliente
    telefone VARCHAR(15),                            -- Telefone do cliente
    email VARCHAR(100)                               -- Email do cliente
);

-- Criação da tabela de Pagamentos
CREATE TABLE Pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,    -- Identificador único para cada forma de pagamento
    id_cliente INT,                                  -- ID do cliente (chave estrangeira)
    tipo_pagamento ENUM('Cartão de Crédito', 'Boleto', 'Transferência', 'Pix', 'Dinheiro') NOT NULL,  -- Tipo de pagamento
    detalhes_pagamento TEXT,                         -- Detalhes sobre a forma de pagamento (ex: número do cartão, dados bancários)
    status ENUM('Ativo', 'Inativo') DEFAULT 'Ativo', -- Status da forma de pagamento
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE -- Relacionamento com a tabela Cliente
);

-- Criação da tabela de Pedidos
CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,        -- Identificador único para cada pedido
    id_cliente INT,                                  -- ID do cliente (chave estrangeira)
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,   -- Data e hora do pedido
    valor_total DECIMAL(10, 2) NOT NULL,              -- Valor total do pedido
    status ENUM('Em Andamento', 'Concluído', 'Cancelado') NOT NULL,  -- Status do pedido
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE -- Relacionamento com a tabela Cliente
);

-- Criação da tabela de Entregas
CREATE TABLE Entrega (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT,       -- Identificador único para cada entrega
    id_pedido INT,                                   -- ID do pedido (chave estrangeira)
    status_entrega ENUM('Em Processamento', 'Enviado', 'Entregue', 'Cancelado') NOT NULL, -- Status da entrega
    codigo_rastreio VARCHAR(100),                     -- Código de rastreio da entrega
    data_entrega DATETIME,                           -- Data e hora da entrega
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP, -- Data e hora de criação do registro de entrega
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE -- Relacionamento com a tabela Pedido
);

-- Índices adicionais para otimizar consultas
CREATE INDEX idx_cliente_tipo_cliente ON Cliente(tipo_cliente);
CREATE INDEX idx_pedido_status ON Pedido(status);
CREATE INDEX idx_entrega_status ON Entrega(status_entrega);
