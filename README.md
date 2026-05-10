# Shay-Rolls Guard — Production Protection Engine

> Production watchdog for teams using Claude Code Enterprise.
> Protects against deletions, truncations, firewall changes, and infrastructure damage.
> Built by [Giggso](https://giggso.com). Open sourced under MIT.

---

## What Is This?

Shay-Rolls Guard is the **production protection layer** — a separate product from Shay-Rolls Core.

| | Shay-Rolls Core | Shay-Rolls Guard |
|---|---|---|
| **Audience** | Developers | DevOps, Architects, Security |
| **Job** | Coding discipline | Production protection |
| **Triggers** | Dev actions | System events |
| **Blocks** | Bad code patterns | Destructive operations |

---

## The 6 Guard Agents

| Agent | Watches | Hard Blocks | Approval Flow |
|---|---|---|---|
| `guard-git-watch` | Deletions, force push, config wipes | Force push, config wipe | Flagged deletions |
| `guard-db-watch` | Truncations, mass deletes, schema drops | TRUNCATE, DROP | >100 rows, index delete |
| `guard-infra-watch` | Terraform, S3, VMs, network | State file, destroy | S3 delete, VM terminate |
| `guard-observability-watch` | Logs, metrics, access patterns | — | P1 page, P2 email |
| `guard-firewall-watch` | Firewall rules, ports, egress | 0.0.0.0/0, RDP, SSH public | Rule changes |
| `guard-incident-manager` | All Guard alerts | — | P1/P2/P3 + SLA |

---

## How It Works

```
System event detected (git push, DB query, infra change, firewall rule)
      ↓
Guard agent fires
      ↓
Destructive? → HARD BLOCK + escalation
Approval needed? → Email Prism7 + auto PR
      ↓
First responder approves/rejects
      ↓
Full audit trail in Git history
```

---

## Intentional Deletions

Developers flag intentional deletions in commit messages:

```bash
git commit -m "refactor: remove legacy module [GUARD:ALLOW-DELETE]"
```

This triggers approval flow instead of hard block.

---

## Incident Severity

| Level | SLA | Who Gets Notified |
|---|---|---|
| P1 Critical | 15 min | Escalation contact SMS + Prism7 CRITICAL |
| P2 High | 1 hour | Prism7 HIGH + team lead |
| P3 Medium | 24 hours | Prism7 daily digest |

---

## Getting Started

```bash
cd ~/AntiGravity_Projects/YourProject
bash ../shay-rolls-claude-guard/shay-rolls-guard-init.sh
```

---

## Repo Structure

```
shay-rolls-claude-guard/
├── README.md
├── CLAUDE.md
├── LICENSE
├── shay-rolls-guard-init.sh
├── guard/
│   ├── agents/
│   │   ├── guard-git-watch.md
│   │   ├── guard-db-watch.md
│   │   ├── guard-infra-watch.md
│   │   ├── guard-observability-watch.md
│   │   ├── guard-firewall-watch.md
│   │   └── guard-incident-manager.md
│   ├── hooks/
│   └── ci/
└── manifest/
    ├── manifest.schema.json
    └── manifest.secrets.example.json
```

---

## License

MIT — Built by [Giggso](https://giggso.com).
