#!/bin/bash

# DNS tool


main () {

host="$1";

query () {
        echo -e "\n  ##  DNS info - $host -  ##\n";

        # Print WHOIS data if available
        whois_data="$(whois $host | grep -E 'Name Server:|Registrar:|Registry\sExpiry\sDate:')";
        if [ "$whois_data" != "" ]; then
                echo -e " # WHOIS\n\n$whois_data\n";
        fi

        # Print available records
        for rec in "NS" "A" "MX" "TXT"; do
                record_data=$(dig $rec $host +short);
                if [ "$record_data" != "" ]; then
                        echo -e " # in $rec\n$record_data\n";
                fi
        done
}

# If FQDN provided as $1 query DNS else print usage
if [ $(echo "$host" | grep -Eio '[[:alpha:]][[:alnum:]-]*\.([[:alpha:]][[:alnum:]-]*\.?){1,}') ]; then
        query;
else
        echo "cannot dig $host"
        echo -e "\nUsage: digaj <hostname>\n";

fi
}



# wait until you have entire code then execute
main $1

