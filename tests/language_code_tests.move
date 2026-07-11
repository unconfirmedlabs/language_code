// Copyright (c) Unconfirmed Labs, LLC
// SPDX-License-Identifier: MIT

#[test_only]
module language_code::language_code_tests;

// Aliased so the bare `language_code` name stays free for `abort_code = …`.
use language_code::language_code as lc;
use std::unit_test::assert_eq;

#[test]
fun accepts_valid_codes() {
    assert_eq!(lc::new(b"en".to_string()).code(), b"en".to_string());
    assert_eq!(lc::new(b"ja".to_string()).code(), b"ja".to_string());
    // First and last entries of the ISO 639-1 list.
    assert_eq!(lc::new(b"aa".to_string()).code(), b"aa".to_string());
    assert_eq!(lc::new(b"zu".to_string()).code(), b"zu".to_string());
}

#[test, expected_failure(abort_code = language_code::language_code::EInvalidLanguageCode)]
fun rejects_unassigned_code() {
    let _ = lc::new(b"zz".to_string());
    abort
}

#[test, expected_failure(abort_code = language_code::language_code::EInvalidLanguageCode)]
fun rejects_wrong_length() {
    let _ = lc::new(b"eng".to_string());
    abort
}
