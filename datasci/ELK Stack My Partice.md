ELK Stack My Partice
===
1. install java

>su -c "yum install java-1.7.0-openjdk"
>java -version
note: logstash 2.2 only support java 1.7 and above.

2. install logstash by binary package

>mkdir logstash/ cd logstash
 >wget https://download.elastic.co/logstash/logstash/packages/centos/logstash-2.2.2-1.noarch.rpm

on 104
nginx configuration dir : /usr/local/nginx/conf
logs dir : /data/logs/
nginx bin:  /usr/local/nginx/sbin/nginx -t
/usr/local/nginx/sbin/nginx -s reload
3. install redis

>$ wget http://download.redis.io/releases/redis-3.0.7.tar.gz
>$ tar xzf redis-3.0.7.tar.gz
>$ cd redis-3.0.7
>$ make
>$ ./src/redis-server

4. install elasticsearch

>wget https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/2.2.0/elasticsearch-2.2.0.zip
>unzip elasticsearch-2.2.0.zip
>curl -X GET http://localhost:9200

5. install kibana

>tar zxvf   kibana-4.4.1-linux-x64.tar.gz
>sudo cp -r ./elk/kibana-4.4.1/ /home/wwwroot/default
>sudo vi kibana.yml

pay attention on your website firewall port
>curl -X GET http://0.0.0.0:8899
>http://123.59.81.78:8899/

6. intergate them together
* edit logstash conf  to collect ngnix logs
>cd ./logstash/bin
>touch shipper.conf
>vi shipper.conf
>touch indexer.conf
>vi indexer.conf


shipper.conf
```
input {
   file {
       type => "nginx-access"
       path => "/data/logs/2016/*/*.log"
   }
}
output {
    stdout {
        debug => true
        debug_format => json
    }


    redis {
        host => "127.0.0.1"
        port => 6379
        data_type => "list"
        key => "logstash"
    }
}
```

%{COMBINEDAPACHELOG} %{IP}

filter {
mutate { replace => { "type" => "apache_access" } }
grok {
    match => { "message" => "%{COMBINEDAPACHELOG}%{IP}" }
}
date {
    match => [ "timestamp" , "dd/MMM/YYYY:HH:mm:ss Z" ]
}
geoip {
    source => "clientip"
}
}

####nginx pattern
```
NGUSERNAME [a-zA-Z\.\@\-\+_%]+
NGUSER %{NGUSERNAME}
NGINXACCESS %{IPORHOST:clientip} - %{NOTSPACE:remote_user} \[%{HTTPDATE:timestamp}\] \"(?:%{WORD:verb} %{NOTSPACE:request}(?: HTTP/%{NUMBER:httpversion})?|%{DATA:rawrequest})\" %{NUMBER:response} (?:%{NUMBER:bytes}|-) %{QS:referrer} %{QS:agent} %{NOTSPACE:http_x_forwarded_for}
```
```
log_format json '{ "@timestamp": "$time_iso8601", '
                                          '"@fields": { '
                                          '"remote_addr": "$remote_addr", '
                                          '"remote_user": "$remote_user", '
                                          '"body_bytes_sent": "$body_bytes_sent", '
                                          '"request_time": "$request_time", '
                                          '"status": "$status", '
                                          '"request": "$request", '
                                          '"request_method": "$request_method", '
                                          '"http_referrer": "$http_referer", '
                                          '"http_user_agent": "$http_user_agent" } }';

```
```
log_format json '{"@timestamp":"$time_iso8601",'
                 '"host":"$server_addr",'
                 '"clientip":"$remote_addr",'
                 '"size":$body_bytes_sent,'
                 '"responsetime":$request_time,'
                 '"upstreamtime":"$upstream_response_time",'
                 '"upstreamhost":"$upstream_addr",'
                 '"http_host":"$host",'
                 '"url":"$uri",'
                 '"xff":"$http_x_forwarded_for",'
                 '"referer":"$http_referer",'
                 '"agent":"$http_user_agent",'
                 '"status":"$status"}';
```

```
log_format json '{"@timestamp":"$time_iso8601",'
                 '"host":"$server_addr",'
                 '"clientip":"$remote_addr",'
                 '"size":$body_bytes_sent,'
                 '"responsetime":$request_time,'
                 '"http_host":"$host",'
                 '"request":"$request",'
                 '"xff":"$http_x_forwarded_for",'
                 '"referer":"$http_referer",'
                 '"agent":"$http_user_agent",'
                 '"status":"$status"}';
```

Logstash 使用一个名叫 FileWatch 的 Ruby Gem 库来监听文件变化。这个库支持 glob 展开文件路径，而且会记录一个叫 .sincedb 的数据库文件来跟踪被监听的日志文件的当前读取位置。所以，不要担心 logstash 会漏过你的数据
