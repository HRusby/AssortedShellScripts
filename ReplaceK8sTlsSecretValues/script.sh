crt="CertificateVal"
key="KeyVal"

# Replace Certificate field
# Assumptions:
#       The values of identifiers "Certificate" & "key" are on the field below the identifier
# Modifiers:
#       x - Ignore Whitespace within command text (i.e. allows us to make the regex readable)
#       s - Newline now included in '.'
#       e - Evaluate the Contents of the substitution section
# Both of the below regexes could be combined, however, this adds an assumption of "certificate" being before "key" or vice-versa
perl -i.bak -p0e "s/
        #### Regex ####
        secret:                 # Match "secret:"
        (.*?)                   # Group 1: Everything between "secret:" and "certificate:"
        certificate:            # Match "certificate:"
        (.*?)[\n\r]             # Group 2: Everything between "certificate" and CarriageReturn
        ([^\S\n\r]*)            # Group 3: NonCarriage-Return Whitespace 
        \S*                     # Match the Certificate Text
        #### Substition ####
        /\"secret:\$1certificate:\$2\n\$3${crt}\"
        #### Modifiers ####
        /xse" ./perlRegexTest.txt
# For Key portion
perl -i.bak -p0e "s/            
        #### Regex ####
        secret:                 # Match "secret:"
        (.*?)                   # Group 1: Everything between "secret:" and "key:"
        key:                    # Match "key:"
        ([^\n\r]*)[\n\r]        # Group 2: Any characters until NewLine
        ([^\S\n\r]*)            # Group 3: Any whitespace that is not a carriage return
        \S*                     # The Key Text
        #### Substition ####
        /\"secret:\$1key:\$2\n\$3${key}\"
        #### Modifiers ####
        /xse" ./perlRegexTest.txt 
