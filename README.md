## Validator Pass

The Genesis Validator Pass (GVP) ERC721 token contract.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
forge build
```

### Test

```shell
forge test
```

### Deploy

```shell
make deploy
```

## Local chain

```shell
anvil
make local-fund ADDRESS="YOURADDRESSHERE"
```

### Analyze

```shell
make slither
make mythril TARGET=Counter.sol
```

### Help

```shell
forge --help
anvil --help
cast --help
```
