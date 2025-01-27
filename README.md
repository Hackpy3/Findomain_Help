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

If you'd like, share any specific errors or behaviors, and I can guide you further!
---

Let me know if you need help with any specific workflow!
