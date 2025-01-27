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

---

Let me know if you need help with any specific workflow!
