#! /bin/bash

usermod www-data -s /bin/bash

/etc/init.d/mongodb stop
sleep 1
sed -i 's/dbpath=.*/dbpath=\/data/' /etc/mongodb.conf
chown -R mongodb: /data
/etc/init.d/mongodb start

sleep 1

if [ ! -f /var/www/html/.flag ]; then
 

    mongo xhprof --eval "db.results.ensureIndex( { 'meta.SERVER.REQUEST_TIME' : -1 } )"
    mongo xhprof --eval "db.results.ensureIndex( { 'profile.main().wt' : -1 } )"
    mongo xhprof --eval "db.results.ensureIndex( { 'profile.main().mu' : -1 } )"
    mongo xhprof --eval "db.results.ensureIndex( { 'profile.main().cpu' : -1 } )"
    mongo xhprof --eval "db.results.ensureIndex( { 'meta.url' : 1 } )"
    mongo xhprof --eval "db.results.ensureIndex( { 'meta.simple_url' : 1 } )"



    rm -rf /var/www/html
    git clone https://github.com/perftools/xhgui.git /var/www/html
    chown -R www-data: /var/www
    su -c 'cd /var/www/html && php install.php' - www-data
    
    touch /var/www/html/.flag
fi 

a2enmod rewrite
/etc/init.d/apache2 start


/bin/bash
