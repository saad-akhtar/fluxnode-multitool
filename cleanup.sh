#!/bin/bash
COIN_NAME='flux'
CONFIG_DIR='.flux'
BENCH_NAME='fluxbench'
BENCH_CLI='fluxbench-cli'
BENCH_DIR_LOG='.fluxbenchmark'
COIN_DAEMON='fluxd'
COIN_CLI='flux-cli'
USERNAME="$(whoami)"
#
echo "Quick & Dirty FluxNode Cleanup Start"
cd /home/$USERNAME/
sudo killall nano > /dev/null 2>&1
$COIN_CLI stop > /dev/null 2>&1 && sleep 2
sudo systemctl stop $COIN_NAME > /dev/null 2>&1 && sleep 2
sudo killall -s SIGKILL $COIN_DAEMON > /dev/null 2>&1 && sleep 2
$BENCH_CLI stop > /dev/null 2>&1 && sleep 2
sudo killall -s SIGKILL $BENCH_NAME > /dev/null 2>&1 && sleep 1
sudo fuser -k 16127/tcp > /dev/null 2>&1 && sleep 1
sudo fuser -k 16125/tcp > /dev/null 2>&1 && sleep 1
sudo rm -rf /usr/bin/flux* > /dev/null 2>&1 && sleep 1
sudo apt-get remove $COIN_NAME $BENCH_NAME -y > /dev/null 2>&1 && sleep 1
sudo apt-get purge $COIN_NAME $BENCH_NAME -y > /dev/null 2>&1 && sleep 1
sudo apt-get autoremove -y > /dev/null 2>&1 && sleep 1
sudo rm -rf /etc/apt/sources.list.d/zelcash.list > /dev/null 2>&1 && sleep 1
tmux kill-server > /dev/null 2>&1 && sleep 1
pm2 del zelflux > /dev/null 2>&1 && sleep 1
pm2 del flux > /dev/null 2>&1 && sleep 1
pm2 del watchdog > /dev/null 2>&1 && sleep 1
pm2 save > /dev/null 2>&1
pm2 unstartup > /dev/null 2>&1 && sleep 1
pm2 flush > /dev/null 2>&1 && sleep 1
pm2 save > /dev/null 2>&1 && sleep 1
pm2 kill > /dev/null 2>&1  && sleep 1
npm remove pm2 -g > /dev/null 2>&1 && sleep 1
sudo rm -rf watchgod > /dev/null 2>&1 && sleep 1
sudo rm -rf $BENCH_DIR_LOG && sleep 1
sudo rm -rf /etc/logrotate.d/mongolog > /dev/null 2>&1
sudo rm -rf /etc/logrotate.d/zeldebuglog > /dev/null 2>&1
rm update.sh > /dev/null 2>&1
rm restart_zelflux.sh > /dev/null 2>&1
rm zelnodeupdate.sh > /dev/null 2>&1
rm start.sh > /dev/null 2>&1
rm update-zelflux.sh > /dev/null 2>&1  
sudo systemctl stop zelcash > /dev/null 2>&1 && sleep 2
zelcash-cli stop > /dev/null 2>&1 && sleep 2
sudo killall -s SIGKILL zelcashd > /dev/null 2>&1
zelbench-cli stop > /dev/null 2>&1
sudo killall -s SIGKILL zelbenchd > /dev/null 2>&1
sudo rm /usr/local/bin/zel* > /dev/null 2>&1 && sleep 1
sudo apt-get purge zelcash zelbench -y > /dev/null 2>&1 && sleep 1
sudo apt-get autoremove -y > /dev/null 2>&1 && sleep 1
sudo rm /etc/apt/sources.list.d/zelcash.list > /dev/null 2>&1 && sleep 1
sudo rm -rf zelflux  > /dev/null 2>&1 && sleep 1
sudo rm -rf .zelbenchmark  > /dev/null 2>&1 && sleep 1
sudo rm -rf .fluxbenchmark  > /dev/null 2>&1 && sleep 1
sudo rm -rf $CONFIG_DIR  > /dev/null 2>&1 && sleep 1
sudo rm -rf /home/$USERNAME/stop_zelcash_service.sh > /dev/null 2>&1
sudo rm -rf /home/$USERNAME/start_zelcash_service.sh > /dev/null 2>&1
echo "Quick & Dirty FluxNode Cleanup End"
