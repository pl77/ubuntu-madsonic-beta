#!/bin/bash

mkdir /var/madsonic/transcode
ln -s /usr/bin/ffmpeg /var/madsonic/transcode/ffmpeg

/usr/bin/madsonic --home=/config --default-music-folder=/media

tail -F /config/madsonic_sh.log
