use rand::Rng;
use ring::pbkdf2::{self, Algorithm};
use std::num::NonZeroU32;

static ALGORITHM: Algorithm = pbkdf2::PBKDF2_HMAC_SHA512;
const ITERATIONS: NonZeroU32 = unsafe { NonZeroU32::new_unchecked(101_026) }; // Number of iterations for PBKDF2
const SALT_LEN: usize = 32; // 32 bytes salt
const KEY_LEN: usize = 32; // 32 bytes key

pub fn generate_salt() -> [u8; SALT_LEN] {
    rand::thread_rng().gen()
}

pub fn hash(input: &[u8], salt: [u8; SALT_LEN]) -> [u8; KEY_LEN] {
    let mut pbkdf2_hash = [0u8; KEY_LEN];
    pbkdf2::derive(ALGORITHM, ITERATIONS, &salt, input, &mut pbkdf2_hash);
    pbkdf2_hash
}

pub fn verify(input: &[u8], salt: [u8; SALT_LEN], hash: &[u8]) -> bool {
    pbkdf2::verify(ALGORITHM, ITERATIONS, &salt, input, hash).is_ok()
}
