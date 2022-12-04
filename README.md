# mailspoofcheck
This script checks for the presence and configuration of SPF, DMARC, and DKIM records for a given domain.

## Usage
To run the script, first make sure it is executable by running **chmod +x mailspoofcheck.sh**. Then, run the script with the domain name as the argument, like this:

```bash
./mailspoofcheck example.com
```

## Output

The script will output the SPF, DMARC, and DKIM records for the given domain, as well as any additional information about the configuration of these records.

## Dependencies

This script requires the **dig** command to be installed. **dig** is part of the **dnsutils** package on Ubuntu and Debian, and can be installed with **apt-get install dnsutils**. On other systems, check with your package manager to see if **dig** is available.
