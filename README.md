# mailspoofcheck
A simple bash script to check if a domain is susceptible to mail spoofing.

* Make sure you have dig installed. If you don't have dig, you can install it by running sudo apt-get install dnsutils (for Ubuntu) or brew install bind-tools (for MacOS)
* Save the script and make it executable by running chmod +x script-name.sh
* Run the script by typing ./script-name.sh followed by the domain you want to check. For example, to check google.com, you would run ./script-name.sh google.com.

The script will output the SPF and DMARC records for the domain you specified, and provide information about the security of the DMARC configuration. It will also provide instructions on how to view the DKIM record for the domain.
