# Gengo

A Sui Move package providing validated ISO 639-1 language codes as on-chain types.

## Overview

Gengo provides a `LanguageCode` struct that wraps a validated two-letter ISO 639-1 language code string. All 184 standard language codes are supported. Invalid codes are rejected at construction time, ensuring that any `LanguageCode` value in your program is always valid.

## Usage

### Add as a dependency

```toml
[dependencies]
gengo = { git = "https://github.com/unconfirmedlabs/gengo.git", rev = "main" }
```

### Import and use

```move
module example::my_module;

use gengo::language_code::{Self, LanguageCode};

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

### `gengo::language_code`

| Function | Signature | Description |
|---|---|---|
| `new` | `public fun new(code: String): LanguageCode` | Creates a `LanguageCode` from a string. Aborts with `EInvalidLanguageCode` if the code is not a valid ISO 639-1 code. |
| `code` | `public fun code(language_code: &LanguageCode): String` | Returns the underlying two-letter code string. |

### Types

- **`LanguageCode`** — A wrapper struct with `copy`, `drop`, and `store` abilities. Can be used as a field in other structs, stored in tables, and passed by value.

### Errors

| Code | Name | Description |
|---|---|---|
| 0 | `EInvalidLanguageCode` | The provided string is not a valid ISO 639-1 language code. |

## Supported Codes

All 184 ISO 639-1 two-letter codes are supported, from `aa` (Afar) to `zu` (Zulu). See [the full ISO 639-1 list](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) for reference.

## License

MIT
