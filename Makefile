-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo "  make fund [ARGS=...]\n    example: make fund ARGS=\"--network sepolia\""

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :;  forge install smartcontractkit/foundry-chainlink-toolkit --no-commit && forge install foundry-rs/forge-std --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast
MINT_ARGS := --rpc-url http://localhost:8545 --sender ${ANVIL_KEY} --private-key $(DEFAULT_ANVIL_KEY) --broadcast -vvvv



ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --account METAMASK_SEPOLIA --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
	MINT_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --account METAMASK_SEPOLIA --sender ${METAMASK_KEY} --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy-basic:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft $(NETWORK_ARGS)

deploy-mood:
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft $(NETWORK_ARGS)

mint-basic:
	@forge script script/Interactions.s.sol:MintBasicNft $(MINT_ARGS)


mint-mood:
	@forge script script/Interactions.s.sol:MintMoodNft $(MINT_ARGS)

flip-mood:
	@forge script script/Interactions.s.sol:FlipMoodNft $(MINT_ARGS)