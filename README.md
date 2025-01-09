# Projeto Conceitual de Banco de Dados E-COMMERCE

## Explicação das Tabelas

### Cliente
Armazena informações sobre os clientes, com um campo `tipo_cliente` que pode ser 'PF' (Pessoa Física) ou 'PJ' (Pessoa Jurídica), de acordo com o tipo de cliente. O campo `cpf_cnpj` é utilizado para armazenar o CPF ou CNPJ do cliente, dependendo do tipo.

### Pagamento
Armazena informações sobre as formas de pagamento dos clientes, associando cada pagamento a um cliente específico (`id_cliente`). O campo `tipo_pagamento` permite identificar qual tipo de pagamento está sendo utilizado (cartão de crédito, boleto, transferência, etc.).

### Pedido
Armazena os pedidos feitos pelos clientes, com um campo `valor_total` que representa o valor total do pedido e um campo `status` para controlar o estado do pedido (por exemplo, "Em Andamento", "Concluído", "Cancelado").

### Entrega
Cada entrega está associada a um pedido específico e possui um campo `status_entrega` para indicar o progresso da entrega (por exemplo, "Em Processamento", "Enviado", "Entregue", "Cancelado"). O campo `codigo_rastreio` contém o código que pode ser usado para rastrear a entrega.

## Considerações Adicionais

- **Relacionalidade entre as tabelas:** As tabelas Pagamento, Pedido, e Entrega possuem chaves estrangeiras que fazem referência à tabela Cliente, criando os relacionamentos necessários.
- **Tipos de Dados:** O tipo ENUM foi usado para os campos que possuem valores predefinidos (ex: tipo de cliente, status de pedido, status de entrega).
- **Índices:** Foram criados índices para otimizar consultas com base nos campos `tipo_cliente`, `status` de pedidos e `status_entrega` de entregas. Isso ajuda a melhorar a performance em consultas frequentes relacionadas a esses campos.

## Como Testar

Para testar o banco de dados, basta executar os comandos SQL abaixo em um banco de dados MySQL ou MariaDB. Em seguida, insira alguns dados nas tabelas de Cliente, Pagamento, Pedido, e Entrega para validar a estrutura.

## Exemplo de Inserção de Dados

```sql
-- Inserção de um Cliente Pessoa Física
INSERT INTO Cliente (nome, cpf_cnpj, tipo_cliente, endereco, telefone, email)
VALUES ('João Silva', '123.456.789-00', 'PF', 'Rua A, 123', '987654321', 'joao@exemplo.com');

-- Inserção de uma Forma de Pagamento para o Cliente
INSERT INTO Pagamento (id_cliente, tipo_pagamento, detalhes_pagamento, status)
VALUES (1, 'Cartão de Crédito', 'Visa 1234-5678-9012-3456', 'Ativo');

-- Inserção de um Pedido
INSERT INTO Pedido (id_cliente, valor_total, status)
VALUES (1, 250.75, 'Em Andamento');

-- Inserção de uma Entrega para o Pedido
INSERT INTO Entrega (id_pedido, status_entrega, codigo_rastreio, data_entrega)
VALUES (1, 'Enviado', 'ABC123456789', '2025-01-10 14:30:00');
```
