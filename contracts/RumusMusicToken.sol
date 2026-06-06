contract RumusMusicToken is ERC20 {
    constructor() ERC20("Rumus Music Token", "RMT") {
        _mint(msg.sender, 100000000 ether);
    }
}
