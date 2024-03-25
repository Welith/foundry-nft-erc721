# My first NFTs

This repo contains my first attempt of creating ERC721 tokens (NFTs). I have a basic NFT, and some dynamic ones, that can be modified on chain.

## Set-up

1. You need to clone the repo:

```bash
git clone https://github.com/Welith/foundry-nft-erc721
```

2. As all my other repos, I've created a `Makefile`, which will help you deploy all contracts. You can deploy and mint a basic NFT and a dynamic one.

3. Before minting any of the NFTs, you will need to run `make build`, so that you install and compile all of the required code.

4. For the NFTs, you need to run the `make deploy-*` + `make mint-*` based on the one you want, either `basic` or `mood`.

5. You have the option of running it on your local `anvil`, or run ot the `sepolia` testnet.