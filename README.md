# Server maintenance & hardening (Bash)

Zbiór skryptów do podstawowego utrzymania i twardnienia hostów Debian/Ubuntu:
- aktualizacje pakietów, autoremove
- twardnienie SSH (bez logowania hasłem), podstawy UFW
- logrotate i sanity checks usług

## Użycie
```bash
sudo ./scripts/update_harden.sh
```

> Uruchamiaj świadomie; zwłaszcza wyłączenie logowania hasłem w SSH wymaga kluczy publicznych!

## TODO
- Integracja z fail2ban
- Testy „idempotentne” (wiele uruchomień bez efektów ubocznych)
- Dodatkowe sanity checks (dysk, pamięć, uptime)
