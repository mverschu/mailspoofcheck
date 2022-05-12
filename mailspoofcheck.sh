#!/bin/bash
# Mathijs Verschuuren - 05-2022

RED='\033[0;31m'
GREEN="\033[0;32m"
BWhite="\033[1;37m"
Yellow="\033[0;33m"
NC='\033[0m' # No Color

printf "${BWhite}Enumerating SPF records...\n${NC}"
printf "\n"
dig TXT $1 +short
printf "\n"
printf "${Yellow}Use the following link for more info: https://mxtoolbox.com/SuperTool.aspx?action=spf:$1&run=toolpage \n${NC}"
printf "\n"
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
printf "${BWhite}DKIM:\n${NC}"
printf "${RED}View mail source on received mail from customer and search for: dkim=\n${NC}"
