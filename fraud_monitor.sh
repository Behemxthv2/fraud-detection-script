#!/bin/bash
# ============================================================
# fraud_monitor.sh
# Author: Darren Bridges
# Description: Simulates monitoring of financial transactions
#              to detect suspicious patterns — built from
#              real-world fraud prevention experience in
#              banking and financial services.
# ============================================================

LOGFILE="transactions.log"
REPORT="fraud_report.txt"
THRESHOLD_AMOUNT=9000       # Flag amounts just under $10,000 (structuring)
THRESHOLD_ATTEMPTS=3        # Flag accounts with 3+ attempts in one session
THRESHOLD_TIME=60           # Flag multiple transactions within 60 seconds

echo "============================================"
echo "  FRAUD PATTERN DETECTION REPORT"
echo "  Generated: $(date)"
echo "============================================"
echo ""

# Check if log file exists
if [[ ! -f "$LOGFILE" ]]; then
    echo "[ERROR] Transaction log file not found: $LOGFILE"
    echo "Please run generate_sample_log.sh first to create sample data."
    exit 1
fi

echo "Analyzing transactions in: $LOGFILE"
echo "--------------------------------------------"
echo ""

# --- FLAG 1: Structuring Detection ---
# Transactions just under $10,000 are a known fraud indicator
echo "[CHECK 1] Structuring Detection (amounts \$8,000 - \$9,999)"
echo "--------------------------------------------"
STRUCTURING=$(awk -F',' '$3 >= 8000 && $3 < 10000 {print "  Account: "$1" | Amount: $"$3" | Date: "$2}' "$LOGFILE")

if [[ -z "$STRUCTURING" ]]; then
    echo "  No structuring patterns detected."
else
    echo "$STRUCTURING"
    echo ""
    echo "  ⚠ WARNING: Transactions near \$10,000 may indicate structuring."
    echo "  Recommended Action: Flag for compliance review."
fi

echo ""

# --- FLAG 2: Repeated Transaction Attempts ---
# Same account appearing multiple times = suspicious
echo "[CHECK 2] Repeated Account Activity (3+ transactions)"
echo "--------------------------------------------"
awk -F',' '{print $1}' "$LOGFILE" | sort | uniq -c | sort -rn | while read COUNT ACCOUNT; do
    if [[ $COUNT -ge $THRESHOLD_ATTEMPTS ]]; then
        echo "  ⚠ Account: $ACCOUNT | Transactions: $COUNT (exceeds threshold of $THRESHOLD_ATTEMPTS)"
        echo "  Recommended Action: Review account history and verify member identity."
    fi
done

echo ""

# --- FLAG 3: High Value Transactions ---
echo "[CHECK 3] High Value Transactions (over \$9,999)"
echo "--------------------------------------------"
HIGH_VALUE=$(awk -F',' '$3 > 9999 {print "  Account: "$1" | Amount: $"$3" | Date: "$2}' "$LOGFILE")

if [[ -z "$HIGH_VALUE" ]]; then
    echo "  No high value transactions detected."
else
    echo "$HIGH_VALUE"
    echo ""
    echo "  ⚠ WARNING: Transactions over \$9,999 require mandatory CTR filing."
    echo "  Recommended Action: Verify CTR has been submitted to FinCEN."
fi

echo ""

# --- FLAG 4: Duplicate Amounts ---
echo "[CHECK 4] Duplicate Transaction Amounts (same account, same amount)"
echo "--------------------------------------------"
awk -F',' '{print $1"-"$3}' "$LOGFILE" | sort | uniq -c | sort -rn | while read COUNT KEY; do
    if [[ $COUNT -ge 2 ]]; then
        ACCOUNT=$(echo $KEY | cut -d'-' -f1)
        AMOUNT=$(echo $KEY | cut -d'-' -f2)
        echo "  ⚠ Account: $ACCOUNT | Amount: \$$AMOUNT | Occurrences: $COUNT"
        echo "  Recommended Action: Verify these are not duplicate submissions."
    fi
done

echo ""
echo "============================================"
echo "  SCAN COMPLETE"
echo "  Review flagged items and escalate as needed"
echo "  per your organization's fraud policy."
echo "============================================"
