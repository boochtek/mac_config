# Software required for use at Mercy.


source 'homebrew.sh'
source 'java.sh'
source 'ruby.sh'


# Create a location for our work.
mkdir -p $HOME/Work/Mercy
cd $HOME/Work/Mercy


# We'll be using Node as our primary server.
brew install node

# We use Selenium stand-alone.


# Install some instructional packages.
#npm install -g learnyounode

# We use slack for team communication.
#brew cask install slack
# Manual: Run Slack, enter team name: mymercy.

# We've replaced Slack with Cisco Spark.
#
brew cask install cisco-spark


brew install tmux
brew tap nviennot/tmate
brew install tmate
#brew cask install skype

brew install subversion
sudo cpan SVN::Core # This is required to make git-svn work.


brew install libxslt
brew install libxml2
brew install wireshark --with-qt

brew cask install virtualbox


# We use Tomcat (and might be able to use Jetty) for Java (and JRuby) apps.
brew install tomcat


# Manual: Fix OWA issue with Chrome.
# Configure Stylish extension for webmail.mercy.net:
#    .dlgMask { z-index: -100 !important; }
# This will allow you to click the "Dismiss" button on OWA popups.


# Manual: Juniper VPN.
# Download and open http://library.wheatoncollege.edu/technology/junipermac.dmg
# Preferences / Security & Privacy / Allow apps downloaded from: Anywhere
# Run /Volumes/NetworkConnect/NetworkConnect.pkg
# To start the VPN, run "Network Connect", Sign in at: remote.mercy.net, choose the "Mercy Corporate" role (at the bottom).
# You'll likely have to download and install (automatically) a newer version of the Network Connect client.


# Install Node Version Manager, and the version of Node we need.
curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | bash
. ~/.bashrc
nvm install v0.10.32
nvm use v0.10.32


# The following needs to be run while connected to the Mercy internal network.
# Above this needs to be run while connected to the Internet.
#export http_proxy=http://10.0.0.250:80
#export https_proxy=http://10.0.0.250:80


# Install older of version of JRuby that we'll need.
ruby-install -u https://s3.amazonaws.com/jruby.org/downloads/1.5.6/jruby-bin-1.5.6.tar.gz jruby 1.5.6
source /usr/local/share/chruby/chruby.sh

# Install last version of Ruby 1.8.7, to see if we can use it.
ruby-install -u ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p374.tar.bz2 ruby 1.8.7-p374 -- --without-tcl --without-tk
source /usr/local/share/chruby/chruby.sh


ruby-install -u ftp://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.bz2 ruby 2.1.5 -- --without-tcl --without-tk
ruby-install -u https://s3.amazonaws.com/jruby.org/downloads/1.7.16.2/jruby-bin-1.7.16.2.tar.gz jruby 1.7.16.2




git clone git@mercygit.smrcy.com:mymercy/mymercyclient.git
( cd mymercyclient && npm install && npm install bower grunt grunt-cli && bower install )

git clone git@mercygit.smrcy.com:onemercygateway/omg_node.git
( cd omg_node && npm run setup )

git clone git@mercygit.smrcy.com:onemercygateway/onemercygateway.git
# TODO: Oracle JDBC driver JAR in Tomcat lib. Maybe JTDS JAR.
# wget http://mirrors.ibiblio.org/pub/mirrors/maven/mule/dependencies/maven1/oracle-jdbc/jars/ojdbc14.jar
# TODO: Set up Maven with local repo.

git clone git@mercygit.smrcy.com:mymercy/mymercyserver.git



unset http_proxy
unset https_proxy


# We're getting these 3 from SVN now.
# git clone git@mercygit.smrcy.com:mymercy/webpresence.git
# git clone git@mercygit.smrcy.com:mymercy/mychartdt.git
# git clone git@mercygit.smrcy.com:mymercy/omg.git

git clone git@mercygit.smrcy.com:mymercy/webpresenceadmin.git
git clone git@mercygit.smrcy.com:mymercy/claritylitegateway.git

# Manual: Add an entry for localhost that ends in smrcy.com:
# 127.0.0.1 localhost localhost.smrcy.com

# NOTE: These could take over an hour each, to download all the branches.
git svn clone -s --prefix=origin/ http://mercysvn.smrcy.com/svn/ruby/webpresence wp
git svn clone -s --prefix=origin/ http://mercysvn.smrcy.com/svn/ruby/WebPresenceAdmin wpa
git svn clone -s --prefix=origin/ http://mercysvn.smrcy.com/svn/ruby/MyChartDT dt
git svn clone -s --prefix=origin/ http://lnxvmcvsp01.smrcy.com/svn/ruby/OneMercyGateway omg
git svn clone -s --prefix=origin/ http://mercysvn.smrcy.com/svn/java/MyMercyBatch mmb
git svn clone -s --prefix=origin/ http://mercysvn.smrcy.com/svn/ruby/webpresenceaudit audit


cd wp
chruby jruby-1.5
rake gems:refresh_specs
rake db:migrate
rake db:test:prepare
#rake test:units # Passed - 70 minutes; requires access to DB.
ruby script/server -p 3001 -e development_chi
RAILS_ENV=development_tomcat_osu rake war
cd -

cd dt
chruby jruby-1.5
rake gems:refresh_specs
# This project doesn't use AR.
#rake db:migrate
#rake db:test:prepare
rake test:units
ruby script/server -p 3000 -e development_chi
RAILS_ENV=development_tomcat_osu rake war
cd -

cd omg
chruby jruby-1.7
bundle
bundle exec rake db:migrate
RAILS_ENV=development_tomcat_osu bundle exec warble
bundle exec rails server -p 3002
cd -

cd wpa
chruby jruby-1.5
RAILS_ENV=development_osu ruby script/server -p 3003
RAILS_ENV=development_tomcat_osu rake war
cd -

# Now you can access http://localhost.smrcy.com:3001 to log in.



cd mmb



### Spring

brew install maven
mvn -emp # NOTE: Interactive.
mvn -ep # NOTE: Interactive
# Copy these into ~/.m2/settings-security.xml and ~/.m2/settings.xml, respectively. Note that the 2nd file needs 2 entries.

# Add some fonts (not really Mercy)
brew cask install font-source-code-pro

# We're using Roo to get a Spring project up and running quicker.
brew install spring-roo

# We use Sprint Tool Suite, an Eclipse-based IDE.
brew cask install sts
# NOTE: The next steps are interactive via a GUI.
# Launch Spring Tool Suite.
# Set an Eclipse Workspace (I use "$HOME/Work/Projects/Mercy".)
STS_VERSION=$(ls -1tr /opt/homebrew-cask/Caskroom/sts | tail -1)
echo "STS Version: $STS_VERSION"
open "/opt/homebrew-cask/Caskroom/sts/${STS_VERSION}/sts-bundle/sts-${STS_VERSION}.RELEASE/STS.app"
# Configure STS (Eclipse):
#   Install packages:
#       Infinitest (http://infinitest.github.io)
#   General / Editors / Text Editors
#       Displayed tab width: 4
#       CHECK Insert spaces for tabs
#       CHECK Show print margin
#       Print margin column: 100
#       CHECK Show line numbers
#   General / Keys
#       Content Assist - Tab
#   General / Appearance / Colors and Fonts
#       Basic / Text Font: Courier New, 14 pt
#   Java / Compiler / 1.6
#   Java / Code Style / Formatter (Edit a new profile)
#       Indentation / Tab policy: Spaces only
#   Web / Editor
#       Line width: 100
#       CHECK Indent using spaces
#       Indentation size: 2
#   XML / XML Files / Editor
#       Line width: 100
#       CHECK Indent using spaces
#       Indentation size: 2


# We have to use Jabber and IRC for team communication.
brew cask install adium
