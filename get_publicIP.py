#!/usr/bin/python3

# Opens text document which contains stdout of "curl ipinfo.io"
# and processes text for conky
#
# by Martynas J. 2019

import sys

def update_label(info):
        try:
            with open("/tmp/publicIP.tmp","r") as IPfile: 
                Text = IPfile.read()
            splited_string_array = Text.split()

            filtered_string_array=[]
            for i in splited_string_array:
                filtered_string_array.append(i.replace(':', "").replace(',', "").replace('{', "")
                    .replace('}', "").replace('"', "").replace(' ', ""))

            filtered_string_array.pop(0)
            filtered_string_array.pop(-1)

            IP = ""
            COUNTRY = ""
            CITY = ""
            ORG = ""

            count = 0
            for j in filtered_string_array:
                if j == "ip":
                    IP = filtered_string_array[count+1]
                elif j == "city":
                    CITY = filtered_string_array[count+1]
                elif j == "country":
                    COUNTRY = filtered_string_array[count+1]
                elif j == "org":
                    ORG = " ".join(filtered_string_array[count+1:-1])

                count = count + 1
            
            if info == "IP":
                print(IP)
            elif info == "COUNTRY":
                print(COUNTRY)
            elif info == "CITY":
                print(CITY)
            elif info == "ORG":
                print(ORG)
            else:
                print("'" + info + "'" + " is invalid parameter. Only use: IP, CITY, COUNTRY, ORG")

        except:
            print("Error: /tmp/publicIP.tmp doesn't exist.")


def main():
    try:
        update_label(sys.argv[1])
    except:
        print("Error. Pass only these parameters: IP, CITY, COUNTRY, ORG.")

main()
     