# Grafana-png-exporter
Export easily your Grafana dashboards to png images

# To use this script you will need first an Authorization bearer
https://grafana.com/docs/grafana/latest/http_api/auth/

# Parameters explaination
```
-e: export filename
-f: from date
-t: to date
-a: authorization bearer
-d: dashboard url
```

# Example: Export a dashboard

A grafana dashboard url has a from= and a to= parameter, copy the url and replace whatever values might have those two parameters with FROM_DATE and TO_DATE
```
"http://grafana_server:3000/render/d-solo/uzieuOY7z/my-statistics?orgId=1&from=FROM_DATE&to=TO_DATE&panelId=5&width=1000&height=500&tz=Europe%2FAthens&theme=light"
```
Then assuming that you want to get an export of this dashboard for dates 2022-05-01 08:00:00 to 2022-05-01 11:00:00 enter
```
grafana_exporter.sh -e out.png -f "2022-05-01 08:00:00" -t "2022-05-01 11:10:00" -a eyJrIjoiOE1oc0hpb3V0SHM1cDlYTmJmWTJwSDRHZGiiS254eG0iLCJuIjoia3BhdHJvbmFzIiwiaWQiOjF9 -d "http://grafana_server:3000/render/d-solo/uzieuOY7z/my-statistics?orgId=1&from=FROM_DATE&to=TO_DATE&panelId=5&width=1000&height=500&tz=Europe%2FAthens&theme=light"
```

if everything gone well a png export of the dashboard will be created in out.png

# Example: Export a dashboard with some tricks ;)

Assume that you want an export of your dashboad everyday with a specific timeframe

```
grafana_exporter.sh -e out.png -f "`date +"%Y-%m-%d 08:00:00"`" -t "`date +"%Y-%m-%d 11:00:00"`" -a eyJrIjoiOE1oc0hpb3V0SHM1cDlYTmJmWTJwSDRHZGiiS254eG0iLCJuIjoia3BhdHJvbmFzIiwiaWQiOjF9 -d "http://grafana_server:3000/render/d-solo/uzieuOY7z/my-statistics?orgId=1&from=FROM_DATE&to=TO_DATE&panelId=5&width=1000&height=500&tz=Europe%2FAthens&theme=light"
```

Executing this on each day will give us graphs only for the current day between 08:00 and 11:00
