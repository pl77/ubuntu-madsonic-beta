FROM ubuntu:18.04

# Madsonic Package Information

# Install Apt Packages, link fonts, set locale
RUN apt-get update && apt-get install -y \
  ca-certificates \
  locales \
  openjdk-8-jre \
  unzip \
  wget \
  ffmpeg \
  fonts-noto-cjk \
  fonts-noto-mono \
  fonts-noto-hinted \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/fonts/fallback \
  && ln -s /usr/share/fonts/opentype/noto/*CJK*.ttc /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/fonts/fallback/ \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
  && localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8

ENV LANG en_US.utf8

# Volumes
VOLUME /var/madsonic
VOLUME /config
VOLUME /media

# Madsonic Package Information
ENV PKG_NAME madsonic
ENV PKG_VER 6.3
ENV PKG_BUILD 9840
ENV PKG_DATE 20180107

ENV DEB_NAME ${PKG_DATE}_${PKG_NAME}-${PKG_VER}.${PKG_BUILD}.deb
RUN wget http://madsonic.org/download/${PKG_VER}/${DEB_NAME}
RUN dpkg -i ${DEB_NAME}

# Create hardlinks to the transcoding binaries.
# This way we can mount a volume over /var/madsonic.
# <host-dir>/var/madsonic/transcode/ffmpeg -> /usr/local/bin/ffmpeg
#RUN ln /var/madsonic/transcode/ffmpeg /usr/local/bin

# Expose ports
EXPOSE 4040
EXPOSE 4050

# Startup
ADD ./start.sh /start.sh
RUN chmod +x  /start.sh

ENTRYPOINT ["/start.sh"]
