Assignment 1 README

Steps to execute:

1. Install all the required Perl modules necessary

perl -MCPAN -e 'install Net::SNMP'
perl -MCPAN -e 'install NetSNMP::agent'
perl -MCPAN -e 'install Time::Local'

2. Open the snmpd.conf file and add the following line at the end of the document

perl do "path to your snmp subagent perl script file"

3. Next step is to run the following command in the terminal:

sudo service snmpd restart (do this everytime you change anything in the snmpd.conf script)

4. Finally, run the following command to get the desired result:

snmpget -v 1 -c public localhost .1.3.6.1.4.1.4171.40.1   /-->(.1 gives you UNIX time, .2 gives you the value for counter 1, .3 for value of counter 2)-->/

