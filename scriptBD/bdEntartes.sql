-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: entartes
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE SCHEMA IF NOT EXISTS entartes;
USE entartes;

--
-- Table structure for table `alunos`
--

DROP TABLE IF EXISTS `alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alunos` (
  `utilizador_id` int NOT NULL,
  `notas` text,
  PRIMARY KEY (`utilizador_id`),
  CONSTRAINT `fk_alunos_utilizador` FOREIGN KEY (`utilizador_id`) REFERENCES `utilizadores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos`
--

LOCK TABLES `alunos` WRITE;
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
INSERT INTO `alunos` VALUES (2,'Aluno existente — nível intermédio'),(6,'Iniciante — começou em setembro'),(7,'Intermédio — boa progressão'),(8,'Iniciante — primeira vez na escola'),(9,'Avançado — participa em competições'),(10,'Iniciante — necessita de atenção extra');
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;
UNLOCK TABLES;

-- -----------------------------------------------------
-- Table structure for table `artigos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artigos`;

CREATE TABLE `artigos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `descricao` text,

  -- Campos de Marketplace agora opcionais (NULL)
  `tamanho` varchar(50) DEFAULT NULL,
  `cor` varchar(50) DEFAULT NULL,
  `condicao` ENUM('Novo','Como novo','Bom estado','Usado') DEFAULT NULL,

  `dono_utilizador_id` int NOT NULL,

  -- Flags de Tipo de Negócio
  `is_venda` tinyint(1) NOT NULL DEFAULT '0',
  `is_aluguer` tinyint(1) NOT NULL DEFAULT '0',
  `is_doacao` tinyint(1) NOT NULL DEFAULT '0',

  `arquivado` tinyint(1) NOT NULL DEFAULT '0',
  `aprovado` tinyint(1) NOT NULL DEFAULT '1',

  -- Preços Distintos
  `preco_venda` decimal(10,2) DEFAULT NULL,
  `preco_aluguer` decimal(10,2) DEFAULT NULL,

  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),

  -- Índices para performance
  KEY `idx_dono` (`dono_utilizador_id`),
  KEY `idx_cor` (`cor`),
  KEY `idx_condicao` (`condicao`),
  KEY `idx_arquivado` (`arquivado`),
  KEY `idx_aprovado` (`aprovado`),
  KEY `idx_is_venda` (`is_venda`),
  KEY `idx_is_aluguer` (`is_aluguer`),
  KEY `idx_is_doacao` (`is_doacao`),

  CONSTRAINT `fk_artigos_utilizador`
    FOREIGN KEY (`dono_utilizador_id`)
    REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- -----------------------------------------------------
-- Dados de teste
-- -----------------------------------------------------
LOCK TABLES `artigos` WRITE;

INSERT INTO `artigos`
(`id`, `nome`, `descricao`, `tamanho`, `cor`, `condicao`, `dono_utilizador_id`,
 `is_venda`, `is_aluguer`, `is_doacao`, `arquivado`, `aprovado`,
 `preco_venda`, `preco_aluguer`, `criado_em`)
VALUES
(1,'Sapatilhas de Ballet Freed','Sapatilhas de meia ponta, couro, marca Freed of London','36','Rosa','Como novo',1,1,0,0,0,1,45.00,NULL,'2025-10-01 10:00:00'),
(2,'Sapatilhas de Ballet Freed','Sapatilhas de meia ponta, couro, marca Freed of London','38','Rosa','Usado',1,1,0,0,0,1,45.00,NULL,'2025-10-01 10:00:00'),
(3,'Sapatilhas de Ponta Bloch','Sapatilhas de ponta, sola reforçada, marca Bloch','37','Rosa','Novo',1,1,1,0,0,1,85.00,15.00,'2025-10-01 10:00:00'),
(4,'Collant Preto Energetiks','Collant inteiro preto para aulas de dança','S','Preto','Como novo',1,1,0,0,0,1,22.00,NULL,'2025-10-01 10:00:00'),
(5,'Fato de Treino Nike','Fato de treino unissexo para hip hop e jazz','L','Preto','Usado',1,1,0,0,0,1,60.00,NULL,'2025-11-15 09:00:00'),
(6,'Tapete de Yoga Manduka','Tapete antiderrapante 6mm, 180x60cm','180cm','Verde','Como novo',1,0,1,0,0,1,NULL,10.00,'2025-11-15 09:00:00'),
(7,'Leggings Mirella','Leggings de alta compressão marca Mirella','S','Preto','Usado',1,1,0,0,0,1,18.00,NULL,'2025-09-01 08:00:00'),
(8, 'Sapatos de Dança de Salão', 'Sapatos com salto de 5cm, ideais para jazz ou ritmos latinos', '37', 'Dourado', 'Bom estado', 2, 1, 0, 0, 0, 1, 35.00, NULL, '2026-03-10 14:00:00'),
(9, 'Barras de Alongamento Portáteis', 'Barra dupla de ferro leve ajustável para treino em casa', 'Único', 'Cinza', 'Como novo', 1, 0, 1, 0, 0, 1, NULL, 12.50, '2026-03-15 11:20:00'),
(10, 'CDs de Música Clássica para Treino', 'Coletânea de reportório musical clássico para exames de ballet', 'N/A', 'Multicor', 'Usado', 3, 0, 0, 1, 0, 1, NULL, NULL, '2026-03-18 16:45:00');

UNLOCK TABLES;

-- -----------------------------------------------------
-- Table `token_recuperacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `token_recuperacao`;

CREATE TABLE `token_recuperacao` (
  `id`            INT          NOT NULL AUTO_INCREMENT,
  `id_utilizador` INT          NOT NULL,  -- Utilizador que pediu a recuperação
  `token`         VARCHAR(127) NOT NULL,  -- Código de 6 dígitos (ou hash)
  `expira_em`     DATETIME     NOT NULL,  -- Data/hora de expiração do token

  PRIMARY KEY (`id`),

  CONSTRAINT `fk_token_utilizador`
    FOREIGN KEY (`id_utilizador`)
    REFERENCES `utilizadores` (`id`)
    ON DELETE CASCADE  -- Ao apagar o utilizador, os tokens são apagados automaticamente

) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `transacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transacao`;

CREATE TABLE `transacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `artigo_id` INT NOT NULL,            -- Referência ao anúncio/artigo no Marketplace
  `comprador_id` INT NOT NULL,         -- Utilizador que está a comprar/alugar
  `vendedor_id` INT NOT NULL,          -- Guardamos o vendedor para facilitar consultas (redundância útil)
  
  `tipo` ENUM('VENDA', 'ALUGUER', 'DOACAO') NOT NULL,
  
  `data_transacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  -- Datas específicas para Aluguer
  `data_inicio` DATE NULL,
  `data_fim_prevista` DATE NULL,
  `data_devolucao_real` DATE NULL,
  
  `valor_final` DECIMAL(10,2) NOT NULL, -- O preço acordado (pode ser preco_venda ou preco_aluguer)
  `estado_transacao` ENUM('PENDENTE', 'CONCLUIDA', 'CANCELADA', 'DEVOLVIDA') DEFAULT 'CONCLUIDA',
  
  PRIMARY KEY (`id`),
  
  CONSTRAINT `fk_transacao_artigo`
    FOREIGN KEY (`artigo_id`)
    REFERENCES `artigos` (`id`)
    ON DELETE RESTRICT,
    
  CONSTRAINT `fk_transacao_comprador`
    FOREIGN KEY (`comprador_id`)
    REFERENCES `utilizadores` (`id`)
    ON DELETE RESTRICT,
    
  CONSTRAINT `fk_transacao_vendedor`
    FOREIGN KEY (`vendedor_id`)
    REFERENCES `utilizadores` (`id`)
    ON DELETE RESTRICT
) ENGINE = InnoDB;


--
-- Table structure for table `auditoria_log`
--

DROP TABLE IF EXISTS `auditoria_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_utilizador` int NOT NULL,
  `acao` text NOT NULL,
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_auditoria_log_utilizador_idx` (`id_utilizador`),
  CONSTRAINT `fk_auditoria_log_utilizador` FOREIGN KEY (`id_utilizador`) REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_log`
--

LOCK TABLES `auditoria_log` WRITE;
/*!40000 ALTER TABLE `auditoria_log` DISABLE KEYS */;
INSERT INTO `auditoria_log` VALUES (1,1,'Criação de aulas para o mês de março 2026','2026-03-01 09:00:00'),(2,1,'Cancelamento da aula de Teatro (id=7)','2026-03-12 07:35:00'),(3,3,'Confirmação de presença — aula Ballet (id=1)','2026-03-03 11:00:00'),(4,4,'Confirmação de presença — aula Jazz (id=3)','2026-03-05 16:00:00'),(5,1,'Atualização configuração prazo_validacao_horas','2026-03-10 10:00:00'),(6,1,'Criação de aulas para abril 2026','2026-03-20 09:00:00');
/*!40000 ALTER TABLE `auditoria_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aula_alunos`
--

DROP TABLE IF EXISTS `aula_alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aula_alunos` (
  `aula_id` int NOT NULL,
  `aluno_id` int NOT NULL,
  PRIMARY KEY (`aula_id`,`aluno_id`),
  KEY `fk_aula_alunos_aluno_idx` (`aluno_id`),
  CONSTRAINT `fk_aula_alunos_aluno` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`utilizador_id`),
  CONSTRAINT `fk_aula_alunos_aula` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aula_alunos`
--

LOCK TABLES `aula_alunos` WRITE;
/*!40000 ALTER TABLE `aula_alunos` DISABLE KEYS */;
INSERT INTO `aula_alunos` VALUES 
-- Dados Iniciais / Originais da Base de Dados
(1,2), (3,2), (5,2), (6,2), (8,2), (10,2), (12,2), (13,2), 
(1,6), (2,6), (5,6), (8,6), (9,6), (12,6), 
(2,7), (3,7), (4,7), (7,7), (9,7), (10,7), (11,7), 
(1,8), (5,8), (8,8), (12,8), 
(2,9), (3,9), (4,9), (7,9), (9,9), (10,9), (11,9), 
(1,10), (5,10), (8,10),
-- Dados Adicionados no Primeiro Incremento (Aulas 14 a 17)
(14,7), (14,9), 
(15,2), (15,9), 
(16,6), (16,10),
(17,2),
-- Novos Dados Massivos (Semana de Horário Cheio: 1 de Junho a 7 de Junho)
-- Segunda-feira (Aula 20 e 21 - Diogo [2] e Inês [6])
(20,2), (20,6),
(21,2), (21,6),
-- Terça-feira (Aula 22 e 23 - Diogo [2] em ambas, Inês [6] na regular)
(22,2), (22,6),
(23,2),
-- Quarta-feira (Aula 24 e 25 - Diogo [2] e Inês [6] na regular, Inês no Coaching)
(24,2), (24,6),
(25,6),
-- Quinta-feira (Aula 26 e 27 - Presença total de Diogo [2] e Inês [6])
(26,2), (26,6),
(27,2), (27,6),
-- Sexta-feira (Aula 28 e 29 - Diogo [2] e Inês [6])
(28,2), (28,6),
(29,2), (29,6),
-- Sábado (Aula 30 - Intensivo com Diogo [2] e Inês [6])
(30,2), (30,6),
-- Domingo (Aula 31 - Sessão Especial com Diogo [2] e Inês [6])
(31,2), (31,6);
/*!40000 ALTER TABLE `aula_alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aula_coaching`
--

DROP TABLE IF EXISTS `aula_coaching`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aula_coaching` (
  `aula_id` int NOT NULL,
  `max_alunos` int NOT NULL DEFAULT '8',
  `modalidade_id` int NOT NULL,
  PRIMARY KEY (`aula_id`),
  KEY `fk_aula_coaching_3_idx` (`modalidade_id`),
  CONSTRAINT `fk_aula_coaching_1` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`),
  CONSTRAINT `fk_aula_coaching_3` FOREIGN KEY (`modalidade_id`) REFERENCES `modalidades` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aula_coaching`
--

LOCK TABLES `aula_coaching` WRITE;
/*!40000 ALTER TABLE `aula_coaching` DISABLE KEYS */;
INSERT INTO `aula_coaching` VALUES (6,1,2),(13,1,2),(17, 1, 7), (23, 1, 1), (25, 1, 2);
/*!40000 ALTER TABLE `aula_coaching` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aula_professores`
--

DROP TABLE IF EXISTS `aula_professores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aula_professores` (
  `aula_id` int NOT NULL,
  `professor_id` int NOT NULL,
  PRIMARY KEY (`aula_id`,`professor_id`),
  KEY `fk_aula_professores_professor_idx` (`professor_id`),
  CONSTRAINT `fk_aula_professores_aula` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`),
  CONSTRAINT `fk_aula_professores_professor` FOREIGN KEY (`professor_id`) REFERENCES `professores` (`utilizador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aula_professores`
--

LOCK TABLES `aula_professores` WRITE;
/*!40000 ALTER TABLE `aula_professores` DISABLE KEYS */;
INSERT INTO `aula_professores` VALUES 
(1,3),
(2,3),
(6,3),
(8,3),
(9,3),
(13,3),
(3,4),
(4,4),
(10,4),
(11,4),
(5,5),
(7,5),
(12,5),
(14, 4), -- Aula 14 lecionada pelo prof 4
(15, 4), -- Aula 15 lecionada pelo prof 4
(16, 5), -- Aula 16 lecionada pelo prof 5
(17, 3), -- Aula 17 lecionada pela prof 3 (Coaching)
(20, 3), -- Seg: Ana Sousa
(21, 3), -- Seg: Ana Sousa
(22, 5), -- Ter: Sofia Ferreira
(23, 3), -- Ter: Ana Sousa (Coaching Diogo)
(24, 5), -- Qua: Sofia Ferreira
(25, 3), -- Qua: Ana Sousa (Coaching Inês)
(26, 5), -- Qui: Sofia Ferreira
(27, 3), -- Qui: Ana Sousa
(28, 3), -- Sex: Ana Sousa
(29, 5), -- Sex: Sofia Ferreira
(30, 3), -- Sab: Ana Sousa
(31, 5); -- Dom: Sofia Ferreira
/*!40000 ALTER TABLE `aula_professores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aulas`
--

DROP TABLE IF EXISTS `aulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aulas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estudio_id` int NOT NULL,
  `criado_por` int NOT NULL,
  `duracao_minutos` int NOT NULL,
  `data_aula` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  `notas` text,
  `id_horario` int DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`),
  KEY `fk_aulas_estudio_idx` (`estudio_id`),
  KEY `fk_aulas_criado_por_idx` (`criado_por`),
  KEY `fk_aulas_1_idx` (`id_horario`),
  KEY `fk_aulas_2_idx` (`estado`),
  CONSTRAINT `fk_aulas_1` FOREIGN KEY (`id_horario`) REFERENCES `horario_turma` (`id`),
  CONSTRAINT `fk_aulas_2` FOREIGN KEY (`estado`) REFERENCES `estado_aula` (`estado_aula`),
  CONSTRAINT `fk_aulas_criado_por` FOREIGN KEY (`criado_por`) REFERENCES `utilizadores` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aulas_estudio` FOREIGN KEY (`estudio_id`) REFERENCES `estudios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aulas`
--

LOCK TABLES `aulas` WRITE;
/*!40000 ALTER TABLE `aulas` DISABLE KEYS */;
INSERT INTO `aulas` VALUES 
(1,1,1,60,'2026-03-03','09:00:00','10:00:00','Ballet — turma iniciantes',1,7),
(2,1,1,60,'2026-03-03','10:30:00','11:30:00','Contemporânea — turma intermédios',2,7),
(3,3,1,60,'2026-03-05','14:00:00','15:00:00','Jazz — turma geral',NULL,7),
(4,3,1,60,'2026-03-05','15:30:00','16:30:00','Hip Hop — turma mista',NULL,7),
(5,4,1,60,'2026-03-06','18:00:00','19:00:00','Yoga — grupo geral (pendente val.)',NULL,7),
(6,2,1,60,'2026-03-10','09:00:00','10:00:00','Ballet coaching — Diogo',NULL,7),
(7,2,1,90,'2026-03-12','18:00:00','19:30:00','Teatro — cancelada por doença',NULL,7),
(8,1,1,60,'2026-03-31','09:00:00','10:00:00','Ballet — turma iniciantes',1,7),
(9,1,1,60,'2026-03-31','10:30:00','11:30:00','Contemporânea — turma intermédios',2,7),
(10,3,1,60,'2026-04-02','14:00:00','15:00:00','Jazz — turma geral',NULL,7),
(11,3,1,60,'2026-04-02','15:30:00','16:30:00','Hip Hop — turma mista',NULL,7),
(12,4,1,60,'2026-04-03','18:00:00','19:00:00','Yoga — grupo geral',NULL,7),
(13,2,1,60,'2026-04-07','09:00:00','10:00:00','Ballet coaching — Diogo',NULL,7),
(14, 3, 1, 90, '2026-04-09', '19:30:00', '21:00:00', 'Jazz Avançado - Foco em flexibilidade e saltos', 3, 3),
(15, 5, 1, 60, '2026-04-10', '20:00:00', '21:00:00', 'Commercial Heels - Coreografia Inicial', 4, 3),
(16, 8, 1, 60, '2026-04-11', '10:00:00', '11:00:00', 'Pilates Clínico - Correção Postural', 5, 3),
(17, 6, 1, 60, '2026-04-14', '11:00:00', '12:00:00', 'Coaching Privado Ballet Avançado - Aluno Diogo', NULL, 3),
-- Segunda-feira, 01/06
(20, 1, 1, 60, '2026-06-01', '14:00:00', '15:00:00', 'Aula Regular Ballet - Foco Barra', 6, 3),
(21, 2, 1, 90, '2026-06-01', '18:30:00', '20:00:00', 'Contemporânea - Trabalho de Chão', 7, 3),
-- Terça-feira, 02/06
(22, 3, 1, 60, '2026-06-02', '10:00:00', '11:00:00', 'Jazz Técnico Rotinas', 8, 3),
(23, 6, 1, 60, '2026-06-02', '14:00:00', '15:00:00', 'Coaching Privado - Diogo Técnico', NULL, 3),
-- Quarta-feira, 03/06
(24, 5, 1, 60, '2026-06-03', '16:00:00', '17:00:00', 'Commercial Heels Video Project', 9, 3),
(25, 6, 1, 60, '2026-06-03', '18:00:00', '19:00:00', 'Coaching Privado - Inês Martins Solo', NULL, 3),
-- Quinta-feira, 04/06
(26, 8, 1, 90, '2026-06-04', '11:30:00', '13:00:00', 'Pilates Reabilitação e Postura', 10, 3),
(27, 1, 1, 60, '2026-06-04', '16:30:00', '17:30:00', 'Ensaio Geral Especial Extra', NULL, 3),
-- Sexta-feira, 05/06
(28, 1, 1, 60, '2026-06-05', '15:00:00', '16:00:00', 'Ballet Tradicional Centro e Pontas', 11, 3),
(29, 3, 1, 90, '2026-06-05', '19:00:00', '20:30:00', 'Workshop Coreográfico de Junho', NULL, 3),
-- Sábado, 06/06
(30, 2, 1, 120, '2026-06-06', '09:30:00', '11:30:00', 'Contemporânea Laboratório de Criação', 12, 3),
-- Domingo, 07/06
(31, 7, 1, 90, '2026-06-07', '10:30:00', '12:00:00', 'Sessão Especial de Alongamento ao Ar Livre', NULL, 3);
/*!40000 ALTER TABLE `aulas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cancelamentos`
--

DROP TABLE IF EXISTS `cancelamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cancelamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aula_id` int NOT NULL,
  `utilizador_id` int NOT NULL,
  `marcardo_por`int NOT NULL,
  `motivo` text NOT NULL,
  `justificado` tinyint(1) NOT NULL DEFAULT '0',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `justificado_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cancelamentos_aula_idx` (`aula_id`),
  KEY `fk_cancelamentos_utilizador_idx` (`utilizador_id`),
  KEY `fk_cancelamentos_marcado_por_idx` (`marcardo_por`),
  CONSTRAINT `fk_cancelamentos_aula` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`),
  CONSTRAINT `fk_cancelamentos_utilizador` FOREIGN KEY (`utilizador_id`) REFERENCES `utilizadores` (`id`),
  CONSTRAINT `fk_cancelamentos_marcado_por` FOREIGN KEY (`marcardo_por`) REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cancelamentos`
--

LOCK TABLES `cancelamentos` WRITE;
/*!40000 ALTER TABLE `cancelamentos` DISABLE KEYS */;
INSERT INTO cancelamentos VALUES (1,7,5,5,'Professora com baixa médica',1,'2026-03-12 07:30:00','2026-03-13 10:00:00');
INSERT INTO cancelamentos VALUES (2,7,7,7,'Medico',1,'2026-03-12 07:30:00','2026-03-13 10:00:00');
INSERT INTO `cancelamentos` 
(`id`, `aula_id`, `utilizador_id`, `marcardo_por`, `motivo`, `justificado`, `criado_em`, `justificado_em`) 
VALUES 
(14, 7, 7, 7, 'Consulta médica inesperada de urgência', 1, '2026-04-09 15:00:00', '2026-04-10 09:30:00');

/*!40000 ALTER TABLE `cancelamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracoes`
--

DROP TABLE IF EXISTS `configuracoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuracoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_config` varchar(45) NOT NULL,
  `valor` varchar(255) NOT NULL,
  `descricao` text,
  `editado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `editado_por` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_config_UNIQUE` (`nome_config`),
  KEY `fk_configuracoes_utilizador_idx` (`editado_por`),
  CONSTRAINT `fk_configuracoes_utilizador` FOREIGN KEY (`editado_por`) REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracoes`
--

LOCK TABLES `configuracoes` WRITE;
/*!40000 ALTER TABLE `configuracoes` DISABLE KEYS */;
INSERT INTO `configuracoes` VALUES 
(1,'max_faltas_justificadas','3','Número máximo de faltas justificadas por mês','2026-03-27 14:08:48',1),
(2,'prazo_validacao_horas','48','Horas para validar uma aula após ocorrer','2026-03-27 14:08:48',1),
(3,'valor_hora_default','36.00','Valor hora padrão para novos professores','2026-03-27 14:08:48',1),
(4,'mensalidade_base','50.00','Valor base de mensalidade mensal','2026-03-27 14:08:48',1),
(5,'email_notificacoes','escolaentartesbraga@gmail.com','Email de notificações','2026-03-27 14:08:48',1),
(6,'seguro_base','20.00','Valor padrão do seguro escolar anual','2026-03-27 14:08:48',1),
(7,'taxa_coaching_escola','20','Percentagem retida pela escola nas sessões de coaching (0 a 100)','2026-03-27 14:08:48',1);
/*!40000 ALTER TABLE `configuracoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disponibilidade_professor`
--

DROP TABLE IF EXISTS `disponibilidade_professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disponibilidade_professor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `professor_id` int NOT NULL,
  `dia_semana` int NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  `valido_de` date DEFAULT NULL,
  `valido_ate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_disponibilidade_professor_idx` (`professor_id`),
  CONSTRAINT `fk_disponibilidade_professor` FOREIGN KEY (`professor_id`) REFERENCES `professores` (`utilizador_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidade_professor`
--

LOCK TABLES `disponibilidade_professor` WRITE;
/*!40000 ALTER TABLE `disponibilidade_professor` DISABLE KEYS */;
INSERT INTO `disponibilidade_professor` VALUES 
(1,3,2,'09:00:00','13:00:00','2025-09-01','2027-07-31'),
(2,3,4,'09:00:00','13:00:00','2025-09-01','2027-07-31'),
(3,3,6,'10:00:00','12:00:00','2025-09-01','2027-07-31'),
(4,4,3,'14:00:00','19:00:00','2025-09-01','2027-07-31'),
(5,4,5,'14:00:00','19:00:00','2025-09-01','2027-07-31'),
(6,5,2,'18:00:00','21:00:00','2025-09-01','2027-07-31'),
(7,5,4,'18:00:00','21:00:00','2025-09-01','2027-07-31'),
(8,5,6,'09:00:00','13:00:00','2025-09-01','2027-07-31'),
(9,4,4,'19:00:00','22:00:00','2026-03-01','2027-07-31'),
(10,4,5,'19:00:00','22:00:00','2026-03-01','2027-07-31'),
(11,5,6,'09:00:00','14:00:00','2026-03-01','2027-07-31');
/*!40000 ALTER TABLE `disponibilidade_professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encarregado_aluno`
--

DROP TABLE IF EXISTS `encarregado_aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encarregado_aluno` (
  `encarregado_id` int NOT NULL,
  `aluno_id` int NOT NULL,
  PRIMARY KEY (`encarregado_id`,`aluno_id`),
  KEY `fk_encarregado_aluno_aluno_idx` (`aluno_id`),
  CONSTRAINT `fk_encarregado_aluno_aluno` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`utilizador_id`),
  CONSTRAINT `fk_encarregado_aluno_encarregado` FOREIGN KEY (`encarregado_id`) REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encarregado_aluno`
--

LOCK TABLES `encarregado_aluno` WRITE;
/*!40000 ALTER TABLE `encarregado_aluno` DISABLE KEYS */;
INSERT INTO `encarregado_aluno` VALUES (11,6),(12,7),(11,8),(12,10);
/*!40000 ALTER TABLE `encarregado_aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_aula`
--

DROP TABLE IF EXISTS `estado_aula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_aula` (
  `estado_aula` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) NOT NULL,
  `descricao` text,
  PRIMARY KEY (`estado_aula`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_aula`
--

LOCK TABLES `estado_aula` WRITE;
/*!40000 ALTER TABLE `estado_aula` DISABLE KEYS */;
INSERT INTO `estado_aula` VALUES 
(1,'Disponível','Aula criada e disponível para pedidos'),
(2,'Pedido','Pedido de aula submetido, aguarda validação'),
(3,'Agendado','Aula validada pelo sistema e pelo professor'),
(4,'Aula cancelada','Aula cancelada por professor, estudante ou outro motivo'),
(5,'Aula ocorrida','Aula realizou-se, aguarda registo contabilístico'),
(6,'Pendente de validação','Aguarda confirmação dos atores necessários'),
(7,'Validado Automáticamente','Prazo de validação de 48h ultrapassado sem confirmação'),
(8,'Validado','Confirmado por todos os atores necessários'),
(9,'Contabilizado','Incluído no relatório mensal');
/*!40000 ALTER TABLE `estado_aula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_unidade`
--

DROP TABLE IF EXISTS `estado_unidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_unidade` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_estado_unidade` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_unidade`
--

LOCK TABLES `estado_unidade` WRITE;
/*!40000 ALTER TABLE `estado_unidade` DISABLE KEYS */;
INSERT INTO `estado_unidade` VALUES (1,'Rascunho'),(2,'Publicado'),(3,'Vendido'),(4,'Doado'),(5,'Removido'),(6,'Alugado'),(7,'Devolvido'),(8,'Pendente'),(9,'Inventario');
/*!40000 ALTER TABLE `estado_unidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudio_modalidade`
--

DROP TABLE IF EXISTS `estudio_modalidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudio_modalidade` (
  `estudio_id` int NOT NULL,
  `modalidade_id` int NOT NULL,
  PRIMARY KEY (`estudio_id`,`modalidade_id`),
  KEY `fk_estudio_modalidade_modalidade_idx` (`modalidade_id`),
  CONSTRAINT `fk_estudio_modalidade_estudio` FOREIGN KEY (`estudio_id`) REFERENCES `estudios` (`id`),
  CONSTRAINT `fk_estudio_modalidade_modalidade` FOREIGN KEY (`modalidade_id`) REFERENCES `modalidades` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudio_modalidade`
--

LOCK TABLES `estudio_modalidade` WRITE;
/*!40000 ALTER TABLE `estudio_modalidade` DISABLE KEYS */;
INSERT INTO `estudio_modalidade` VALUES 
(1,1),
(2,1),
(3,1),
(1,2),
(2,2),
(1,3),
(3,3),
(3,4),
(4,5),
(2,6),
(5, 2), -- Estúdio D com Ballet Clássico
(5, 7), -- Estúdio D com Ballet Avançado
(6, 6), -- Sala Ensaio com Teatro
(7, 3), -- Estúdio E com Jazz
(7, 8), -- Estúdio E com Dança Comercial
(8, 9); -- Sala Pilates com Pilates Clínico
/*!40000 ALTER TABLE `estudio_modalidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudios`
--

DROP TABLE IF EXISTS `estudios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `capacidade` int NOT NULL,
  `notas` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudios`
--

LOCK TABLES `estudios` WRITE;
/*!40000 ALTER TABLE `estudios` DISABLE KEYS */;
INSERT INTO `estudios` VALUES 
(1,'Estúdio A',12,'Piso de madeira flutuante, espelhos na parede norte'),
(2,'Estúdio B',8,'Sala menor, ideal para aulas individuais e coaching'),
(3,'Estúdio C',20,'Maior espaço, utilizado para workshops'),
(4,'Sala Yoga',10,'Piso antiderrapante, ambiente calmo'),
(5,'Estúdio D (Espelhos)',15,'Piso flutuante amortecido, barras amovíveis e espelhos a toda a largura'),
(6,'Sala de Ensaio Individual',4,'Espaço compacto otimizado para coaching ou audições'),
(7,'Estúdio E (Ar Livre)',12,'Zona de estúdio semi-coberta ideal para workshops de verão e gravações'),
(8,'Sala de Pilates & Barra',8,'Equipada com reformers de pilates e barras fixas');
/*!40000 ALTER TABLE `estudios` ENABLE KEYS */;
UNLOCK TABLES;

-- -----------------------------------------------------
-- Table `entartes`.`estado_eventos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `estado_eventos`;
CREATE TABLE IF NOT EXISTS `entartes`.`estado_eventos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
LOCK TABLES `estado_eventos` WRITE;

INSERT INTO `estado_eventos` (`estado`) VALUES 
('Publicado'),('Cancelado'),('Concluído');
UNLOCK TABLES;


-- -----------------------------------------------------
-- Table `entartes`.`eventos`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `eventos`;

CREATE TABLE IF NOT EXISTS `entartes`.`eventos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `descricao` TEXT NOT NULL,
  `data_evento` DATE NOT NULL,
  `hora_inicio` TIME NULL DEFAULT NULL,
  `hora_fim` TIME NULL DEFAULT NULL,
  `local` VARCHAR(150) NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `estado` INT NOT NULL,
  `max_participantes` INT UNSIGNED NULL DEFAULT NULL,
  `criado_por` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_eventos_criado_por_idx` (`criado_por` ASC) VISIBLE,
  INDEX `ESTADO_idx` (`estado` ASC) VISIBLE,
  CONSTRAINT `ESTADO`
    FOREIGN KEY (`estado`)
    REFERENCES `entartes`.`estado_eventos` (`id`),
  CONSTRAINT `fk_eventos_criado_por`
    FOREIGN KEY (`criado_por`)
    REFERENCES `entartes`.`utilizadores` (`id`)
)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- Dumping data for table `eventos`
LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;

INSERT INTO `eventos`
(`nome`, `descricao`, `data_evento`, `hora_inicio`, `hora_fim`, `local`, `preco`, `estado`, `max_participantes`, `criado_por`)
VALUES 
('Espetáculo de Fim de Ano', 'Apresentação anual dos alunos de todas as modalidades', '2026-06-20', '20:00:00', '22:00:00', 'Teatro Municipal de Braga', 0.00, 0, 100, 1),
('Workshop de Verão', 'Workshop intensivo de dança contemporânea e jazz', '2026-07-15', '10:00:00', '17:00:00', 'Estúdio C — entartes', 25.00, 0, 30, 1),
('Gala de Outono 2026', 'Mostra intercalar de pequenas peças coreográficas contemporâneas', '2026-11-14', '18:30:00', '20:30:00', 'Auditorió do Conservatório de Braga', 5.00, 1, 80, 1),
('Masterclass Internacional de Ballet', 'Masterclass exclusiva com professor convidado da Escola de Dança da Ópera de Paris', '2026-05-18', '09:00:00', '13:00:00', 'Estúdio C — entartes', 45.00, 1, 25, 1);
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario_turma`
--

DROP TABLE IF EXISTS `horario_turma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horario_turma` (
  `id` int NOT NULL AUTO_INCREMENT,
  `criado_por` int NOT NULL,
  `idturma` int NOT NULL,
  `data_inicio` date NOT NULL,
  `data_validade` date NOT NULL,
  `dia_semana` int NOT NULL,
  `duracao_minutos` int NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  `estudio_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_aulas_criado_por_idx` (`criado_por`),
  KEY `fk_horario_turma_1_idx` (`estudio_id`),
  KEY `fk_aula_fixa_1_idx` (`idturma`,`estudio_id`),
  CONSTRAINT `fk_aulas_criado_por0` FOREIGN KEY (`criado_por`) REFERENCES `utilizadores` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_horario_turma_1` FOREIGN KEY (`estudio_id`) REFERENCES `estudios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario_turma`
--

LOCK TABLES `horario_turma` WRITE;
/*!40000 ALTER TABLE `horario_turma` DISABLE KEYS */;
INSERT INTO `horario_turma` VALUES 
(1,1,1,'2025-09-01','2026-07-31',2,60,'09:00:00','10:00:00',1),
(2,1,2,'2025-09-01','2026-07-31',2,60,'10:30:00','11:30:00',4),
(3, 1, 3, '2026-03-01', '2026-07-31', 4, 90, '19:30:00', '21:00:00', 3), -- Turma 3 à Quinta no Estúdio 3
(4, 1, 4, '2026-03-01', '2026-07-31', 5, 60, '20:00:00', '21:00:00', 5), -- Turma 4 à Sexta no Estúdio 5
(5, 1, 5, '2026-03-01', '2026-07-31', 6, 60, '10:00:00', '11:00:00', 8), -- Turma 5 ao Sábado no Estúdio 8
(6, 1, 1, '2026-05-01', '2026-07-31', 1, 60, '14:00:00', '15:00:00', 1), -- Segunda: Ballet Tradicional
(7, 1, 2, '2026-05-01', '2026-07-31', 1, 90, '18:30:00', '20:00:00', 2), -- Segunda: Contemporânea
(8, 1, 3, '2026-05-01', '2026-07-31', 2, 60, '10:00:00', '11:00:00', 3), -- Terça: Jazz Avançado
(9, 1, 4, '2026-05-01', '2026-07-31', 3, 60, '16:00:00', '17:00:00', 5), -- Quarta: Commercial Crew
(10, 1, 5, '2026-05-01', '2026-07-31', 4, 90, '11:30:00', '13:00:00', 8), -- Quinta: Pilates Corpóreo
(11, 1, 1, '2026-05-01', '2026-07-31', 5, 60, '15:00:00', '16:00:00', 1), -- Sexta: Ballet Tradicional
(12, 1, 2, '2026-05-01', '2026-07-31', 6, 120, '09:30:00', '11:30:00', 2); -- Sábado: Contemporânea Intensivo
/*!40000 ALTER TABLE `horario_turma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagens_unidade`
--

DROP TABLE IF EXISTS `imagens_unidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `imagens_unidade` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artigo_id` int NOT NULL,
  `url_imagem` mediumblob,
  PRIMARY KEY (`id`),
  KEY `fk_imagens_artigo_idx` (`artigo_id`),
  CONSTRAINT `fk_imagens_artigo` 
    FOREIGN KEY (`artigo_id`) 
    REFERENCES `artigos` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagens_unidade`
--

LOCK TABLES `imagens_unidade` WRITE;
/*!40000 ALTER TABLE `imagens_unidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagens_unidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_unidades`
--

DROP TABLE IF EXISTS `inventario_unidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_unidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,   
  `descricao` text,              
  `estado_id` int NOT NULL DEFAULT '9',
  `disponivel` tinyint(1) NOT NULL DEFAULT '1',
  `localizacao` varchar(100) DEFAULT NULL,
  `notas` text,
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_unidades_estado_idx` (`estado_id`),
  CONSTRAINT `fk_unidades_estado` FOREIGN KEY (`estado_id`) REFERENCES `estado_unidade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_unidades`
--

LOCK TABLES `inventario_unidades` WRITE;
/*!40000 ALTER TABLE `inventario_unidades` DISABLE KEYS */;
INSERT INTO `inventario_unidades` 
(`id`, `nome`, `descricao`, `estado_id`, `disponivel`, `localizacao`, `notas`, `criado_em`) 
VALUES
(1, 'Tapete de Pilates Confort', 'Tapete antiderrapante de alta densidade 15mm', 2, 1, 'Sala Yoga - Armário', 'Higienizados semanalmente', '2025-10-01 10:00:00'),
(2, 'Barra de Ballet Amovível 3m', 'Estrutura dupla em ferro leve ajustável em altura', 2, 1, 'Estúdio A - Canto Sul', 'Apenas para uso interno', '2025-10-01 10:00:00'),
(3, 'Tutu de Ballet Clássico Profissional', 'Figurino de palco plissado cor branco com corpete', 1, 0, NULL, 'Aguarda fotografias para catálogo', '2025-10-01 10:00:00'),
(4, 'Coluna Bluetooth JBL Boombox', 'Coluna de som de alta potência para ensaios exteriores', 3, 0, NULL, 'Vendida em mar 2026 devido a atualização', '2025-10-01 10:00:00'),
(5, 'Bandas Elásticas de Resistência (Kit)', 'Conjunto de 5 fitas elásticas de intensidades variadas', 2, 1, 'Armário Secretaria', 'Foco em fortalecimento e flexibilidade', '2025-10-01 10:00:00'),
(6, 'Sapatilhas de Pontas Pointe Pro', 'Sapatilhas de pontas para Ballet Avançado tamanho 37', 6, 0, NULL, 'Alugada à aluna Inês Martins', '2025-11-15 09:00:00'),
(7, 'Bloco de Yoga em Cortiça Natural', 'Bloco de apoio postural e alongamento estável', 2, 1, 'Sala Yoga - Prateleiras', 'Kit com duas unidades incluídas', '2025-11-15 09:00:00'),
(8, 'Coluna de Som Portátil JBL', 'Coluna bluetooth utilizada para aulas no Estúdio E ao ar livre', 9, 1, 'Armário Secretaria', 'Carregador incluído', '2026-03-01 09:00:00'),
(9, 'Kit de Blocos Yoga (Par)', 'Blocos de espuma de alta densidade', 2, 1, 'Sala Yoga - Prateleiras', 'Disponíveis para uso comum ou aluguer', '2026-03-02 10:00:00');
/*!40000 ALTER TABLE `inventario_unidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `justificacao_falta`
--

DROP TABLE IF EXISTS `justificacao_falta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `justificacao_falta` (
  `id` int NOT NULL AUTO_INCREMENT,
  `justificacao_pdf` longblob NOT NULL,
  `idfalta` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_justificacao_falta_cancelamento_idx` (`idfalta`),
  CONSTRAINT `fk_justificacao_falta_cancelamento` FOREIGN KEY (`idfalta`) REFERENCES `cancelamentos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `justificacao_falta`
--

LOCK TABLES `justificacao_falta` WRITE;
/*!40000 ALTER TABLE `justificacao_falta` DISABLE KEYS */;
/*!40000 ALTER TABLE `justificacao_falta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensagens`
--

DROP TABLE IF EXISTS `mensagens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensagens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `remetente_id` int NOT NULL,
  `destinatario_id` int NOT NULL,
  `conteudo` text NOT NULL,
  `enviada_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lida` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mensagens_remetente_idx` (`remetente_id`),
  KEY `fk_mensagens_destinatario_idx` (`destinatario_id`),
  CONSTRAINT `fk_mensagens_destinatario` FOREIGN KEY (`destinatario_id`) REFERENCES `utilizadores` (`id`),
  CONSTRAINT `fk_mensagens_remetente` FOREIGN KEY (`remetente_id`) REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensagens`
--

LOCK TABLES `mensagens` WRITE;
/*!40000 ALTER TABLE `mensagens` DISABLE KEYS */;
INSERT INTO `mensagens` VALUES 
(1,1,3,'Ana, podes confirmar disponibilidade para a aula de 31 de março?','2026-03-20 09:00:00',NULL),
(2,3,1,'Bom dia, confirmo disponibilidade. Até já.','2026-03-20 09:45:00',NULL),
(3,1,2,'Diogo, a tua aula de coaching está marcada para 7 de abril às 9h.','2026-03-22 10:00:00','2026-03-22 11:00:00'),
(4,4,1,'A aula de Jazz de 2 de abril pode passar para o Estúdio A?','2026-03-22 14:00:00',NULL),
(5,11,1,'Bom dia, a Sofia vai faltar na aula do dia 31. Obrigado.','2026-03-28 08:30:00',NULL),
(6,2,1,'Olá, obrigado pelo aviso!','2026-03-27 18:10:52',NULL),
(7, 9, 4, 'Professor Pedro, os sapatos para a aula de Heels têm de ter alguma altura de salto específica?', '2026-03-12 21:00:00', '2026-03-13 09:15:00'),
(8, 4, 9, 'Olá! Recomendo entre 5 a 7 centímetros para começar, que tenham boa estabilidade no tornozelo.', '2026-03-13 09:20:00', NULL),
(9, 11, 1, 'Bom dia, gostaria de saber se o seguro da Sofia já se encontra ativo na plataforma.', '2026-03-15 08:45:00', '2026-03-15 10:00:00');
/*!40000 ALTER TABLE `mensagens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupos`
--
DROP TABLE IF EXISTS `grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `criador_id` int NOT NULL,
  `tipo_grupo` enum('TURMA', 'PRIVADO') DEFAULT 'PRIVADO',
  `turma_id` int DEFAULT NULL, -- Mantém o vínculo se for uma turma oficial
  `criado_em` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_grupo_criador` FOREIGN KEY (`criador_id`) REFERENCES `utilizadores` (`id`),
  CONSTRAINT `fk_grupo_turma` FOREIGN KEY (`turma_id`) REFERENCES `turmas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `grupos`
--

LOCK TABLES `grupos` WRITE;
/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;

-- Cabeçalho atualizado com todas as 6 colunas necessárias
INSERT INTO `grupos` (`id`, `nome`, `criador_id`, `tipo_grupo`, `turma_id`, `criado_em`) VALUES 
(1, 'Turma de Ballet Tradicional', 1, 'TURMA', 1, '2026-03-01 10:00:00'),
(2, 'Turma de Contemporânea', 1, 'TURMA', 2, '2026-03-01 10:30:00'),
(3, 'Comunidade Crew - Commercial Heels', 1, 'TURMA', 4, '2026-03-01 12:00:00'),
(4, 'Grupo Interno - Pilates Sábados', 5, 'PRIVADO', 5, '2026-03-06 18:30:00');

/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_membros`
--

DROP TABLE IF EXISTS `grupo_membros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo_membros` (
  `grupo_id` int NOT NULL,
  `utilizador_id` int NOT NULL,
  PRIMARY KEY (`grupo_id`, `utilizador_id`),
  CONSTRAINT `fk_membro_grupo` FOREIGN KEY (`grupo_id`) REFERENCES `grupos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_membro_utilizador` FOREIGN KEY (`utilizador_id`) REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 17. GRUPO_MEMBROS (Associar os utilizadores que pertencem organicamente a estes grupos)
LOCK TABLES `grupo_membros` WRITE;
INSERT INTO `grupo_membros` (`grupo_id`, `utilizador_id`) VALUES
-- Grupo 3 (Commercial Heels - Prof Pedro (4), Alunos Diogo (2) e Aluno 9)
(3, 4), (3, 2), (3, 9),
-- Grupo 4 (Pilates - Prof Sofia (5), Alunos 6 e 10)
(4, 5), (4, 6), (4, 10);
UNLOCK TABLES;

--
-- Table structure for table `mensagens_grupo`
--

DROP TABLE IF EXISTS `mensagens_grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensagens_grupo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `grupo_id` int NOT NULL,
  `remetente_id` int NOT NULL,
  `conteudo` text NOT NULL,
  `enviada_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_msg_grupo_id` (`grupo_id`),
  KEY `fk_msg_grupo_remetente` (`remetente_id`),
  CONSTRAINT `fk_msg_grupo_id` FOREIGN KEY (`grupo_id`) REFERENCES `grupos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_msg_grupo_remetente` FOREIGN KEY (`remetente_id`) REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mensagens_grupo`
--

LOCK TABLES `mensagens_grupo` WRITE;
/*!40000 ALTER TABLE `mensagens_grupo` DISABLE KEYS */;
INSERT INTO `mensagens_grupo` (`id`, `grupo_id`, `remetente_id`, `conteudo`, `enviada_em`) VALUES 
(1, 1, 3, 'Lembrete: tragam sapatilhas na aula de 31 de março. Até já, Ana.', '2026-03-25 10:00:00'),
(2, 2, 3, 'A aula de Contemporânea de 31 de março começa às 10h30 em ponto.', '2026-03-25 10:05:00'),
(3, 1, 1, 'As mensalidades de março ainda estão por pagar para alguns alunos.', '2026-03-25 09:00:00'),
(4, 3, 4, 'Bem-vindos à Crew de Commercial! Deixei o link da música da coreografia fixado.', '2026-03-02 14:00:00'),
(5, 4, 5, 'Lembrete para amanhã: tragam uma toalha individual para cobrir o tapete de Pilates.', '2026-03-13 19:00:00');
/*!40000 ALTER TABLE `mensagens_grupo` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `modalidades`
--

DROP TABLE IF EXISTS `modalidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modalidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modalidades`
--

LOCK TABLES `modalidades` WRITE;
/*!40000 ALTER TABLE `modalidades` DISABLE KEYS */;
INSERT INTO `modalidades` VALUES 
(1,'Dança Contemporânea','Técnica de dança moderna com foco em expressão corporal'),
(2,'Ballet Clássico','Dança clássica com base na escola francesa e russa'),
(3,'Jazz','Dança de jazz com influências afro-americanas'),
(4,'Hip Hop','Dança urbana com origem na cultura hip hop'),
(5,'Yoga','Prática de yoga adaptada ao contexto artístico'),
(6,'Teatro','Expressão dramática e técnicas de representação'),
(7, 'Ballet Avançado', 'Técnica avançada e preparação para pontas'),
(8, 'Dança Comercial / Heels', 'Estilo coreográfico focado na indústria comercial e videoclipes'),
(9, 'Pilates Clínico', 'Fortalecimento focado em bailarinos e flexibilidade');
/*!40000 ALTER TABLE `modalidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificacoes`
--

DROP TABLE IF EXISTS `notificacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `destinatario_id` int NOT NULL,        -- Quem vai receber e ler a notificação
  `remetente_id` int DEFAULT NULL,       -- Quem gerou a ação (ex: quem enviou a mensagem)
  `titulo` varchar(150) NOT NULL,
  `mensagem` text NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,       -- Ex: 'MENSAGEM', 'AULA', 'PAGAMENTO', 'MARKETPLACE'
  `referencia_id` varchar(100) DEFAULT NULL, -- ID do chat ou do artigo para o clique funcionar
  `lida` tinyint(1) NOT NULL DEFAULT '0',
  `criada_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_notificacoes_destinatario` FOREIGN KEY (`destinatario_id`) REFERENCES `utilizadores` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_notificacoes_remetente` FOREIGN KEY (`remetente_id`) REFERENCES `utilizadores` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `idpagamento` int NOT NULL AUTO_INCREMENT,
  `valor_pagamento` decimal(10,2) NOT NULL,
  `pago` tinyint(1) NOT NULL DEFAULT '0',
  `descricao` text,
  `idutilizador` int NOT NULL,
  `id_tipo_pagamento` int NOT NULL,
  `aula_id` int DEFAULT NULL,
  `data_pagamento` date NOT NULL,
  `data_confirmado` date DEFAULT NULL,
  PRIMARY KEY (`idpagamento`),
  KEY `fk_pagamento_utilizador_idx` (`idutilizador`),
  KEY `fk_pagamento_tipo_idx` (`id_tipo_pagamento`),
  KEY `fk_pagamento_aula_idx` (`aula_id`),
  CONSTRAINT `fk_pagamento_aula` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`),
  CONSTRAINT `fk_pagamento_tipo` FOREIGN KEY (`id_tipo_pagamento`) REFERENCES `tipo_pagamento` (`idtipo_pagamento`),
  CONSTRAINT `fk_pagamento_utilizador` FOREIGN KEY (`idutilizador`) REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
INSERT INTO `pagamento` VALUES 
(1,25.00,1,'Inscrição 2025/2026',2,3,NULL,'2025-09-01','2025-09-01'),
(2,25.00,1,'Inscrição 2025/2026',6,3,NULL,'2025-09-01','2025-09-01'),
(3,25.00,1,'Inscrição 2025/2026',7,3,NULL,'2025-09-01','2025-09-01'),
(4,25.00,1,'Inscrição 2025/2026',8,3,NULL,'2025-09-02','2025-09-02'),
(5,25.00,1,'Inscrição 2025/2026',9,3,NULL,'2025-09-01','2025-09-01'),
(6,25.00,1,'Inscrição 2025/2026',10,3,NULL,'2025-09-03','2025-09-03'),
(7,50.00,1,'Mensalidade março 2026',2,1,NULL,'2026-03-01','2026-03-02'),
(8,50.00,1,'Mensalidade março 2026',6,1,NULL,'2026-03-01','2026-03-02'),
(9,50.00,1,'Mensalidade março 2026',7,1,NULL,'2026-03-01','2026-03-03'),
(10,50.00,0,'Mensalidade março 2026',8,1,NULL,'2026-03-01',NULL),
(11,50.00,1,'Mensalidade março 2026',9,1,NULL,'2026-03-02','2026-03-03'),
(12,50.00,0,'Mensalidade março 2026',10,1,NULL,'2026-03-01',NULL),
(13,15.00,1,'Seguro escolar 2025/2026',2,4,NULL,'2025-09-01','2025-09-01'),
(14,15.00,1,'Seguro escolar 2025/2026',6,4,NULL,'2025-09-01','2025-09-01'),
(15,15.00,1,'Seguro escolar 2025/2026',7,4,NULL,'2025-09-01','2025-09-01'),
(16,15.00,1,'Seguro escolar 2025/2026',8,4,NULL,'2025-09-02','2025-09-02'),
(17,15.00,1,'Seguro escolar 2025/2026',9,4,NULL,'2025-09-01','2025-09-01'),
(18,15.00,1,'Seguro escolar 2025/2026',10,4,NULL,'2025-09-03','2025-09-03'),
(19,36.00,1,'Aula coaching Ballet — Diogo',2,2,6,'2026-03-10','2026-03-10'),
(20,55.00, 1, 'Mensalidade Abril 2026 - Turma Jazz Avançado', 9, 1, NULL, '2026-04-01', '2026-04-01'),
(21,45.00, 1, 'Mensalidade Abril 2026 - Turma Commercial Crew', 2, 1, NULL, '2026-04-02', '2026-04-03'),
(22,45.00, 0, 'Taxa de Inscrição Masterclass Internacional de Ballet', 7, 4, NULL, '2026-04-05', NULL), -- Pendente
(23,20.00, 1, 'Pagamento de Aula Avulso Individual (Recuperação)', 6, 2, 16, '2026-04-11', '2026-04-11');
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participantes_evento`
--

DROP TABLE IF EXISTS `participantes_evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `participantes_evento` (
  `evento_id` INT NOT NULL,
  `utilizador_id` INT NOT NULL,
  `pago` BOOLEAN NOT NULL DEFAULT FALSE,
  `cancelado` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`evento_id`, `utilizador_id`),
  KEY `fk_participantes_evento_utilizador_idx` (`utilizador_id`),
  CONSTRAINT `fk_participantes_evento_evento`
    FOREIGN KEY (`evento_id`)
    REFERENCES `eventos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_participantes_evento_utilizador`
    FOREIGN KEY (`utilizador_id`)
    REFERENCES `utilizadores` (`id`)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `participantes_evento` WRITE;
/*!40000 ALTER TABLE `participantes_evento` DISABLE KEYS */;

-- Cabeçalho e valores ajustados para as colunas reais da tabela
INSERT INTO `participantes_evento` (`evento_id`, `utilizador_id`, `pago`, `cancelado`) VALUES
(2, 9, 1, 0), -- Aluno Avançado (9) pagou o Workshop de Verão (ID 2), não cancelou
(2, 7, 0, 0); -- Aluno 7 inscrito no Workshop de Verão, pagamento pendente, não cancelou

/*!40000 ALTER TABLE `participantes_evento` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `professor_modalidade`
--

DROP TABLE IF EXISTS `professor_modalidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor_modalidade` (
  `professor_id` int NOT NULL,
  `modalidade_id` int NOT NULL,
  PRIMARY KEY (`professor_id`,`modalidade_id`),
  KEY `fk_professor_modalidade_modalidade_idx` (`modalidade_id`),
  CONSTRAINT `fk_professor_modalidade_modalidade` FOREIGN KEY (`modalidade_id`) REFERENCES `modalidades` (`id`),
  CONSTRAINT `fk_professor_modalidade_professor` FOREIGN KEY (`professor_id`) REFERENCES `professores` (`utilizador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor_modalidade`
--

LOCK TABLES `professor_modalidade` WRITE;
/*!40000 ALTER TABLE `professor_modalidade` DISABLE KEYS */;
INSERT INTO `professor_modalidade` VALUES 
(3,1),
(3,2),
(4,3),
(4,4),
(5,5),
(5,6),
(3, 7), -- Professor 3 passa a dar também Ballet Avançado
(4, 8), -- Professor 4 passa a dar também Dança Comercial
(5, 9); -- Professor 5 passa a dar também Pilates Clínico
/*!40000 ALTER TABLE `professor_modalidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professores`
--

DROP TABLE IF EXISTS `professores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professores` (
  `utilizador_id` int NOT NULL,
  `valor_hora` decimal(10,2) NOT NULL DEFAULT '36.00',
  `professor_externo` tinyint(1) DEFAULT '0',
  `notas` text,
  PRIMARY KEY (`utilizador_id`),
  CONSTRAINT `fk_professores_utilizador` FOREIGN KEY (`utilizador_id`) REFERENCES `utilizadores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professores`
--

LOCK TABLES `professores` WRITE;
/*!40000 ALTER TABLE `professores` DISABLE KEYS */;
INSERT INTO `professores` VALUES (3,36.00,0,'Especialista em Dança Contemporânea e Ballet'),(4,36.00,0,'Especialista em Jazz e Hip Hop'),(5,40.00,0,'Especialista em Teatro e Yoga');
/*!40000 ALTER TABLE `professores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_pagamento`
--

DROP TABLE IF EXISTS `tipo_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_pagamento` (
  `idtipo_pagamento` int NOT NULL AUTO_INCREMENT,
  `tipo_pagamento` varchar(45) NOT NULL,
  `descricao` text,
  PRIMARY KEY (`idtipo_pagamento`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_pagamento`
--

LOCK TABLES `tipo_pagamento` WRITE;
/*!40000 ALTER TABLE `tipo_pagamento` DISABLE KEYS */;
INSERT INTO `tipo_pagamento` VALUES (1,'Mensalidade','Pagamento mensal de frequência'),(2,'Aula Avulso','Pagamento por aula individual'),(3,'Inscrição','Taxa de inscrição inicial'),(4,'Seguro','Pagamento de participação em workshop'),(5,'Material','Compra de material ou artigo do inventário'),(6,'Outro','Pagamento de natureza diversa'),(7,'Pagamento','Pagamento ao professor pelas horas dadas');
/*!40000 ALTER TABLE `tipo_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_utilizador`
--

DROP TABLE IF EXISTS `tipo_utilizador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_utilizador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_utilizador` varchar(45) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_utilizador`
--

LOCK TABLES `tipo_utilizador` WRITE;
/*!40000 ALTER TABLE `tipo_utilizador` DISABLE KEYS */;
INSERT INTO `tipo_utilizador` VALUES (1,'COORDENACAO','Gestão de aulas, horários, professores e alunos'),(2,'PROFESSOR','Visualização e gestão das suas próprias aulas'),(3,'ALUNO','Inscrição em aulas e consulta de horários'),(4,'ENCARREGADO','Acompanhamento de alunos associados');
/*!40000 ALTER TABLE `tipo_utilizador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turma_alunos`
--

DROP TABLE IF EXISTS `turma_alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turma_alunos` (
  `turma_id` int NOT NULL,
  `aluno_id` int NOT NULL,
  `inscrito_em` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`turma_id`,`aluno_id`),
  KEY `aluno_id` (`aluno_id`),
  CONSTRAINT `turma_alunos_ibfk_1` FOREIGN KEY (`turma_id`) REFERENCES `turmas` (`id`),
  CONSTRAINT `turma_alunos_ibfk_2` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`utilizador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turma_alunos`
--

LOCK TABLES `turma_alunos` WRITE;
/*!40000 ALTER TABLE `turma_alunos` DISABLE KEYS */;
INSERT INTO `turma_alunos` VALUES 
(1,2,'2025-09-01'),
(1,6,'2025-09-01'),
(1,8,'2025-09-02'),
(1,10,'2025-09-03'),
(2,6,'2025-09-01'),
(2,7,'2025-09-01'),
(2,9,'2025-09-01'),
(3, 9, '2026-03-01'),  -- Aluno 9 (Avançado) no Jazz Avançado
(3, 7, '2026-03-02'),  -- Aluno 7 (Intermédio) no Jazz Avançado
(4, 2, '2026-03-01'),  -- Aluno 2 no Commercial Crew
(4, 9, '2026-03-01'),  -- Aluno 9 no Commercial Crew
(5, 6, '2026-03-05'),  -- Aluno 6 no Pilates
(5, 10, '2026-03-06'); -- Aluno 10 no Pilates
/*!40000 ALTER TABLE `turma_alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turma_encarregados`
--

DROP TABLE IF EXISTS `turma_encarregados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turma_encarregados` (
  `turma_id` int NOT NULL,
  `encarregado_id` int NOT NULL,
  `inscrito_em` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`turma_id`,`encarregado_id`),
  KEY `encarregado_id` (`encarregado_id`),
  CONSTRAINT `turma_encarregados_ibfk_1` FOREIGN KEY (`turma_id`) REFERENCES `turmas` (`id`),
  CONSTRAINT `turma_encarregados_ibfk_2` FOREIGN KEY (`encarregado_id`) REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `turmas`
--

DROP TABLE IF EXISTS `turmas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turmas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `mensalidade` decimal(10,2) NOT NULL,
  `modalidade_id` int NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_turmas_modalidade` (`modalidade_id`),
  CONSTRAINT `fk_turmas_modalidade` FOREIGN KEY (`modalidade_id`) REFERENCES `modalidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turmas`
--

LOCK TABLES `turmas` WRITE;
/*!40000 ALTER TABLE `turmas` DISABLE KEYS */;
INSERT INTO `turmas` VALUES 
(1,'Ballet Iniciantes 2025/2026',50.00,2,1),
(2,'Contemporânea Intermédios 2025/2026',50.00,1,1),
(3, 'Jazz Geral Avançado 2025/2026', 55.00, 3, 1),
(4, 'Commercial Heels Open Crew', 45.00, 8, 1),
(5, 'Pilates Corpóreo Intensivo', 60.00, 9, 1);
/*!40000 ALTER TABLE `turmas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilizador_log`
-- 

DROP TABLE IF EXISTS `utilizador_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilizador_log` (
  `idutilizador_log` int NOT NULL AUTO_INCREMENT,
  `ultimo_login` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endereco_ip` varchar(45) NOT NULL,
  `id_utilizador` int NULL,
  `sucesso` int NOT NULL,
  PRIMARY KEY (`idutilizador_log`),
  KEY `fk_utilizador_log_utilizador_idx` (`id_utilizador`),
  CONSTRAINT `fk_utilizador_log_utilizador` FOREIGN KEY (`id_utilizador`) REFERENCES `utilizadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilizador_log`
--

LOCK TABLES `utilizador_log` WRITE;
/*!40000 ALTER TABLE `utilizador_log` DISABLE KEYS */;
INSERT INTO `utilizador_log` VALUES (1,'2026-03-25 08:00:00','192.168.1.10',1,1),(2,'2026-03-25 08:15:00','192.168.1.20',3,1),(3,'2026-03-24 18:30:00','10.0.0.2',2,1),(4,'2026-03-24 19:00:00','10.0.0.6',6,1),(5,'2026-03-23 20:00:00','10.0.0.7',8,0),(6,'2026-03-23 20:01:00','10.0.0.7',8,1);
/*!40000 ALTER TABLE `utilizador_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilizadores`
--

DROP TABLE IF EXISTS `utilizadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilizadores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `telefone` varchar(9) NOT NULL,
  `palavra_passe` varchar(255) NOT NULL,
  `tipo` int NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `editado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data_nascimento` date NOT NULL,
  `nif` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_utilizadores_tipo_idx` (`tipo`),
  CONSTRAINT `fk_utilizadores_tipo` FOREIGN KEY (`tipo`) REFERENCES `tipo_utilizador` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilizadores`
--

LOCK TABLES `utilizadores` WRITE;
/*!40000 ALTER TABLE `utilizadores` DISABLE KEYS */;
INSERT INTO `utilizadores` VALUES (1,'Administrador','escolaentartesbraga@gmail.com','000000000','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',1,1,'2026-03-24 16:43:18','2026-03-24 16:43:18','1990-01-01','123456789'),(2,'Diogo','disilva0212005@gmail.com','935597311','$2a$10$ZD38mnuIs6Mc8n2ypgIT8uIqFGbjNlA8F0wyQQ5/m5h/Zp.Z5lijG',3,1,'2026-03-24 16:44:26','2026-03-24 16:44:26','1990-01-01','253593646'),(3,'Ana Sousa','ana.sousa@entartes.pt','912000003','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',2,1,'2026-03-27 14:08:48','2026-03-27 14:08:48','1988-05-20','300000003'),(4,'Carlos Lima','carlos.lima@entartes.pt','912000004','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',2,1,'2026-03-27 14:08:48','2026-03-27 14:08:48','1985-09-14','300000004'),(5,'Mariana Costa','mariana.costa@entartes.pt','912000005','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',2,1,'2026-03-27 14:08:48','2026-03-27 14:08:48','1992-03-08','300000005'),(6,'Sofia Ferreira','sofia.f@gmail.com','912000006','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',3,1,'2026-03-27 14:08:48','2026-03-27 14:08:48','2006-07-12','300000006'),(7,'Miguel Pereira','miguel.p@gmail.com','912000007','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',3,1,'2026-03-27 14:08:48','2026-03-27 14:08:48','2005-11-03','300000007'),(8,'Inês Martins','ines.m@gmail.com','912000008','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',3,1,'2026-03-27 14:08:48','2026-03-27 14:08:48','2007-02-25','300000008'),(9,'Tomás Oliveira','tomas.o@gmail.com','912000009','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',3,1,'2026-03-27 14:08:48','2026-03-27 14:08:48','2004-08-17','300000009'),(10,'Beatriz Nunes','beatriz.n@gmail.com','912000010','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',3,1,'2026-03-27 14:08:48','2026-03-27 14:08:48','2008-01-30','300000010'),(11,'Paulo Ferreira','paulo.enc@gmail.com','912000011','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',4,1,'2026-03-27 14:08:48','2026-03-27 14:08:48','1975-04-22','300000011'),(12,'Lúcia Pereira','lucia.enc@gmail.com','912000012','$2a$10$7L7w0WSrFAesZc9wSVE3fu4WfrF999FCReru3cNwthvXazhiAUOWW',4,1,'2026-03-27 14:08:48','2026-03-27 14:08:48','1978-10-05','300000012');
/*!40000 ALTER TABLE `utilizadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validacao_aula`
--

DROP TABLE IF EXISTS `validacao_aula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validacao_aula` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aula_id` int NOT NULL,
  `professor_confirmou` datetime DEFAULT NULL,
  `encarregado_confirmou` datetime DEFAULT NULL,
  `coordenador_confirmou` datetime DEFAULT NULL,
  `validacao_automatica` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_validacao_aula_aula_idx` (`aula_id`),
  CONSTRAINT `fk_validacao_aula_aula` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validacao_aula`
--

LOCK TABLES `validacao_aula` WRITE;
/*!40000 ALTER TABLE `validacao_aula` DISABLE KEYS */;
INSERT INTO `validacao_aula` VALUES (1,1,'2026-03-03 11:00:00','2026-03-03 14:00:00','2026-03-04 09:00:00',0),(2,2,'2026-03-03 12:00:00','2026-03-03 15:30:00','2026-03-04 09:30:00',0),(3,3,'2026-03-05 16:00:00','2026-03-05 18:00:00','2026-03-06 10:00:00',0),(4,4,'2026-03-05 17:30:00','2026-03-05 19:00:00','2026-03-06 10:30:00',0),(5,5,'2026-03-06 19:30:00',NULL,NULL,0),(6,6,'2026-03-10 10:30:00','2026-03-10 12:00:00','2026-03-11 09:00:00',0);
/*!40000 ALTER TABLE `validacao_aula` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-07 13:07:29
