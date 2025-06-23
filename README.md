# WalletWithGuardians Smart Contract

## 📜 Descrição

Este contrato Solidity implementa uma **carteira Ethereum multifuncional com segurança avançada**, incluindo:

- Proprietário único (owner) com controle total.
- Recebimento de fundos por qualquer método (receive e fallback).
- Permissões de gastos configuráveis via **allowance** para outros endereços.
- Sistema de **guardians** (5 no total) para troca do owner em casos de perda de acesso.
- Troca do owner com aprovação de pelo menos 3 dos 5 guardians.
- Eventos para rastreamento transparente de todas as ações importantes.

---

## 🚀 Funcionalidades

### Proprietário (owner)

- Pode enviar fundos para qualquer endereço sem restrições.
- Define allowances para que outros endereços gastem parte dos fundos da carteira.
- Pode configurar guardians que podem votar para mudar o owner.

### Allowance

- O owner pode definir um limite para cada endereço autorizado.
- O endereço autorizado pode gastar até esse limite da carteira.
- O allowance é reduzido a cada gasto autorizado.

### Guardians

- 5 guardians podem ser definidos pelo owner.
- Guardians podem propor um novo owner.
- Quando pelo menos 3 guardians concordam com o mesmo novo owner, a propriedade é transferida.
- Evita que o owner fique preso fora da carteira, aumentando a segurança.

---

## 📦 Estrutura do contrato

- `owner` — endereço do dono da carteira.
- `allowance` — mapping que registra o quanto cada endereço pode gastar.
- `guardians` — mapping para controlar quem são os guardians.
- `guardiansVotes` — mapping para registrar votos dos guardians para troca do owner.
- Eventos para `FundsSent`, `AllowanceChanged`, `GuardianVote` e `NewOwner`.

---

## 🛠 Como usar

1. **Deploy:**  
   Faça deploy do contrato com sua carteira (que se tornará owner).

2. **Configurar guardians:**  
   Chame a função `setGuardian(address _guardian, bool _isGuardian)` para definir os 5 guardians.

3. **Definir allowances:**  
   Owner chama `setAllowance(address _spender, uint _amount)` para autorizar endereços a gastar fundos.

4. **Gastar via allowance:**  
   Endereços autorizados usam `spendFund(address payable _to, uint _amount)` para transferir fundos dentro do limite.

5. **Transferir fundos diretamente:**  
   Owner usa `sendFunds(address payable _to, uint _amount)` para enviar qualquer valor para qualquer endereço.

6. **Troca de owner por guardians:**  
   Guardians chamam `proposeNewOwner(address _newOwner)` para votar em um novo owner.  
   Com 3 ou mais votos, o owner é alterado automaticamente.

---

## 🔐 Segurança

- Uso de `require` para garantir permissões e condições.
- Controle de gastos via allowance.
- Sistema de votação para evitar tomada de controle indevida.
- Eventos emitidos para transparência.
- Uso de `.call{value: amount}("")` para transferência segura de ETH.

---

## 📄 Licença

MIT License

---

## 📌 Contato

  
[LinkedIn](https://www.linkedin.com/in/vinicavalheiro/) | [GitHub](https://github.com/vinicavalheiro)

---

## 📌 Referências

- [Solidity Documentation](https://docs.soliditylang.org/)
- [OpenZeppelin Contracts](https://openzeppelin.com/contracts/)
- [Etherscan](https://etherscan.io/)

---

