#!/bin/bash
# ============================================================
# generate_sample_log.sh
# Generates a sample transactions.log file for testing
# fraud_monitor.sh — uses fictional account numbers only
# ============================================================

cat > transactions.log << 'EOF'
ACC-10042,2026-05-01,8500,CHECK_DEPOSIT
ACC-10042,2026-05-01,8750,CHECK_DEPOSIT
ACC-10042,2026-05-01,9100,CHECK_DEPOSIT
ACC-20187,2026-05-02,500,WITHDRAWAL
ACC-30291,2026-05-02,15000,WIRE_TRANSFER
ACC-40382,2026-05-03,9500,CHECK_DEPOSIT
ACC-50491,2026-05-03,250,WITHDRAWAL
ACC-50491,2026-05-03,250,WITHDRAWAL
ACC-60183,2026-05-04,1200,DEPOSIT
ACC-70294,2026-05-04,9800,CHECK_DEPOSIT
ACC-80391,2026-05-05,300,WITHDRAWAL
ACC-10042,2026-05-05,8900,CHECK_DEPOSIT
EOF

echo "Sample transaction log created: transactions.log"
echo "You can now run: ./fraud_monitor.sh"
