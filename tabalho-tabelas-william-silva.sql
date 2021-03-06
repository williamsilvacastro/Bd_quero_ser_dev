create table GENEROS
(
CODIGO_GENERO SMALLINT NOT null primary key,
NOME_GENERO VARCHAR(50) NOT NULL

)
;



create table CLIENTES
(
CODIGO_CLIENTE SMALLINT NOT null primary KEY,
NR_CPF_CNPJ BIGINT null unique KEY,
NOME_RAZAO_SOCIAL VARCHAR(100) NOT null,
FLAG_PJ BIT NOT null,
CODIGO_GENERO SMALLINT NOT null,
FOREIGN KEY (CODIGO_GENERO) REFERENCES GENEROS (CODIGO_GENERO)
)
;


create table TELEFONE
(
CODIGO_TELEFONE SMALLINT  NOT null primary key,
NUMERO_TELEFONE VARCHAR(20) NOT NULL
)
;

create table CLIENTE_TELEFONE
(
CODIGO_CLIENTE SMALLINT  NOT null  ,
CODIGO_TELEFONE SMALLINT  NOT null  ,
TIPO_TELEFONE VARCHAR(50) NOT null,
APELIDO_TELEFONE VARCHAR(50) null,
FOREIGN KEY (CODIGO_CLIENTE) REFERENCES CLIENTES (CODIGO_CLIENTE),
FOREIGN KEY (CODIGO_TELEFONE) REFERENCES TELEFONE (CODIGO_TELEFONE),
primary key (CODIGO_CLIENTE, CODIGO_TELEFONE)
)
;

create table ESTADO
(
CODIGO_ESTADO SMALLINT NOT null primary key,
NOME_ESTADO VARCHAR(20) NOT NULL

)
;

create  table CIDADE
(
CODIGO_CIDADE SMALLINT NOT null primary key,
CODIGO_ESTADO SMALLINT NOT null,
NOME_CIDADE VARCHAR(50) NOT null,
foreign key (CODIGO_ESTADO) references ESTADO(CODIGO_ESTADO) 

)
;

create table RUA
(
CODIGO_RUA SMALLINT NOT null primary key,
NOME_RUA VARCHAR(100) NOT NULL
)
;

create table BAIRRO
(
CODIGO_BAIRRO SMALLINT NOT null primary key,
NOME_BAIRRO VARCHAR(100) NOT NULL

)
;

create table CEP
(
CODIGO_CEP SMALLINT NOT null primary key,
NUMERO_CEP VARCHAR(10) NOT NULL
)
;

create table ENDERECO
(
CODIGO_ENDERECO SMALLINT NOT null  primary key,
CODIGO_CIDADE  SMALLINT  NOT null,
CODIGO_BAIRRO  SMALLINT  NOT null,
CODIGO_RUA  SMALLINT  NOT null,
CODIGO_CEP SMALLINT  NOT null,
NUMERO VARCHAR(10) NOT null,
COMPLEMENTO VARCHAR(50) null,
PONTO_REFERENCIA VARCHAR(100) null,
foreign key (CODIGO_CIDADE) references CIDADE (CODIGO_CIDADE),
foreign key (CODIGO_BAIRRO) references BAIRRO (CODIGO_BAIRRO),
foreign key (CODIGO_RUA) references RUA (CODIGO_RUA),
foreign key (CODIGO_CEP) references CEP (CODIGO_CEP)

)
;

create table CLIENTE_ENDERECO
(
CODIGO_CLIENTE SMALLINT NOT null,
CODIGO_ENDERECO SMALLINT NOT null,
APELIDO VARCHAR(100) NOT null,
foreign key (CODIGO_CLIENTE) references CLIENTES(CODIGO_CLIENTE),
foreign key (CODIGO_ENDERECO) references ENDERECO(CODIGO_ENDERECO),
primary key (CODIGO_CLIENTE, CODIGO_ENDERECO)
)
;

create table LOJA
(
CODIGO_LOJA SMALLINT NOT null primary key,
CNPJ BIGINT NOT null,
NOME VARCHAR(100) NOT NULL
)
;

create table LOJA_ENDERECO
(
CODIGO_LOJA SMALLINT NOT null,
CODIGO_ENDERECO SMALLINT NOT null,
foreign key (CODIGO_ENDERECO) references ENDERECO(CODIGO_ENDERECO),
foreign key (CODIGO_LOJA) references LOJA(CODIGO_LOJA),
primary key (CODIGO_LOJA, CODIGO_ENDERECO)
)
;

create table CATEGORIA
(
CODIGO_CATEGORIA SMALLINT NOT null primary key,
NOME_CATEGORIA VARCHAR(100) NOT NULL

)
;

CREATE TABLE setor
(
codigo_setor SMALLINT NOT NULL PRIMARY KEY,
descricao varchar(50) NOT NULL
)
;

CREATE TABLE sub_setor
(
codigo_sub_setor SMALLINT NOT NULL PRIMARY KEY,
codigo_setor SMALLINT NOT NULL,
descricao_sub_setor varchar(150) NOT NULL, 
FOREIGN KEY (codigo_setor) REFERENCES setor(codigo_setor)
)
;

create table PRODUTOS
(
CODIGO_PRODUTO INT NOT null primary key,
CODIGO_CATEGORIA SMALLINT NOT null,
codigo_sub_setor SMALLINT NOT NULL,
descricao varchar(150) NOT NULL,
FOREIGN key (CODIGO_CATEGORIA) references CATEGORIA(CODIGO_CATEGORIA),
FOREIGN key (codigo_sub_setor) references sub_setor(codigo_sub_setor)
)
;

create table ESTOQUE 
(
CODIGO_PRODUTO INT  NOT null ,
CODIGO_LOJA SMALLINT  NOT null,
QUANTIDADE INT NOT null,
primary KEY(CODIGO_PRODUTO, CODIGO_LOJA),
foreign key (CODIGO_LOJA) references LOJA(CODIGO_LOJA),
foreign key (CODIGO_PRODUTO) references PRODUTOS(CODIGO_PRODUTO)
)
;


create table PEDIDOS_WEB
(
CODIGO_PEDIDO SMALLINT NOT null,
DATA_PEDIDO DATE NOT NULL,
primary KEY(CODIGO_PEDIDO)
)
;

create table NF 
(
CODIGO_NF SMALLINT NOT null primary key,
CODIGO_PEDIDO SMALLINT null,
CODIGO_CLIENTE SMALLINT NOT null,
CHAVE_ACESSO SMALLINT NOT null unique key,
SERIE VARCHAR(50) NOT null,
DATA_EMISSAO DATE NOT null,
foreign key (CODIGO_CLIENTE) references CLIENTES(CODIGO_CLIENTE),
FOREIGN KEY (CODIGO_PEDIDO) REFERENCES PEDIDOS_WEB(CODIGO_PEDIDO)
)
;




create table ITEM_NF
(
CODIGO_ITEM  SMALLINT NOT null,
CODIGO_NF SMALLINT NOT null,
CODIGO_PRODUTO INT NOT null,
QUANTIDADE_PRODUTO MEDIUMINT NOT null,
DESCONTO_PRODUTO DECIMAL(12,2) NOT null,
primary KEY(CODIGO_ITEM, CODIGO_NF),
foreign key (CODIGO_NF) references NF(CODIGO_NF),
foreign key (CODIGO_PRODUTO) references PRODUTOS(CODIGO_PRODUTO)
)
;

create table TRIBUTO
(
CODIGO_TRIBUTO SMALLINT NOT null primary key,
NOME_TRIBUTO VARCHAR(50) NOT null,
VALOR_TRIBUTO DECIMAL(12,2) NOT null
)
;

create table ITEM_TRIBUTO
(
CODIGO_ITEM SMALLINT NOT null,
CODIGO_TRIBUTO SMALLINT NOT null,
CODIGO_NF  SMALLINT NOT NULL,
primary key (CODIGO_ITEM, CODIGO_TRIBUTO, CODIGO_NF),
foreign key (CODIGO_ITEM) references ITEM_NF(CODIGO_ITEM),
foreign key (CODIGO_TRIBUTO) references TRIBUTO(CODIGO_TRIBUTO),
FOREIGN KEY (CODIGO_NF) REFERENCES ITEM_NF(CODIGO_NF)
)
;

create table FORMA_PAGAMENTO
(
CODIGO_FORMA_PAGAMENTO SMALLINT NOT null primary key,
NOME_FORMA_PAGAMENTO VARCHAR(20) NOT NULL
)
;

create table NF_FORMA_PAGAMENTO
(
CODIGO_NF SMALLINT NOT null,
CODIGO_FORMA_PAGAMENTO SMALLINT NOT null,
primary key (CODIGO_NF, CODIGO_FORMA_PAGAMENTO),
foreign key (CODIGO_FORMA_PAGAMENTO) references FORMA_PAGAMENTO(CODIGO_FORMA_PAGAMENTO),
foreign key (CODIGO_NF) references NF(CODIGO_NF)
)
;



CREATE TABLE preco_compra
(
codigo_produto int NOT NULL,
data_vigencia date NOT NULL,
valor_preco decimal(12,2),
FOREIGN KEY (codigo_produto) REFERENCES PRODUTOS(codigo_produto),
PRIMARY key(codigo_produto, data_vigencia)
)
;







































