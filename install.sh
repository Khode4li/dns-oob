echo "You want to be notified in discord or telegram, or both?"
read notif

if [ "$notif" = "discord" ]; then
	sed -i 's/telegram::class,//g' ./app/config/conf.php
	read -p "enter your webhook: " webhook
	sed -i "s#registry::set('DC_WEBHOOK_URL', '');#registry::set('DC_WEBHOOK_URL', '$webhook');#g" ./app/config/conf.php
elif [ "$notif" = "telegram" ]; then
        sed -i 's/discord::class,//g' ./app/config/conf.php
        read -p "enter your token: " token
	sed -i "s#registry::set('TG_TOKEN', '');#registry::set('TG_TOKEN', '$token');#g" ./app/config/conf.php
        read -p "enter your Chat ID: " chatid
	sed =i "s#registry::set('TG_CHAT_ID', '');#registry::set('TG_CHAT_ID', '$chatid');#g" ./app/config/conf.php
elif [ "$notif" = "both" ]; then
        read -p "enter your discord webhook: " webhook
	sed -i "s#registry::set('DC_WEBHOOK_URL', '');#registry::set('DC_WEBHOOK_URL', '$webhook');#g" ./app/config/conf.php
        read -p "enter your token: " token
        sed -i "s#registry::set('TG_TOKEN', '');#registry::set('TG_TOKEN', '$token');#g" ./app/config/conf.php
        read -p "enter your Chat ID: " chatid
        sed -i "s#registry::set('TG_CHAT_ID', '');#registry::set('TG_CHAT_ID', '$chatid');#g" ./app/config/conf.php
fi

read -p "enter the subdomain name that you want to use for DNS OOB(for example: `oob`.domain.com): " subd
sed -i "s/sub-d/$subd/g" Dockerfile
read -p "enter your domain name: " myd
mydes=$(echo $myd | sed 's/\./\\\./g')
sed -i "s/my-d-es/$mydes/g" Dockerfile
sed -i "s/my-dd/$myd/g" Dockerfile
read -p "enter your server ip: " ip
sed -i "s/ip-sv/$ip/g" Dockerfile

docker compose up -d
