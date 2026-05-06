# Mini-projet Team 1 — Demo ML-KEM (Kyber)

Ce mini-projet montre un flux simple de cryptographie post-quantique:

1. Generation de cles ML-KEM (Bob)
2. Encapsulation d'un secret partage (Alice)
3. Decapsulation du meme secret (Bob)
4. Chiffrement/dechiffrement d'un message avec une cle derivee

## Prerequis

- Python 3.10+ (3.12 fonctionne)

## Installation

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Execution

```bash
python pqc_demo.py
```

Message personnalise:

```bash
python pqc_demo.py --message "Bonjour prof, demo post-quantique Team 1"
```

## Sortie attendue (extrait)

Les trois lignes importantes pour la presentation:

- `Generation des cles: success`
- `Shared secret match: True`
- `Decrypted message equals original: True`

## Note

Le chiffrement du message dans cette demo est volontairement pedagogique (flux XOR + HMAC) pour garder le projet simple.
En production, il faut utiliser une construction standard de chiffrement authentifie (ex: AES-GCM ou ChaCha20-Poly1305).
