<?php
use Config\registry;
use Modules\telegram;
use Modules\discord;

#telegram bot setting
registry::set('TG_TOKEN', '');
registry::set('TG_CHAT_ID', '');

#discord setting
registry::set('DC_WEBHOOK_URL', '');

#handler modules
registry::set('modules',[
    discord::class,
    telegram::class,
]);
