#!/bin/bash

do_copy_config()
{
  CONFIG=$1
  SRC=/etc/aceproxy/$CONFIG
  DEST=$2

  if [[ -z $DEST ]]; then
    DEST=.
  fi

  DEST=/home/tv/aceproxy-master/$DEST/$CONFIG

  if [[ ! -f $SRC ]]; then
    return 0
  fi

  install -m 0644 -o tv $SRC $DEST
}

adjust_settings()
{
  sed -i 's/acespawn = False/acespawn = True/' /home/tv/aceproxy-master/aceconfig.py
  sed -i 's/vlcuse = False/vlcuse = True/' /home/tv/aceproxy-master/aceconfig.py
  sed -i 's/vlcspawn = False/vlcspawn = True/' /home/tv/aceproxy-master/aceconfig.py
  sed -i 's/videoobey = True/videoobey = False/' /home/tv/aceproxy-master/aceconfig.py
}

do_copy_config aceconfig.py
do_copy_config p2pproxy.py     plugins/config
do_copy_config torrenttelik.py plugins/config
do_copy_config torrenttv.py    plugins/config
do_copy_config allfon.py       plugins/config

adjust_settings

exec /usr/bin/supervisord
