$TTL 60

@   IN  SOA     ns1.my-domain. admin.my-domain. (
                2022021501   ; Serial
                3600         ; Refresh
                1800         ; Retry
                604800       ; Expire
                60 )         ; Negative Cache TTL

; Name Servers
@   IN  NS      ns1.my-domain.

; A Records
ns1.my-domain.     IN A ip-server
l.ns-sub.my-domain. IN A 127.0.0.1
