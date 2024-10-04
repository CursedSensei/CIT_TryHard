export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

wget -O dpp.deb https://dl.dpp.dev/
dpkg -i dpp.deb
rm dpp.deb