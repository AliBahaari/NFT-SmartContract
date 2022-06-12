// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721URIStorage, Ownable {
  uint256 public tokenId;

  constructor() ERC721("NFTToken", "NFTT") {
    tokenId = 0;
  }

  function transfer(address seller, uint256 value) public {
    payable(seller).transfer(value);
  }

  function mint(address buyer, string memory tokenUri)
    public
    returns (uint256)
  {
    uint256 currentTokenId = tokenId;

    _safeMint(buyer, currentTokenId);
    _setTokenURI(currentTokenId, tokenUri);

    tokenId += 1;

    return currentTokenId;
  }

  function burn(uint256 _tokenId) public onlyOwner returns (uint256) {
    require(_exists(_tokenId), "Token ID doesn't exist.");
    _burn(_tokenId);

    return _tokenId;
  }
}
