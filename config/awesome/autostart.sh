#!/bin/bash 

# sleep 3 && fetchmail -v -d 300 -f /home/collodi/.fetchmailrc &
offlineimap -u basic > ~/.logs/offlineimap &

tpb &

xset +dpms &
xset dpms 0 0 300 &

urxvtd -f &

#gvim --servername INDEX
# than
# alias vim="gvim --servername INDEX --remote-send '<C-\><C-N>:tabnew<CR>' --remote "

firefox 2>/dev/null &
ionice -c3 -p`pidof firefox` &  # set firefox's IO worst priority

mocp -S &
LANG=cs_CZ.utf8 conky & 
conky -c ~/.conkyrc-log &
conky -c ~/.conkyrc-ascii &

pystopwatch &

# awesome and java apps (blank window solution)
wmname LG3D &
synclient HorizTwoFingerScroll=1
synclient HorizEdgeScroll=1
