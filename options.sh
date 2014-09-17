#!/bin/bash
# You can override config options very easily.
# Just create a custom options file; it may be version specific:
# - custom-options.sh
# - custom-options-5.sh
# - custom-options-5.3.sh
# - custom-options-5.3.1.sh
#
# Don't touch this file here - it would prevent you to just "svn up"
# your phpfarm source code.

#
#  See http://thejibe.com/blog/14/02/phpfarm
#

version=$1
vmajor=$2
vminor=$3
vpatch=$4

#gcov='--enable-gcov'
configoptions="\
--enable-bcmath \
--enable-calendar \
--enable-exif \
--enable-ftp \
--enable-mbstring \
--enable-pcntl \
--enable-soap \
--enable-sockets \
--enable-sqlite-utf8 \
--enable-wddx \
--enable-zip \
--with-openssl \
--with-zlib \
--with-gettext \
--with-libdir=lib \
--enable-memory-limit \
--with-regex=php \
--enable-sysvsem \
--enable-sysvshm \
--enable-sysvmsg \
--enable-track-vars \
--enable-trans-sid \
--with-bz2 \
--enable-ctype \
--without-gdbm \
--with-iconv \
--enable-filepro \
--enable-shmop \
--with-libxml-dir=/usr \
--with-kerberos=/usr \
--with-openssl \
--enable-dbx \
--with-system-tzdata \
--with-mysql=/usr \
--with-mysqli=/usr/bin/mysql_config \
--enable-pdo \
--with-pdo-mysql=/usr \
--enable-fastcgi \
--enable-force-cgi-redirect \
--with-curl \
--enable-bcmath \
--enable-calendar \
--enable-exif \
--enable-ftp \
--with-gd \
--with-zlib-dir=/usr \
--with-gettext=/usr \
--enable-mbstring \
--with-mcrypt=/usr \
--with-mhash \
--with-mime-magic \
--enable-soap \
--enable-sockets \
--with-tidy \
--enable-wddx \
--with-xsl=/usr \
--with-zip \
--enable-zip \
--with-imap=/usr \
--with-imap-ssl=/usr \
--with-xpm-dir=/usr \
--with-jpeg-dir=/usr \
--with-png-dir=/usr \
$gcov"

# These don't compile:
# --with-t1lib=/usr \
# --with-freetype-dir=/usr \
#

echo $version $vmajor $vminor $vpatch

custom="custom-options.sh"
[ -f $custom ] && source "$custom" $version $vmajor $vminor $vpatch
custom="custom-options-$vmajor.sh"
[ -f $custom ] && source "$custom" $version $vmajor $vminor $vpatch
custom="custom-options-$vmajor.$vminor.sh"
[ -f $custom ] && source "$custom" $version $vmajor $vminor $vpatch
custom="custom-options-$vmajor.$vminor.$vpatch.sh"
[ -f $custom ] && source "$custom" $version $vmajor $vminor $vpatch