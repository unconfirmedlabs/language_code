# Language Code

A Sui Move package providing validated ISO 639-1 language codes as on-chain types.

> Formerly published as `gengo`. Renamed to `language_code` for a literal,
> standard-named pairing with [`country_code`](https://github.com/unconfirmedlabs/country_code).

## Overview

`language_code` provides a `LanguageCode` struct that wraps a validated
two-letter ISO 639-1 language code string. All 184 standard codes are supported.
Invalid codes are rejected at construction time, so any `LanguageCode` value in
your program is always valid.

## Published packages

Both deployments are immutable.

| Network | Package ID | Transaction digest |
| --- | --- | --- |
| Mainnet | `0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea` | `DjjhVQp9EUR2ySkQdpdj7vKVx2i18rY8yDh7ow92ENUn` |
| Testnet | `0xac318126565a2fab608984a091b3582ba9cda6c32232f567eef50277c5042c36` | `6BhecjQ6mdmq2d85iuA17fzZNfUK5jfUA9vDWC3QPdCb` |

## Usage

### Add as a dependency

```toml
[dependencies]
language_code = { git = "https://github.com/unconfirmedlabs/language_code.git", rev = "main" }
```

### Import and use

```move
module example::my_module;

use language_code::language_code::{Self, LanguageCode};

public struct Post has key, store {
    id: UID,
    content: String,
    language: LanguageCode,
}

public fun create_post(content: String, lang: String, ctx: &mut TxContext): Post {
    Post {
        id: object::new(ctx),
        content,
        language: language_code::new(lang), // aborts if invalid
    }
}
```

## API

### `language_code::language_code`

| Function | Signature | Description |
|---|---|---|
| `new` | `public fun new(code: String): LanguageCode` | Creates a `LanguageCode` from a string. Aborts with `EInvalidLanguageCode` if the code is not a valid ISO 639-1 code. |
| `code` | `public fun code(language_code: &LanguageCode): String` | Returns the underlying two-letter code string. |

### Types

- **`LanguageCode`** — A wrapper struct with `copy`, `drop`, and `store` abilities. Can be a field in other structs, stored in tables, and passed by value.

### Errors

| Code | Name | Description |
|---|---|---|
| 0 | `EInvalidLanguageCode` | The provided string is not a valid ISO 639-1 language code. |

## Supported Codes

All 184 ISO 639-1 two-letter codes, from `aa` (Afar) to `zu` (Zulu). See
[the full ISO 639-1 list](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).

## License

MIT
