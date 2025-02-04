#!/bin/bash

TARGET=$1
OUTPUT_DIR="./results/$TARGET"

mkdir -p $OUTPUT_DIR

# Step 1: Subdomain Enumeration
findomain -t $TARGET -o -u $OUTPUT_DIR/subdomains.txt

# Step 2: DNS Validation
dnsx -l $OUTPUT_DIR/subdomains.txt -o $OUTPUT_DIR/validated_subdomains.txt

# Step 3: Port Scanning
naabu -iL $OUTPUT_DIR/validated_subdomains.txt -o $OUTPUT_DIR/open_ports.txt

# Step 4: HTTP Probing
cat $OUTPUT_DIR/open_ports.txt | httprobe > $OUTPUT_DIR/live_hosts.txt

# Step 5: Vulnerability Scanning
nuclei -l $OUTPUT_DIR/live_hosts.txt -o $OUTPUT_DIR/vuln_scan_results.txt
