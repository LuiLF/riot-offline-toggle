# Riot Offline Toggle

Ferramenta desenvolvida em Batch Script (`.bat`) para automatizar o bloqueio e a restauração de determinadas conexões de rede utilizadas pelos serviços sociais do Riot Client, permitindo jogar sem aparecer online na lista de amigos.

O projeto utiliza o Firewall do Windows para gerenciar regras de saída, sem modificar os arquivos dos jogos.

> **Aviso:** Este é um projeto independente, sem vínculo com a Riot Games. Seu funcionamento pode ser afetado por atualizações do Riot Client ou alterações na infraestrutura de rede.

## Funcionalidades

- Ativação e desativação do bloqueio por meio de scripts `.bat`.
- Criação e remoção de regras no Firewall do Windows.
- Bloqueio de conexões TCP destinadas às portas 5222 e 5223.
- Identificação do endereço IPv4 de um servidor de chat da Riot.
- Verificação de privilégios administrativos.
- Remoção de regras anteriores para evitar duplicações.

## Requisitos

- Windows com Firewall do Windows habilitado.
- Permissões de administrador.
- Riot Client instalado.

## Como utilizar

### Ativar o modo offline

1. Feche o Riot Client e os jogos da Riot.
2. Execute `ativar-offline.bat` como administrador.
3. Aguarde a aplicação das regras de firewall.
4. Reinicie o Riot Client e abra o jogo desejado.

### Desativar o modo offline

1. Execute `desativar-offline.bat` como administrador.
2. Aguarde a remoção das regras de firewall.
3. Reinicie o Riot Client para restaurar a conectividade dos serviços sociais.

## Funcionamento técnico

O projeto utiliza o comando `netsh advfirewall` para configurar regras de bloqueio de tráfego de saída no Firewall do Windows.

O script de ativação realiza as seguintes operações:

1. Verifica se está sendo executado com privilégios administrativos.
2. Remove regras anteriores com os mesmos nomes.
3. Bloqueia conexões TCP de saída destinadas às portas 5222 e 5223.
4. Consulta o endereço `br.chat.si.riotgames.com` para identificar seu IPv4.
5. Caso a resolução seja bem-sucedida, cria uma regra de bloqueio para o endereço identificado.

O script de desativação remove as regras criadas, incluindo uma regra IPv6 utilizada em uma versão anterior.

### Regras de firewall

| Regra                | Finalidade                                               |
| -------------------- | -------------------------------------------------------- |
| `LoL_Offline_Portas` | Bloquear conexões TCP de saída nas portas 5222 e 5223.   |
| `LoL_Offline_IP`     | Bloquear conexões TCP de saída para o IPv4 identificado. |
| `LoL_Offline_v6`     | Regra antiga removida pelo script de desativação.        |

A versão atual não utiliza bloqueio de faixas IPv6, evitando a restrição excessiva de endereços pertencentes a outros serviços.

## Testes realizados

O funcionamento foi testado manualmente em ambiente Windows com os seguintes jogos:

- League of Legends
- Valorant
- Teamfight Tactics (TFT)

Nos testes realizados, o bloqueio permitiu utilizar os jogos sem aparecer online na lista de amigos.

Os resultados representam o ambiente testado e não garantem compatibilidade com todas as versões do cliente ou configurações de rede.

## Limitações e cuidados

- As regras de firewall são aplicadas ao sistema, não exclusivamente aos processos da Riot.
- O bloqueio pode interferir em outros aplicativos que utilizem as mesmas portas ou endereços.
- O endereço IPv4 do servidor é consultado a cada execução do script de ativação. Caso o endereço mude enquanto o bloqueio estiver ativo, será necessário executar o script novamente para atualizar a regra.
- A resolução do endereço IPv4 pode falhar dependendo do ambiente.
- Atualizações do Riot Client podem alterar o funcionamento da ferramenta.
- O projeto não garante invisibilidade em todos os serviços ou jogos.
- A compatibilidade com as políticas da Riot Games não foi verificada.

## Tecnologias utilizadas

- **Batch Script:** automação de comandos no Windows.
- **Windows Defender Firewall:** gerenciamento de regras de tráfego de rede.
- **TCP/IP:** controle de conexões de saída.
- **DNS:** resolução de nomes de domínio para endereços IP.
- **Netsh:** configuração do firewall pela linha de comando.

## Desenvolvimento

A implementação inicial foi gerada com auxílio de inteligência artificial. Posteriormente, os scripts foram analisados, testados e revisados para melhorar o gerenciamento das regras de firewall, a verificação de privilégios administrativos e o tratamento de erros.

O projeto também foi utilizado como exercício prático de redes de computadores e automação no Windows.
