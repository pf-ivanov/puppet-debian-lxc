# WIP

### Quick and dirty puppet manifect to run lxc on debian (jessie)

Based on https://myles.sh/configuring-lxc-unprivileged-containers-in-debian-jessie/

Just translating words into puppet manifest

##### Installation draft

```
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb
sudo dpkg -i puppetlabs-release-pc1-jessie.deb
apt-get update
apt-get install puppet-agent
git clone https://github.com/pf-ivanov/puppet-debian-lxc lxc
cd lxc
git submodule init
git submodule update
./runme.sh --noop
# ./runme.sh
# reboot
# ./runme.sh
```
