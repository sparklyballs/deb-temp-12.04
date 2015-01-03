# set base os
FROM ubuntu:12.04
ENV DEBIAN_FRONTEND noninteractive
# Set correct environment variables
ENV HOME /root



# Install Dependencies ,add startup files and debfile
RUN mkdir -p /root/advancestore
ADD src/sparkly-kodi-headless_20150102.0272aff-1_amd64.deb  /root/kodi.deb
ADD src/advancedsettings.xml /advancestore/
ADD src/firstrun.sh /root/firstrun.sh
RUN chmod +x /root/firstrun.sh && \
apt-get update && \
apt-get install -y software-properties-common python-software-properties && \
add-apt-repository ppa:team-xbmc/ppa && \
apt-get update && \
apt-get install -y libbluray1 kodi-eventclients-xbmc-send && \
add-apt-repository --remove ppa:team-xbmc/ppa && \
apt-get install -y libbluetooth3 libxslt1.1 fonts-liberation libaacs0 libasound2 libass4 libasyncns0 libavcodec53 libavfilter2 libavformat53 libavutil51 libcaca0 libcap2 libcdio13 libcec1 libcrystalhd3 libdrm-nouveau2 libenca0 libflac8 libfontenc1 libgl1-mesa-dri libgl1-mesa-glx libglapi-mesa libglew1.6 libglu1-mesa libgsm1 libice6 libjson0 liblcms1 libllvm3.4 liblzo2-2 libmad0 libmicrohttpd5 libmikmod2 libmodplug1 libmp3lame0 libmpeg2-4 libmysqlclient18 liborc-0.4-0 libpcrecpp0 libplist1 libpostproc52 libpulse0 libpython2.7 libschroedinger-1.0-0 libsdl-mixer1.2 libsdl1.2debian libshairport1 libsm6 libsmbclient libsndfile1 libspeex1 libswscale2 libtalloc2 libtdb1 libtheora0 libtinyxml2.6.2 libtxc-dxtn-s2tc0 libva-glx1 libva-x11-1 libva1 libvdpau1 libvorbisfile3 libvpx1 libwbclient0 libwrap0 libx11-xcb1 libxaw7 libxcb-glx0 libxcb-shape0 libxmu6 libxpm4 libxt6 libxtst6 libxv1 libxxf86dga1 libxxf86vm1 libyajl1 mesa-utils mysql-common python-cairo python-gobject-2 python-gtk2 python-imaging python-support tcpd ttf-liberation libssh-4 libtag1c2a libcurl3-gnutls libnfs1 supervisor && \


# Install deb file and set permissions for files etc..
cd /root && \
dpkg -i kodi.deb && \
rm -rf /root/kodi.deb
ADD src/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Set ports
EXPOSE 9777/udp 8080/tcp
ENTRYPOINT ["/usr/bin/supervisord"]
