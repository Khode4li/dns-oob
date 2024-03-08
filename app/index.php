<?php
require __DIR__.'/vendor/autoload.php';
$cache = new Cache\Cache();
if ($cache->get('q') === null) {
    $q = file_get_contents('php://stdin');
    if ($q === '')
        exit();
    $cache->set('q', $q, 10);
    \Config\registry::set('q', $q);
    require_once 'config/conf.php';
    $handler = new \Config\handler();
    $handler->notify();
}
?>
