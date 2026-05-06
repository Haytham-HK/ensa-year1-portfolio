#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import hmac
import os
from pqcrypto.kem import ml_kem_512


def _derive_symmetric_key(shared_secret: bytes) -> bytes:
    return hashlib.sha256(shared_secret + b"|team1-mlkem-demo|").digest()


def _keystream(key: bytes, nonce: bytes, length: int) -> bytes:
    out = bytearray()
    counter = 0
    while len(out) < length:
        block = hashlib.sha256(key + nonce + counter.to_bytes(4, "big")).digest()
        out.extend(block)
        counter += 1
    return bytes(out[:length])


def _xor_encrypt(key: bytes, plaintext: bytes) -> tuple[bytes, bytes, bytes]:
    nonce = os.urandom(12)
    stream = _keystream(key, nonce, len(plaintext))
    ciphertext = bytes(a ^ b for a, b in zip(plaintext, stream))
    tag = hmac.new(key, nonce + ciphertext, hashlib.sha256).digest()[:16]
    return nonce, ciphertext, tag


def _xor_decrypt(key: bytes, nonce: bytes, ciphertext: bytes, tag: bytes) -> bytes:
    expected = hmac.new(key, nonce + ciphertext, hashlib.sha256).digest()[:16]
    if not hmac.compare_digest(expected, tag):
        raise ValueError("Authentication tag mismatch.")
    stream = _keystream(key, nonce, len(ciphertext))
    return bytes(a ^ b for a, b in zip(ciphertext, stream))


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Mini-projet Team 1: demo ML-KEM + chiffrement de message"
    )
    parser.add_argument(
        "-m",
        "--message",
        default="Bonjour CC&V, ceci est un message protege par ML-KEM.",
        help="Message a proteger",
    )
    args = parser.parse_args()

    print("=== Demo Post-Quantique (ML-KEM / Kyber) ===")
    print()

    print("[1] Generation de cles (Bob)...")
    public_key, secret_key = ml_kem_512.generate_keypair()
    print(f"    - Public key size : {len(public_key)} bytes")
    print(f"    - Secret key size : {len(secret_key)} bytes")
    print("    - Statut          : OK")
    print()

    print("[2] Encapsulation (Alice avec la cle publique de Bob)...")
    kem_ciphertext, shared_secret_alice = ml_kem_512.encrypt(public_key)
    print(f"    - KEM ciphertext size : {len(kem_ciphertext)} bytes")
    print(f"    - Shared secret size  : {len(shared_secret_alice)} bytes")
    print("    - Statut              : OK")
    print()

    print("[3] Decapsulation (Bob avec sa cle secrete)...")
    shared_secret_bob = ml_kem_512.decrypt(secret_key, kem_ciphertext)
    same_secret = shared_secret_alice == shared_secret_bob
    print(f"    - Secret partage identique : {same_secret}")
    print()

    print("[4] Chiffrement symetrique du message avec secret derive...")
    symmetric_key = _derive_symmetric_key(shared_secret_alice)
    plaintext = args.message.encode("utf-8")
    nonce, ciphertext, tag = _xor_encrypt(symmetric_key, plaintext)
    print(f"    - Message original : {args.message}")
    print(f"    - Nonce (hex)      : {nonce.hex()}")
    print(f"    - Ciphertext (hex) : {ciphertext.hex()}")
    print(f"    - Tag (hex)        : {tag.hex()}")
    print()

    print("[5] Dechiffrement par Bob...")
    symmetric_key_bob = _derive_symmetric_key(shared_secret_bob)
    recovered = _xor_decrypt(symmetric_key_bob, nonce, ciphertext, tag).decode("utf-8")
    same_message = recovered == args.message
    print(f"    - Message dechiffre : {recovered}")
    print(f"    - Message identique : {same_message}")
    print()

    print("=== Resume ===")
    print(f"Generation des cles: success")
    print(f"Shared secret match: {same_secret}")
    print(f"Decrypted message equals original: {same_message}")


if __name__ == "__main__":
    main()
