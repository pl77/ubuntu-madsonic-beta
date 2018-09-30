#!/bin/bash

mkdir /config/transcode
ln -s /usr/bin/ffmpeg /config/transcode/ffmpeg

/usr/bin/madsonic --home=/config --default-music-folder=/media

tail -F /config/madsonic_sh.log
