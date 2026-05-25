# Fraud Pattern Detection Script

A bash script that analyzes financial transaction logs to detect common fraud indicators — built from real-world experience identifying and stopping fraudulent transactions in a high-volume financial services environment.

## Background

Over 3 years working in financial services, I personally identified and stopped 100+ fraudulent check deposit attempts. This script automates the pattern recognition process I used manually every day — flagging suspicious transactions so they can be reviewed and escalated before financial losses occur.

## What It Detects

| Check | Description |
|---|---|
| Structuring | Transactions between $8,000–$9,999 (known tactic to avoid CTR reporting) |
| Repeated Activity | Accounts with 3+ transactions in the same session |
| High Value | Transactions over $9,999 requiring mandatory CTR filing |
| Duplicate Amounts | Same account submitting identical amounts multiple times |

## How to Use

**Step 1 — Generate sample data:**
```bash
chmod +x generate_sample_log.sh
./generate_sample_log.sh
```

**Step 2 — Run the fraud monitor:**
```bash
chmod +x fraud_monitor.sh
./fraud_monitor.sh
```

**Step 3 — Review the output:**
The script will print a full report flagging any suspicious patterns found in the transaction log.

## Sample Output

```
============================================
  FRAUD PATTERN DETECTION REPORT
  Generated: Mon May 25 2026
============================================

[CHECK 1] Structuring Detection ($8,000 - $9,999)
--------------------------------------------
  Account: ACC-10042 | Amount: $8500 | Date: 2026-05-01
  Account: ACC-10042 | Amount: $8750 | Date: 2026-05-01
  ⚠ WARNING: Transactions near $10,000 may indicate structuring.
  Recommended Action: Flag for compliance review.

[CHECK 2] Repeated Account Activity (3+ transactions)
--------------------------------------------
  ⚠ Account: ACC-10042 | Transactions: 4 (exceeds threshold of 3)
  Recommended Action: Review account history and verify member identity.
```

## Skills Demonstrated

- Bash scripting (conditionals, loops, awk, sort, uniq)
- Log file parsing and pattern analysis
- Security awareness and fraud detection logic
- Regulatory knowledge (BSA/CTR requirements)
- Documentation and reporting

## Disclaimer

All account numbers and transaction data in this project are completely fictional and generated for testing purposes only. No real member data was used.

## Author

**Darren Bridges**
CompTIA Security+ | Pursuing M.S. Cybersecurity (UMGC)
[LinkedIn](https://linkedin.com/in/darren-bridges-8986733b2)
