// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// Token implementation Standard
contract AleToken {

  string  public name = "Ale Token";
  string  public symbol = "ATK";
  string  public standard = "Ale Token v1.0";
  uint256 public totalSupply;

  // Lista che conterrà il saldo degli account
  mapping(address => uint256) public balanceOf;

  // Includerà tutti gli account autorizzati a prelevare da un determinato account insieme alla somma di prelievo consentita per ciascuno.
  mapping(address => mapping (address => uint256)) public allowance;

  // Assegno il totale di token da creare e resi disponibili e il propretario di questi, cioè chi ha deployato il contract
  constructor(uint256 total) public {
    totalSupply = total;
    balanceOf[msg.sender] = totalSupply;
  }

  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
  event Transfer(address indexed _from, address indexed _to, uint256 _value);

  // Come suggerisce il nome, la funzione di trasferimento viene utilizzata per spostare la quantità di gettoni numTokens dal saldo del proprietario a quello di un altro utente o destinatario. Il proprietario trasferente è msg.sender cioè colui che esegue la funzione, il che implica che solo il proprietario dei token può trasferirli ad altri.
  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_value <= balanceOf[msg.sender]);
    balanceOf[msg.sender] = balanceOf[msg.sender]-=_value;
    balanceOf[_to] = balanceOf[_to]+=_value;
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  //Ciò che fa l'approvazione è consentire a un proprietario, ad esempio msg. Mittente, di approvare un account delegato, possibilmente il marketplace stesso, di ritirare i token dal proprio account e di trasferirli ad altri account.
  function approve(address _spender, uint256 _value) public returns (bool) {
    allowance[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  // Trasferisce token da un account ad un altro
  function transferFrom(address _from, address _to, uint _value) public returns (bool) {
    require(_value <= balanceOf[_from]);
    require(_value <= allowance[_from][msg.sender]);
    balanceOf[_from] = balanceOf[_from]-=_value;
    balanceOf[_to] = balanceOf[_to]+=_value;
    allowance[_from][msg.sender] = allowance[_from][msg.sender]-=_value;
    emit Transfer(_from, _to, _value);
    return true;
  }
}