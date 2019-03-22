# Zabbix-NatureRemo
ZabbixのLLDでNatureRemoを検出して、温湿度と照度を取得します。
userparameterで/usr/local/bin/remo-json.shを参照してるので、そのパスに置くか書き換えること。
remo-json.shはZabbix-agent実行ユーザーに実行権限を付けること。
