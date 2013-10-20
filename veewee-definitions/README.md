git clone https://github.com/jedi4ever/veewee
cd veewee
export GREP_OPTIONS=
bundle install
ln -s ../definitions . 

bundle exec veewee vbox build CentOS-6.4-x86_64-ja --workdir=../veewee


