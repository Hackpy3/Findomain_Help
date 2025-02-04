# Findomain_Help
Here are additional **usage examples** and options for using **Findomain** effectively:

---

### **Basic Usage**
1. **Enumerate Subdomains:**
   ```bash
   findomain -t example.com
   ```

2. **Save Results to a File:**
   By default, results are saved to a file named `example.com.txt` in the current directory.
   ```bash
   findomain -t example.com -o
   ```

3. **Print Results on Screen Only (No File Output):**
   ```bash
   findomain -t example.com --stdout
   ```

---

### **Advanced Options**
1. **Specify a List of Domains:**
   Enumerate subdomains for multiple domains in a file:
   ```bash
   findomain -f domains.txt
   ```
   Example `domains.txt` file:
   ```
   example.com
   test.com
   ```

2. **Filter Out Subdomains Without Specific Keywords:**
   Use the `-q` flag to filter results containing specific keywords.
   ```bash
   findomain -t example.com -q api
   ```

3. **Specify an Output Directory:**
   Save results to a custom directory:
   ```bash
   findomain -t example.com -o -r /path/to/output/
   ```

4. **Exclude Wildcard Subdomains:**
   Filter out wildcard subdomains (e.g., `*.example.com`):
   ```bash
   findomain -t example.com --unique
   ```

5. **Silent Mode:**
   Run without printing banners or verbose output:
   ```bash
   findomain -t example.com --silent
   ```

---

### **Combining Findomain with Other Tools**
1. **Pipe Results to Other Tools:**
   You can use `--stdout` to directly pass results to other tools.
   ```bash
   findomain -t example.com --stdout | httpx -silent
   ```

2. **Combine with Nmap for Port Scanning:**
   ```bash
   findomain -t example.com --stdout | nmap -iL - -p 80,443
   ```

3. **Combine with Tools Like Sublist3r:**
   Merge results from multiple tools:
   ```bash
   findomain -t example.com --stdout > subdomains1.txt
   sublist3r -d example.com -o subdomains2.txt
   cat subdomains1.txt subdomains2.txt | sort -u > final_subdomains.txt
   ```

---

### **Using API Keys for Improved Results**
Findomain can leverage APIs for more comprehensive results. To set this up:

1. Create the configuration file:
   ```bash
   mkdir -p ~/.config/findomain
   nano ~/.config/findomain/config.toml
   ```

2. Add your API keys:
   ```toml
   virustotal_api_key = "YOUR_VIRUSTOTAL_API_KEY"
   securitytrails_api_key = "YOUR_SECURITYTRAILS_API_KEY"
   shodan_api_key = "YOUR_SHODAN_API_KEY"
   censys_api_key = "YOUR_CENSYS_API_ID:YOUR_CENSYS_SECRET"
   ```
   
3. Run Findomain to use these APIs:
   ```bash
   findomain -t example.com
   ```

---

### **Examples for Different Use Cases**
1. **Check Subdomains and Save Unique Results:**
   ```bash
   findomain -t example.com -u unique_subdomains.txt
   ```

2. **Subdomains with IP Address Resolution:**
   ```bash
   findomain -t example.com --resolve
   ```

3. **Use as a Background Process:**
   ```bash
   nohup findomain -t example.com -o > findomain.log &
   ```

4. **Find Subdomains of Subdomains:**
   Findomain doesn’t recursively resolve subdomains, but you can use output as input:
   ```bash
   findomain -t example.com --stdout | findomain -f - -o
   ```

---

### **Help and Full Options**
Run the following to see all available options:
```bash
findomain --help
```
The output you shared indicates that Findomain is successfully querying various APIs to find subdomains for the target domain (`facebook.com`). However, if the tool appears stuck or not returning results, here are some possible reasons and solutions:

---

### **Possible Issues and Fixes**
1. **API Keys Not Configured**:
   Many APIs require valid keys to return results, especially for larger or well-known domains like `facebook.com`. 
   - Ensure that you have configured API keys for the services that require them.
   - Create a configuration file (`~/.config/findomain/config.toml`) and include your API keys. For example:
     ```toml
     virustotal_api_key = "YOUR_API_KEY"
     securitytrails_api_key = "YOUR_API_KEY"
     censys_api_key = "YOUR_API_ID:YOUR_API_SECRET"
     ```

2. **Network Connectivity Issues**:
   Ensure you have an active internet connection and no firewalls or proxies are blocking the API requests.

3. **Rate Limiting by APIs**:
   Some APIs might throttle requests or block you temporarily if you exceed their rate limits.
   - Use authenticated requests by setting up API keys.
   - Avoid querying frequently in a short time frame.

4. **Domain Restrictions**:
   For large domains like `facebook.com`, some APIs might have restrictions or may not provide data.

5. **Outdated Findomain Version**:
   Ensure you're using the latest version of Findomain. Update it by:
   - Re-downloading the binary from the [GitHub Releases](https://github.com/findomain/findomain/releases).
   - If installed via `cargo`:
     ```bash
     cargo install findomain --force
     ```

6. **Timeouts or Errors from Specific APIs**:
   Some APIs may be temporarily down or unresponsive. If Findomain hangs, you can disable specific APIs by running:
   ```bash
   findomain -t facebook.com --disable-certspotter --disable-archiveorg
   ```

---

### **Debugging the Issue**
1. Run Findomain with verbose output:
   ```bash
   findomain -t facebook.com --verbose
   ```
   This might provide more detailed logs about what's happening.

2. Test individual APIs:
   Use only one API at a time to isolate any problematic services. For example:
   ```bash
   findomain -t facebook.com --only-certspotter
   ```

---

### **Alternative Subdomain Enumeration**
If Findomain is still not returning results, consider using additional tools alongside it:

1. **Amass**:
   ```bash
   amass enum -d facebook.com
   ```

2. **Subfinder**:
   ```bash
   subfinder -d facebook.com
   ```

3. **Combining Tools**:
   Merge results from multiple tools:
   ```bash
   findomain -t facebook.com --stdout > findomain_results.txt
   amass enum -d facebook.com -o amass_results.txt
   subfinder -d facebook.com -o subfinder_results.txt
   cat findomain_results.txt amass_results.txt subfinder_results.txt | sort -u > final_results.txt
   ```

---

For highly advanced use cases, you can integrate **Findomain** with larger automation workflows, deep analysis tools, and API integrations. Below are some advanced examples that showcase its versatility in offensive and defensive security workflows.

---

# **1. Subdomain Enumeration with Output Analysis**

#### **Advanced Filtering with Regex**
To filter results containing specific patterns (e.g., "dev" or "staging"):
```bash
findomain -t example.com -o
cat example.com.txt | grep -E 'dev|staging' > filtered_results.txt
```

#### **Finding Subdomains Excluding a Pattern**
Exclude certain subdomains (e.g., "cdn"):
```bash
cat example.com.txt | grep -v 'cdn' > clean_results.txt
```

---

### **2. Combining with Subdomain Takeover Detection**

Use tools like **subjack** or **subzy** to identify potential subdomain takeovers:
```bash
findomain -t example.com -o
subjack -w example.com.txt -t 50 -timeout 30 -o takeover_results.txt -ssl
```

For real-time takeover checking:
```bash
findomain -t example.com | subzy
```

---

### **3. Leveraging Findomain in CI/CD Pipelines**

#### **GitHub Actions for Continuous Monitoring**
Create a GitHub Actions workflow to monitor subdomain changes automatically.

**Workflow File (`.github/workflows/findomain.yml`):**
```yaml
name: Subdomain Monitoring

on:
  schedule:
    - cron: '0 0 * * *'  # Run daily

jobs:
  run_findomain:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Install Findomain
        run: |
          wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux
          chmod +x findomain-linux
          sudo mv findomain-linux /usr/local/bin/findomain

      - name: Run Findomain
        run: findomain -t example.com -o -u results.txt

      - name: Commit Results
        run: |
          git config --global user.name "GitHub Action"
          git config --global user.email "action@github.com"
          git add results.txt
          git commit -m "Updated subdomain results"
          git push
```

---

### **4. DNS-Based Subdomain Enumeration and Validation**

Use Findomain with **dnsx** for DNS resolution validation:
```bash
findomain -t example.com -o
dnsx -l example.com.txt -resp-only -o validated_domains.txt
```

Combine with **massdns** for large-scale DNS resolution:
```bash
findomain -t example.com -o
massdns -r resolvers.txt -t A -o S -w massdns_output.txt example.com.txt
```

---

### **5. Subdomain Enumeration with Active Reconnaissance**

#### **Using HTTP Probing**
Identify live web servers on the discovered subdomains:
```bash
findomain -t example.com -o
cat example.com.txt | httprobe > live_hosts.txt
```

#### **Screenshot Capturing with Eyewitness**
Generate screenshots of live subdomains:
```bash
eyewitness --web -f live_hosts.txt -d screenshots
```

---

### **6. Cloud-Specific Subdomain Recon**

#### **AWS-Specific Subdomain Enumeration**
Enumerate and validate subdomains hosted on AWS:
```bash
findomain -t example.com -o
cat example.com.txt | grep -E '\.s3\.amazonaws\.com|\.cloudfront\.net' > aws_subdomains.txt
```

#### **Checking for Public Buckets**
Combine with **s3scanner** to check for public AWS S3 buckets:
```bash
s3scanner -l aws_subdomains.txt
```

---

### **7. Integrating APIs for Deeper Recon**

#### **SecurityTrails API Integration**
If you have a SecurityTrails API key, configure it in `~/.findomain.toml`:
```toml
[SecurityTrails]
api_key = "your_api_key"
```

Run Findomain to use this integration:
```bash
findomain -t example.com -s
```

#### **Passive Total Integration**
Combine Findomain results with Passive Total for historical DNS data:
```bash
findomain -t example.com -o
passivetotal -d example.com.txt > dns_history.txt
```

---

### **8. Monitoring Subdomain Changes Over Time**

#### **Tracking Subdomain Additions**
Save previous results and compare with new scans:
```bash
findomain -t example.com -o
diff previous_results.txt example.com.txt > new_subdomains.txt
```

#### **Email Alerts for New Subdomains**
Automate email alerts when new subdomains are detected:
```bash
if [ -s new_subdomains.txt ]; then
  echo "New subdomains detected!" | mail -s "Subdomain Alert" youremail@example.com
fi
```

---

### **9. Automating Port Scanning and Vulnerability Detection**

#### **Port Scanning with Naabu**
Identify open ports on discovered subdomains:
```bash
findomain -t example.com -o
naabu -iL example.com.txt -o open_ports.txt
```

#### **Integrating with Nuclei for Vulnerability Scanning**
Combine subdomain enumeration with template-based vulnerability scanning:
```bash
findomain -t example.com -o
nuclei -l example.com.txt -o nuclei_results.txt
```

---

### **10. Advanced Workflow for Bug Bounty**

#### Full Workflow Script:
```bash
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
```

Run the script:
```bash
bash recon_pipeline.sh example.com
```

---

These examples demonstrate how Findomain can be part of larger offensive security workflows. Let me know if you'd like assistance with any specific integrations!
