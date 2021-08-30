# nkn
# Скрипт для запуска ноды для майнинга токенов NKN:

apt -y update
apt -y upgrade
apt -y install unzip vnstat htop screen mc

username="nknrus"
benaddress="NKNUva1YwDAYx4HG53TxnPtX2NcQxRPFLoU9"
websource="https://nkn.org/ChainDB_pruned_latest.tar.gz"
keys="https://nknrus.ru/qrts/n5.tar"

useradd -m -p "pass" -s /bin/bash "$username" > /dev/null 2>&1
usermod -a -G sudo "$username" > /dev/null 2>&1

# Install minecraft server
printf "Downloading server........................................... "
cd /home/$username > /dev/null 2>&1
wget --quiet --continue --show-progress https://commercial.nkn.org/downloads/nkn-commercial/linux-amd64.zip > /dev/null 2>&1
printf "DONE!\n"

printf "Installing server............................................ "
unzip linux-amd64.zip > /dev/null 2>&1
mv linux-amd64 nkn-commercial > /dev/null 2>&1
chown -c $username:$username nkn-commercial/ > /dev/null 2>&1
/home/$username/nkn-commercial/nkn-commercial -b $benaddress -d /home/$username/nkn-commercial/ -u $username install > /dev/null 2>&1
printf "DONE!\n"
printf "sleep 180"

sleep 180

DIR="/home/$username/nkn-commercial/services/nkn-node/"

                        systemctl stop nkn-commercial.service > /dev/null 2>&1
			sleep 20
                        cd $DIR > /dev/null 2>&1
			rm wallet.json
			rm wallet.pswd
                        rm -rf ChainDB/ > /dev/null 2>&1
                        wget -O - "$keys" -q --show-progress | tar -xf -
  			wget -O - "$websource" -q --show-progress | tar -xzf -
                        chown -R $username:$username wallet.* > /dev/null 2>&1
                        chown -R $username:$username ChainDB/ > /dev/null 2>&1
                        printf "NKNRUS.RU - Скачивание файла................. Выполнено!\n"
                        systemctl start nkn-commercial.service > /dev/null 2>&1
