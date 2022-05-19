#!/bin/bash
target_file='/rw/config/vpn/openvpn-client.ovpn'
cd /rw/config/vpn
zenity --question --text="Have you copied all the openvpn config files to this directory?" --ok-label="Yes" --cancel-label="No"
if [ $? = 0 ] ; then
  zenity --question --text="Please select the openvpn configuration file"
  if [ $? = 0 ] ; then
    client_file=`zenity --file-selection`
    if grep -q '^client' "$client_file" ; then
      if [ "$client_file" != "$target_file" ]; then
        mv $client_file $target_file
      fi
      grep -q '^redirect-gateway def1' $target_file || echo 'redirect-gateway def1' >> $target_file
      details="$(zenity --forms --text="If you have a username and password, enter them here.\nOtherwise hit cancel." --add-entry username --add-entry password)"
      if [ $? = 0 ]; then
        oIFS="$IFS"
        IFS="|"
        arrIN=($details)
        echo ${arrIN[0]} > pass.txt
        echo ${arrIN[1]} >> pass.txt
        IFS="$oIFS"
        unset oIFS
        if grep -q ^auth-user-pass $target_file; then
          sed -i '/auth-user-pass/s/.*/auth-user-pass pass.txt/' $target_file
        else
          echo "auth-user-pass pass.txt" >> $target_file
        fi
      fi
      if grep "<ca>" "$target_file"; then
        sed -n '/<ca>/,/\/ca>/{//!p} ' "$target_file" > ca.crt
        sed -i '/<ca>/,/\/ca>/d' "$target_file"
        echo 'ca ca.crt' >> "$target_file"
      fi
      if grep "<cert>"  "$target_file"; then
        sed -n '/<cert>/,/\/cert>/{//!p}' "$target_file" > client.crt
        sed -i '/<cert>/,/\/cert>/d' "$target_file"
        echo 'cert client.crt'  >> "$target_file"
      fi
      if grep "RSA PRIVATE KEY" "$target_file"; then
        sed -n '/<key>/,/\/key>/{//!p}' "$target_file" > client.key
        sed -i '/<key>/,/\/key>/d' "$target_file"
        echo 'key client.key'  >> "$target_file"
      fi
      sed -i '/^script-security/d' $target_file
      sed -i '/^up/d' $target_file
      sed -i '/^down/d' $target_file
      echo "script-security 2" >> $target_file
      echo "up 'qubes-vpn-handler.sh up'" >> $target_file
      echo "down 'qubes-vpn-handler.sh down'" >> $target_file
      sed -i s^/.*/^^ $target_file
    else
     zenity --error --text="That doesn't look like a client config file"
     exit
    fi
  else
    zenity --error --text="You need a config file\nCheck with your VPN provider"
    exit
  fi
else
  exit
fi
