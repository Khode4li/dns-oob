<?php

namespace Modules;

use Config\registry;

class telegram
{
    use getInstanceTrait;
    private string $TOKEN;
    private string $CHAT_ID;
    protected function __construct()
    {
        $this->TOKEN = registry::get('TG_TOKEN');
        $this->CHAT_ID = registry::get('TG_CHAT_ID');
    }

    public function notify(): void
    {

        $q = registry::get('q');
        $message = "〽️ New DNS Query:
`".$q."`";

        $this->sendMessage([
            'chat_id' => $this->CHAT_ID,
            'text' => $message,
            'parse_mode' => 'markdownv2'
        ]);
    }
    private function sendMessage($params)
    {
        $url = "https://api.telegram.org/bot" . $this->TOKEN . "/sendMessage";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_exec($ch);
        curl_close($ch);
    }
}