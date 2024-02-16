<?php

namespace Modules;

use Config\registry;

class discord
{
    use getInstanceTrait;
    private string $WEBHOOK_URL;

    protected function __construct()
    {
        $this->WEBHOOK_URL = registry::get('DC_WEBHOOK_URL');
    }

    public function notify(): void
    {
        $params = [
            "embeds" => [
                [
                    "title" => "🔰 New DNS Query: " . date("Y-m-d H:i"),
                    "color" => "16062488",
                    "fields" => [
                        [
                            "name" => "Query",
                            "value" => "`" . registry::get('q') . "`",
                        ]
                    ]
                ]
            ]
        ];

        $this->sendMessage($params);
    }

    public function sendMessage(array $params)
    {
        $params = json_encode($params);

        $url = $this->WEBHOOK_URL;

        $headers = [
            'Content-Type: application/json',
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_exec($ch);
        curl_close($ch);
    }
}