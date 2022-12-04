#!/bin/bash
# Mathijs Verschuuren - 05-2022

# Set colors
RED='\033[0;31m'
GREEN="\033[0;32m"
BWhite="\033[1;37m"
Yellow="\033[0;33m"
NC='\033[0m' # No Color

# Print SPF records
printf "${BWhite}Enumerating SPF records...\n${NC}"
printf "\n"
dig TXT $1 +short
printf "\n"
printf "${Yellow}Use the following link for more info: https://mxtoolbox.com/SuperTool.aspx?action=spf:$1&run=toolpage \n${NC}"
printf "\n"

# Print DMARC records
printf "${BWhite}Enumerating DMARC records...\n${NC}"
if dig TXT _dmarc.$1 +short | grep -q 'reject'; then
  printf "${GREEN}DMARC is configured secure using reject!\n${NC}"
fi
if dig TXT _dmarc.$1 +short | grep -q 'quarantine'; then
  printf "${GREEN}DMARC is configured secure using quarantine, spoofed emails will be delivered to spam folder!\n${NC}"
fi
if dig TXT _dmarc.$1 +short | grep -q 'none'; then
  printf "${RED}DMARC is not configured secure using none, spoofed emails will be delivered to inbox folder!\n${NC}"
fi
if [[ $(dig TXT _dmarc.$1 +short | wc -c) -eq 0 ]]; then
  printf "${RED}DMARC is not configured!, spoofed emails will be delivered to inbox folder!\n${NC}"
fi
printf "\n"

# Print DKIM info
printf "${BWhite}DKIM:\n${NC}"

# Check for DKIM record
if dig TXT $1 +short | grep -q 'dkim'; then
  printf "${GREEN}DKIM record exists for $1\n${NC}"

  # Check for popular selectors
  popular_selectors=("google" "mailgun" "zoho" "sendgrid" "salesforce")
  for selector in "${popular_selectors[@]}"; do
    printf "Checking for selector $selector..."

    # Check if selector matches DKIM record
    if dig TXT $selector._domainkey.$1 +short | grep -q 'dkim'; then
      printf "${GREEN}match\n${NC}"
    else
      printf "${RED}no match\n${NC}"
    fi
  done
else
  printf "${RED}No DKIM record found for $1.\n"
  printf "${RED}To view the DKIM record, view the mail source of a received email from $1 and search for 'dkim='\n${NC}"
fi
