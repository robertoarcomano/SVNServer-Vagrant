#!/bin/bash

# 1. Install base packages
apt-get install -y bats jq apache2 subversion libapache2-mod-svn libsvn-dev mc

# 2. Create dir & perms
mkdir -p /var/lib/svn/
svnadmin create /var/lib/svn/myrepo
# svn import /vagrant/ file:///var/lib/svn/myrepo -m "Initial commit"

chown -R www-data:www-data /var/lib/svn
chmod -R 775 /var/lib/svn

# 3. User & passwd
sudo touch /etc/apache2/dav_svn.passwd
sudo htpasswd -mb /etc/apache2/dav_svn.passwd admin password

# 4. Change config dav_svn
echo "
Alias /svn /var/lib/svn
<Location /svn>

   DAV svn
   SVNParentPath /var/lib/svn

   AuthType Basic
   AuthName \"Subversion Repository\"
   AuthUserFile /etc/apache2/dav_svn.passwd
   Require valid-user

</Location>
" >> /etc/apache2/mods-enabled/dav_svn.conf

# 5. Restart apache2
systemctl restart apache2
