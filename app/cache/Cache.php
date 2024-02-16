<?php
namespace Cache;
use Predis\Client;

class Cache {
    private $redis;
    public function __construct() {
        $this->redis = new Client([
            'scheme' => 'tcp',
            'host'   => 'redis', // Replace with your Redis server host
            'port'   => 6379,        // Replace with your Redis server port
        ]);
    }
    public function get($key) {
        $data = $this->redis->get($key);
        if ($data !== null) {
            // Data found in the cache
            return unserialize($data);
        }
        // Data not found in the cache
        return null;
    }
    public function set($key, $data, $ttl = 3600) {
        // Serialize the data before storing it in the cache
        $data = serialize($data);
        $this->redis->setex($key, $ttl, $data);
    }
    public function delete($key) {
        $this->redis->del($key);
    }
}
?>