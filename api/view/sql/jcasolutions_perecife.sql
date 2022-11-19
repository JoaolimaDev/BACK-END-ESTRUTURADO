

CREATE TABLE `coleta` (
  `id_coleta` int NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `barramento` varchar(255) NOT NULL,
  `tombamento` varchar(255) NOT NULL,
  `data_hora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `foto_1` blob,
  `foto_2` blob,
  `foto_3` blob,
  `materiais_id_materiais` int NOT NULL,
  `coletor_id_coletor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `coletor`
--

CREATE TABLE `coletor` (
  `id_coletor` int NOT NULL,
  `coletor` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `contribuintes`
--

CREATE TABLE `contribuintes` (
  `id_contribuintes` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `telefone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `distritos`
--

CREATE TABLE `distritos` (
  `id_distrito` int NOT NULL,
  `distrito` varchar(255) NOT NULL,
  `geocodigo` int NOT NULL,
  `area` int DEFAULT NULL,
  `empreiteiras_id_empreiteiras` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `distrito_equipe`
--

CREATE TABLE `distrito_equipe` (
  `id_equipe` int NOT NULL,
  `tecnicos_id_tecnico` int NOT NULL,
  `distritos_id_distrito` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `empreiteiras`
--

CREATE TABLE `empreiteiras` (
  `id_empreiteiras` int NOT NULL,
  `nome_empreiteira` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `estoque`
--

CREATE TABLE `estoque` (
  `id_estoque` int NOT NULL,
  `quantidade` int NOT NULL,
  `valor` double NOT NULL,
  `movimentacao` char(1) DEFAULT NULL,
  `protocolo` varchar(255) NOT NULL,
  `observacao` text,
  `materiais_id_materiais` int NOT NULL,
  `estoque_control_id_estoque_control` int NOT NULL,
  `pontos_id_ponto` int NOT NULL,
  `fornecedor_id_fornecedor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `estoque_control`
--

CREATE TABLE `estoque_control` (
  `id_estoque_control` int NOT NULL,
  `observacao` varchar(255) DEFAULT NULL,
  `documento` blob NOT NULL,
  `data_emissao` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `fiscals`
--

CREATE TABLE `fiscals` (
  `id_fiscal` int UNSIGNED NOT NULL,
  `nome` varchar(255) NOT NULL,
  `orgao_fiscalizador` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `fornecedor`
--

CREATE TABLE `fornecedor` (
  `id_fornecedor` int NOT NULL,
  `fornecedor` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `grupo_materiais`
--

CREATE TABLE `grupo_materiais` (
  `id_grupos` int NOT NULL,
  `grupo` varchar(255) NOT NULL,
  `superior` int DEFAULT NULL,
  `dadosPonto` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `materiais`
--

CREATE TABLE `materiais` (
  `id_materiais` int NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `unidade_medida` int DEFAULT NULL,
  `unidades` int DEFAULT NULL,
  `potencia` int DEFAULT NULL,
  `consumo` int DEFAULT NULL,
  `grupo_materiais_id_grupos` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `materiais_movi`
--

CREATE TABLE `materiais_movi` (
  `id_movi` int NOT NULL,
  `estoque_id_estoque` int NOT NULL,
  `quantidade_movi` varchar(255) NOT NULL,
  `data_movi` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id_usuario` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Estrutura para tabela `materias_pontos`
--

CREATE TABLE `materias_pontos` (
  `id_ponto_materiais` int NOT NULL,
  `pontos_id_ponto` int NOT NULL,
  `materias_pontos` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `municipios`
--

CREATE TABLE `municipios` (
  `id_municipio` int UNSIGNED NOT NULL,
  `geocodigo` int NOT NULL,
  `municipio` varchar(255) NOT NULL,
  `uf` varchar(255) NOT NULL,
  `prefeito` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ordem_servicos`
--

CREATE TABLE `ordem_servicos` (
  `id_ordens` int NOT NULL,
  `problema` varchar(255) NOT NULL,
  `descricao_problema` varchar(255) NOT NULL,
  `protocolo` varchar(255) NOT NULL,
  `data_hora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `contribuintes_id_contribuintes` int NOT NULL,
  `user_id_usuario` int NOT NULL,
  `fiscals_id_fiscal` int UNSIGNED NOT NULL,
  `pontos_id_ponto` int NOT NULL,
  `distrito_equipe_id_equipe` int NOT NULL,
  `tp_os_tp_os` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ordem_servico_baixa`
--

CREATE TABLE `ordem_servico_baixa` (
  `id_baixa` int NOT NULL,
  `hora_fim` datetime NOT NULL,
  `atividade_realizada` varchar(255) DEFAULT NULL,
  `observacao_tecnico` varchar(255) DEFAULT NULL,
  `ordem_servicos_id_ordens` int NOT NULL,
  `user_id_usuario` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `permissions`
--

CREATE TABLE `permissions` (
  `id_perm` int NOT NULL,
  `perms` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_id_usuario` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pontos`
--

CREATE TABLE `pontos` (
  `id_ponto` int NOT NULL,
  `barramento` varchar(255) NOT NULL,
  `tombamento` varchar(255) NOT NULL,
  `cep` varchar(255) NOT NULL,
  `rua` varchar(255) NOT NULL,
  `bairro` varchar(255) NOT NULL,
  `geocodigo` int NOT NULL,
  `largura_via` int DEFAULT NULL,
  `largura_passeio` int DEFAULT NULL,
  `pavimento` varchar(255) DEFAULT NULL,
  `medicao` varchar(225) NOT NULL,
  `tipo_poste` varchar(255) NOT NULL,
  `altura` int DEFAULT NULL,
  `conduc` varchar(45) DEFAULT NULL,
  `data_hora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `localizacao` varchar(255) DEFAULT NULL,
  `area` int DEFAULT NULL,
  `posicao` varchar(255) NOT NULL,
  `user_id_usuario` int NOT NULL,
  `municipios_id_municipio` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `seq_transf`
--

CREATE TABLE `seq_transf` (
  `seq_tranf` int NOT NULL,
  `transformadores_id_transf` int NOT NULL,
  `pontos_id_ponto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `smart_city_status`
--

CREATE TABLE `smart_city_status` (
  `dev_id` int NOT NULL,
  `dev_cod` varchar(20) DEFAULT NULL,
  `dev_bat` varchar(20) DEFAULT NULL,
  `dev_volt` varchar(20) DEFAULT NULL,
  `dev_amp` varchar(20) DEFAULT NULL,
  `dev_watt` varchar(20) DEFAULT NULL,
  `dev_hz` varchar(20) DEFAULT NULL,
  `dev_kwh` varchar(20) DEFAULT NULL,
  `dev_fp` varchar(20) DEFAULT NULL,
  `dev_porta` varchar(20) DEFAULT NULL,
  `dev_giro` varchar(20) DEFAULT NULL,
  `dev_temp` varchar(20) DEFAULT NULL,
  `dev_lat` varchar(20) DEFAULT NULL,
  `dev_lng` varchar(20) DEFAULT NULL,
  `dev_onoff` varchar(20) DEFAULT NULL,
  `dev_dimmer` varchar(20) DEFAULT NULL,
  `dev_stat` varchar(20) DEFAULT NULL,
  `dev_data` datetime DEFAULT NULL,
  `pontos_id_ponto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sms`
--

CREATE TABLE `sms` (
  `id_sms` int NOT NULL,
  `destino` varchar(255) NOT NULL,
  `status` int NOT NULL,
  `data_hora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tecnicos`
--

CREATE TABLE `tecnicos` (
  `id_tecnico` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `empreiteiras_id_empreiteiras` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `telefones`
--

CREATE TABLE `telefones` (
  `idtelefones` int NOT NULL,
  `fornecedor_id_fornecedor` int DEFAULT NULL,
  `telefones` varchar(255) DEFAULT NULL,
  `tecnicos_id_tecnico` int DEFAULT NULL,
  `coletor_id_coletor` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `telegestao`
--

CREATE TABLE `telegestao` (
  `id_telegestao` int NOT NULL,
  `mensagem` varchar(255) DEFAULT NULL,
  `origem` varchar(255) DEFAULT NULL,
  `resposta` int DEFAULT NULL,
  `data_hora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pontos_id_ponto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tp_os`
--

CREATE TABLE `tp_os` (
  `tp_os` int NOT NULL,
  `tipo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `transformadores`
--

CREATE TABLE `transformadores` (
  `id_transf` int NOT NULL,
  `potencia` int DEFAULT NULL,
  `distritos_id_distrito` int NOT NULL,
  `pontos_id_ponto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `user`
--

CREATE TABLE `user` (
  `id_usuario` int NOT NULL,
  `user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_log` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `user_log`
--

CREATE TABLE `user_log` (
  `id` int NOT NULL,
  `user_log` varchar(255) NOT NULL,
  `user` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `veiculos`
--

CREATE TABLE `veiculos` (
  `id_veiculo` int UNSIGNED NOT NULL,
  `veiculo` varchar(255) NOT NULL,
  `modelo` varchar(255) DEFAULT NULL,
  `placa` varchar(255) DEFAULT NULL,
  `km` int DEFAULT NULL,
  `munk` int NOT NULL,
  `cesto` int NOT NULL,
  `data_hora` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices de tabelas apagadas
--

--
-- Índices de tabela `coleta`
--
ALTER TABLE `coleta`
  ADD PRIMARY KEY (`id_coleta`),
  ADD KEY `fk_coleta_materiais1_idx` (`materiais_id_materiais`),
  ADD KEY `fk_coleta_coletor1_idx` (`coletor_id_coletor`);

--
-- Índices de tabela `coletor`
--
ALTER TABLE `coletor`
  ADD PRIMARY KEY (`id_coletor`);

--
-- Índices de tabela `contribuintes`
--
ALTER TABLE `contribuintes`
  ADD PRIMARY KEY (`id_contribuintes`);

--
-- Índices de tabela `distritos`
--
ALTER TABLE `distritos`
  ADD PRIMARY KEY (`id_distrito`),
  ADD KEY `fk_distritos_empreiteiras1_idx` (`empreiteiras_id_empreiteiras`);

--
-- Índices de tabela `distrito_equipe`
--
ALTER TABLE `distrito_equipe`
  ADD PRIMARY KEY (`id_equipe`),
  ADD KEY `fk_distrito_equipe_tecnicos1_idx` (`tecnicos_id_tecnico`),
  ADD KEY `fk_distrito_equipe_distritos1_idx` (`distritos_id_distrito`);

--
-- Índices de tabela `empreiteiras`
--
ALTER TABLE `empreiteiras`
  ADD PRIMARY KEY (`id_empreiteiras`);

--
-- Índices de tabela `estoque`
--
ALTER TABLE `estoque`
  ADD PRIMARY KEY (`id_estoque`),
  ADD KEY `fk_estoque_materiais1_idx` (`materiais_id_materiais`),
  ADD KEY `fk_estoque_estoque_control1_idx` (`estoque_control_id_estoque_control`),
  ADD KEY `fk_estoque_pontos1_idx` (`pontos_id_ponto`),
  ADD KEY `fk_estoque_fornecedor1_idx` (`fornecedor_id_fornecedor`);

--
-- Índices de tabela `estoque_control`
--
ALTER TABLE `estoque_control`
  ADD PRIMARY KEY (`id_estoque_control`);

--
-- Índices de tabela `fiscals`
--
ALTER TABLE `fiscals`
  ADD PRIMARY KEY (`id_fiscal`);

--
-- Índices de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`id_fornecedor`);

--
-- Índices de tabela `grupo_materiais`
--
ALTER TABLE `grupo_materiais`
  ADD PRIMARY KEY (`id_grupos`);

--
-- Índices de tabela `materiais`
--
ALTER TABLE `materiais`
  ADD PRIMARY KEY (`id_materiais`),
  ADD KEY `fk_materiais_grupo_materiais_idx` (`grupo_materiais_id_grupos`);

--
-- Índices de tabela `materiais_movi`
--
ALTER TABLE `materiais_movi`
  ADD PRIMARY KEY (`id_movi`),
  ADD KEY `fk_materiais_movi_estoque1_idx` (`estoque_id_estoque`),
  ADD KEY `fk_materiais_movi_user1_idx` (`user_id_usuario`);

--
-- Índices de tabela `materias_pontos`
--
ALTER TABLE `materias_pontos`
  ADD PRIMARY KEY (`id_ponto_materiais`),
  ADD KEY `fk_materias_pontos_pontos1_idx` (`pontos_id_ponto`);

--
-- Índices de tabela `municipios`
--
ALTER TABLE `municipios`
  ADD PRIMARY KEY (`id_municipio`);

--
-- Índices de tabela `ordem_servicos`
--
ALTER TABLE `ordem_servicos`
  ADD PRIMARY KEY (`id_ordens`),
  ADD KEY `fk_ordem_servicos_contribuintes1_idx` (`contribuintes_id_contribuintes`),
  ADD KEY `fk_ordem_servicos_user1_idx` (`user_id_usuario`),
  ADD KEY `fk_ordem_servicos_fiscals1_idx` (`fiscals_id_fiscal`),
  ADD KEY `fk_ordem_servicos_pontos1_idx` (`pontos_id_ponto`),
  ADD KEY `fk_ordem_servicos_distrito_equipe1_idx` (`distrito_equipe_id_equipe`),
  ADD KEY `fk_ordem_servicos_tp_os1_idx` (`tp_os_tp_os`);

--
-- Índices de tabela `ordem_servico_baixa`
--
ALTER TABLE `ordem_servico_baixa`
  ADD PRIMARY KEY (`id_baixa`),
  ADD KEY `fk_ordem_servico_baixa_ordem_servicos1_idx` (`ordem_servicos_id_ordens`),
  ADD KEY `fk_ordem_servico_baixa_user1_idx` (`user_id_usuario`);

--
-- Índices de tabela `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id_perm`),
  ADD KEY `fk_permissions_user1_idx` (`user_id_usuario`);

--
-- Índices de tabela `pontos`
--
ALTER TABLE `pontos`
  ADD PRIMARY KEY (`id_ponto`),
  ADD KEY `fk_pontos_user1_idx` (`user_id_usuario`),
  ADD KEY `fk_pontos_municipios1_idx` (`municipios_id_municipio`);

--
-- Índices de tabela `seq_transf`
--
ALTER TABLE `seq_transf`
  ADD PRIMARY KEY (`seq_tranf`),
  ADD KEY `fk_category_transformadores1_idx` (`transformadores_id_transf`),
  ADD KEY `fk_category_pontos1_idx` (`pontos_id_ponto`);

--
-- Índices de tabela `smart_city_status`
--
ALTER TABLE `smart_city_status`
  ADD PRIMARY KEY (`dev_id`),
  ADD KEY `fk_tb_registro_device_pontos1_idx` (`pontos_id_ponto`);

--
-- Índices de tabela `sms`
--
ALTER TABLE `sms`
  ADD PRIMARY KEY (`id_sms`);

--
-- Índices de tabela `tecnicos`
--
ALTER TABLE `tecnicos`
  ADD PRIMARY KEY (`id_tecnico`),
  ADD KEY `fk_tecnicos_empreiteiras1_idx` (`empreiteiras_id_empreiteiras`);

--
-- Índices de tabela `telefones`
--
ALTER TABLE `telefones`
  ADD PRIMARY KEY (`idtelefones`),
  ADD KEY `fk_telefones_fornecedor1_idx` (`fornecedor_id_fornecedor`),
  ADD KEY `fk_telefones_tecnicos1_idx` (`tecnicos_id_tecnico`),
  ADD KEY `fk_telefones_coletor1_idx` (`coletor_id_coletor`);

--
-- Índices de tabela `telegestao`
--
ALTER TABLE `telegestao`
  ADD PRIMARY KEY (`id_telegestao`),
  ADD KEY `fk_telegestao_pontos1_idx` (`pontos_id_ponto`);

--
-- Índices de tabela `tp_os`
--
ALTER TABLE `tp_os`
  ADD PRIMARY KEY (`tp_os`);

--
-- Índices de tabela `transformadores`
--
ALTER TABLE `transformadores`
  ADD PRIMARY KEY (`id_transf`),
  ADD KEY `fk_transformadores_distritos1_idx` (`distritos_id_distrito`),
  ADD KEY `fk_transformadores_pontos1_idx` (`pontos_id_ponto`);

--
-- Índices de tabela `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Índices de tabela `user_log`
--
ALTER TABLE `user_log`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `veiculos`
--
ALTER TABLE `veiculos`
  ADD PRIMARY KEY (`id_veiculo`);

--
-- AUTO_INCREMENT de tabelas apagadas
--

--
-- AUTO_INCREMENT de tabela `coleta`
--
ALTER TABLE `coleta`
  MODIFY `id_coleta` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `coletor`
--
ALTER TABLE `coletor`
  MODIFY `id_coletor` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `contribuintes`
--
ALTER TABLE `contribuintes`
  MODIFY `id_contribuintes` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `distritos`
--
ALTER TABLE `distritos`
  MODIFY `id_distrito` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `distrito_equipe`
--
ALTER TABLE `distrito_equipe`
  MODIFY `id_equipe` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `empreiteiras`
--
ALTER TABLE `empreiteiras`
  MODIFY `id_empreiteiras` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `estoque`
--
ALTER TABLE `estoque`
  MODIFY `id_estoque` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `estoque_control`
--
ALTER TABLE `estoque_control`
  MODIFY `id_estoque_control` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fiscals`
--
ALTER TABLE `fiscals`
  MODIFY `id_fiscal` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  MODIFY `id_fornecedor` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `grupo_materiais`
--
ALTER TABLE `grupo_materiais`
  MODIFY `id_grupos` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `materiais`
--
ALTER TABLE `materiais`
  MODIFY `id_materiais` int NOT NULL AUTO_INCREMENT COMMENT 'Chave primária.';

--
-- AUTO_INCREMENT de tabela `materiais_movi`
--
ALTER TABLE `materiais_movi`
  MODIFY `id_movi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `materias_pontos`
--
ALTER TABLE `materias_pontos`
  MODIFY `id_ponto_materiais` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `municipios`
--
ALTER TABLE `municipios`
  MODIFY `id_municipio` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ordem_servicos`
--
ALTER TABLE `ordem_servicos`
  MODIFY `id_ordens` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ordem_servico_baixa`
--
ALTER TABLE `ordem_servico_baixa`
  MODIFY `id_baixa` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id_perm` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pontos`
--
ALTER TABLE `pontos`
  MODIFY `id_ponto` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `seq_transf`
--
ALTER TABLE `seq_transf`
  MODIFY `seq_tranf` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `smart_city_status`
--
ALTER TABLE `smart_city_status`
  MODIFY `dev_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sms`
--
ALTER TABLE `sms`
  MODIFY `id_sms` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tecnicos`
--
ALTER TABLE `tecnicos`
  MODIFY `id_tecnico` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `telefones`
--
ALTER TABLE `telefones`
  MODIFY `idtelefones` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `telegestao`
--
ALTER TABLE `telegestao`
  MODIFY `id_telegestao` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tp_os`
--
ALTER TABLE `tp_os`
  MODIFY `tp_os` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `transformadores`
--
ALTER TABLE `transformadores`
  MODIFY `id_transf` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `user`
--
ALTER TABLE `user`
  MODIFY `id_usuario` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `user_log`
--
ALTER TABLE `user_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Restrições para dumps de tabelas
--

--
-- Restrições para tabelas `coleta`
--
ALTER TABLE `coleta`
  ADD CONSTRAINT `fk_coleta_coletor1` FOREIGN KEY (`coletor_id_coletor`) REFERENCES `coletor` (`id_coletor`),
  ADD CONSTRAINT `fk_coleta_materiais1` FOREIGN KEY (`materiais_id_materiais`) REFERENCES `materiais` (`id_materiais`);

--
-- Restrições para tabelas `distritos`
--
ALTER TABLE `distritos`
  ADD CONSTRAINT `fk_distritos_empreiteiras1` FOREIGN KEY (`empreiteiras_id_empreiteiras`) REFERENCES `empreiteiras` (`id_empreiteiras`);

--
-- Restrições para tabelas `distrito_equipe`
--
ALTER TABLE `distrito_equipe`
  ADD CONSTRAINT `fk_distrito_equipe_distritos1` FOREIGN KEY (`distritos_id_distrito`) REFERENCES `distritos` (`id_distrito`),
  ADD CONSTRAINT `fk_distrito_equipe_tecnicos1` FOREIGN KEY (`tecnicos_id_tecnico`) REFERENCES `tecnicos` (`id_tecnico`);

--
-- Restrições para tabelas `estoque`
--
ALTER TABLE `estoque`
  ADD CONSTRAINT `fk_estoque_estoque_control1` FOREIGN KEY (`estoque_control_id_estoque_control`) REFERENCES `estoque_control` (`id_estoque_control`),
  ADD CONSTRAINT `fk_estoque_fornecedor1` FOREIGN KEY (`fornecedor_id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`),
  ADD CONSTRAINT `fk_estoque_materiais1` FOREIGN KEY (`materiais_id_materiais`) REFERENCES `materiais` (`id_materiais`),
  ADD CONSTRAINT `fk_estoque_pontos1` FOREIGN KEY (`pontos_id_ponto`) REFERENCES `pontos` (`id_ponto`);

--
-- Restrições para tabelas `materiais`
--
ALTER TABLE `materiais`
  ADD CONSTRAINT `fk_materiais_grupo_materiais` FOREIGN KEY (`grupo_materiais_id_grupos`) REFERENCES `grupo_materiais` (`id_grupos`);

--
-- Restrições para tabelas `materiais_movi`
--
ALTER TABLE `materiais_movi`
  ADD CONSTRAINT `fk_materiais_movi_estoque1` FOREIGN KEY (`estoque_id_estoque`) REFERENCES `estoque` (`id_estoque`),
  ADD CONSTRAINT `fk_materiais_movi_user1` FOREIGN KEY (`user_id_usuario`) REFERENCES `user` (`id_usuario`);

--
-- Restrições para tabelas `materias_pontos`
--
ALTER TABLE `materias_pontos`
  ADD CONSTRAINT `fk_materias_pontos_pontos1` FOREIGN KEY (`pontos_id_ponto`) REFERENCES `pontos` (`id_ponto`);

--
-- Restrições para tabelas `ordem_servicos`
--
ALTER TABLE `ordem_servicos`
  ADD CONSTRAINT `fk_ordem_servicos_contribuintes1` FOREIGN KEY (`contribuintes_id_contribuintes`) REFERENCES `contribuintes` (`id_contribuintes`),
  ADD CONSTRAINT `fk_ordem_servicos_distrito_equipe1` FOREIGN KEY (`distrito_equipe_id_equipe`) REFERENCES `distrito_equipe` (`id_equipe`),
  ADD CONSTRAINT `fk_ordem_servicos_fiscals1` FOREIGN KEY (`fiscals_id_fiscal`) REFERENCES `fiscals` (`id_fiscal`),
  ADD CONSTRAINT `fk_ordem_servicos_pontos1` FOREIGN KEY (`pontos_id_ponto`) REFERENCES `pontos` (`id_ponto`),
  ADD CONSTRAINT `fk_ordem_servicos_tp_os1` FOREIGN KEY (`tp_os_tp_os`) REFERENCES `tp_os` (`tp_os`),
  ADD CONSTRAINT `fk_ordem_servicos_user1` FOREIGN KEY (`user_id_usuario`) REFERENCES `user` (`id_usuario`);

--
-- Restrições para tabelas `ordem_servico_baixa`
--
ALTER TABLE `ordem_servico_baixa`
  ADD CONSTRAINT `fk_ordem_servico_baixa_ordem_servicos1` FOREIGN KEY (`ordem_servicos_id_ordens`) REFERENCES `ordem_servicos` (`id_ordens`),
  ADD CONSTRAINT `fk_ordem_servico_baixa_user1` FOREIGN KEY (`user_id_usuario`) REFERENCES `user` (`id_usuario`);

--
-- Restrições para tabelas `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `fk_permissions_user1` FOREIGN KEY (`user_id_usuario`) REFERENCES `user` (`id_usuario`);

--
-- Restrições para tabelas `pontos`
--
ALTER TABLE `pontos`
  ADD CONSTRAINT `fk_pontos_municipios1` FOREIGN KEY (`municipios_id_municipio`) REFERENCES `municipios` (`id_municipio`),
  ADD CONSTRAINT `fk_pontos_user1` FOREIGN KEY (`user_id_usuario`) REFERENCES `user` (`id_usuario`);

--
-- Restrições para tabelas `seq_transf`
--
ALTER TABLE `seq_transf`
  ADD CONSTRAINT `fk_category_pontos1` FOREIGN KEY (`pontos_id_ponto`) REFERENCES `pontos` (`id_ponto`),
  ADD CONSTRAINT `fk_category_transformadores1` FOREIGN KEY (`transformadores_id_transf`) REFERENCES `transformadores` (`id_transf`);

--
-- Restrições para tabelas `smart_city_status`
--
ALTER TABLE `smart_city_status`
  ADD CONSTRAINT `fk_tb_registro_device_pontos1` FOREIGN KEY (`pontos_id_ponto`) REFERENCES `pontos` (`id_ponto`);

--
-- Restrições para tabelas `tecnicos`
--
ALTER TABLE `tecnicos`
  ADD CONSTRAINT `fk_tecnicos_empreiteiras1` FOREIGN KEY (`empreiteiras_id_empreiteiras`) REFERENCES `empreiteiras` (`id_empreiteiras`);

--
-- Restrições para tabelas `telefones`
--
ALTER TABLE `telefones`
  ADD CONSTRAINT `fk_telefones_coletor1` FOREIGN KEY (`coletor_id_coletor`) REFERENCES `coletor` (`id_coletor`),
  ADD CONSTRAINT `fk_telefones_fornecedor1` FOREIGN KEY (`fornecedor_id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`),
  ADD CONSTRAINT `fk_telefones_tecnicos1` FOREIGN KEY (`tecnicos_id_tecnico`) REFERENCES `tecnicos` (`id_tecnico`);

--
-- Restrições para tabelas `telegestao`
--
ALTER TABLE `telegestao`
  ADD CONSTRAINT `fk_telegestao_pontos1` FOREIGN KEY (`pontos_id_ponto`) REFERENCES `pontos` (`id_ponto`);

--
-- Restrições para tabelas `transformadores`
--
ALTER TABLE `transformadores`
  ADD CONSTRAINT `fk_transformadores_distritos1` FOREIGN KEY (`distritos_id_distrito`) REFERENCES `distritos` (`id_distrito`),
  ADD CONSTRAINT `fk_transformadores_pontos1` FOREIGN KEY (`pontos_id_ponto`) REFERENCES `pontos` (`id_ponto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
