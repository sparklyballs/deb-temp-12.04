# set base os
FROM ubuntu:12.04
ENV DEBIAN_FRONTEND noninteractive
# Set correct environment variables
ENV HOME /root



# Install Dependencies ,add startup files and debfile


RUN mkdir -p /root/advancestore
ADD src/sparkly-kodi-headless_20150103.ad747d9-1_amd64.deb  /root/kodi.deb
ADD src/advancedsettings.xml /advancestore/
ADD src/firstrun.sh /root/firstrun.sh

RUN chmod +x /root/firstrun.sh && \
apt-get update && \
apt-get install -y wget cmake build-essential supervisor software-properties-common python-software-properties && \
add-apt-repository ppa:team-xbmc/ppa && \
add-apt-repository ppa:team-xbmc/xbmc-ppa-build-depends && \
apt-get update && \
apt-get install -y curl fontconfig-config fonts-liberation libaacs0 libafpclient0 libao-common libao4 libasound2 libass4 libasyncns0 libavahi-client3 libavahi-common-data libavahi-common3 libbluetooth3 libbluray1 libcap2 libcdio13 libcec2 libcrystalhd3 libcurl3 libenca0 libflac8 libfontconfig1 libfontenc1 libfreetype6 libfribidi0 libgl1-mesa-dri libgl1-mesa-glx libglapi-mesa libglew1.6 libglu1-mesa libice6 libjpeg-turbo8 libjpeg8 libjs-jquery libjson0 liblcms1 libllvm3.0 liblockdev1 liblzo2-2 libmad0 libmicrohttpd5 libmp3lame0 libmysqlclient18 libnfs1 libogg0 libpcrecpp0 libpulse0 libpython2.7 libsdl2 libshairplay0 libshairport1 libsm6 libsmbclient libsndfile1 libssh-4 libtalloc2 libtdb1 libtiff4 libtinyxml2.6.2 libva-intel-vaapi-driver libva-x11-1 libva1 libvdpau1 libvorbis0a libvorbisenc2 libvorbisfile3 libwbclient0 libwrap0 libx11-6 libx11-data libx11-xcb1 libxau6 libxaw7 libxcb-glx0 libxcb-shape0 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxdmcp6 libxext6 libxfixes3 libxft2 libxi6 libxinerama1 libxml2 libxmu6 libxmuu1 libxpm4 libxrandr2 libxrender1 libxslt1.1 libxss1 libxt6 libxtst6 libxv1 libxxf86dga1 libxxf86vm1 libyajl1 mesa-utils mysql-common python-bluez python-central python-imaging python-simplejson python-support sgml-base tcpd ttf-dejavu-core ttf-liberation x11-common x11-utils xml-core && \
add-apt-repository --remove ppa:team-xbmc/ppa && \
add-apt-repository --remove ppa:team-xbmc/xbmc-ppa-build-depends  && \

wget http://pkgs.fedoraproject.org/lookaside/pkgs/taglib/taglib-1.8.tar.gz/dcb8bd1b756f2843e18b1fdf3aaeee15/taglib-1.8.tar.gz && \
tar xzf taglib-1.8.tar.gz && \
cd taglib-1.8 && \
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_RELEASE_TYPE=Release . && \
make && \
make install && \
apt-get purge --remove -y wget cmake build-essential software-properties-common python-software-properties && \
apt-get autoremove -y && \ 
apt-get clean

# Install deb file and set permissions for files etc..
cd /root && \
dpkg -i kodi.deb && \
rm -rf /root/kodi.deb
ADD src/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Set ports
EXPOSE 9777/udp 8080/tcp
ENTRYPOINT ["/root/firstrun.sh"]
