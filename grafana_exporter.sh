#!/bin/bash
# A simple Grafana Dashboard Exporter.

FROM=""
TO=""
DASHBOARD=""
EXPORT=""
AUTHORIZATION=""

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -f|--from)
      FROM="$2"
      shift
      shift
      ;;
    -t|--to)
      TO="$2"
      shift
      shift
      ;;
    -d|--dashboard)
      DASHBOARD="$2"
      shift
      shift
      ;;
    -e|--export)
      EXPORT="$2"
      shift
      shift
      ;;
    -a|--authorization)
      AUTHORIZATION="$2"
      shift
      shift
      ;;
  esac
done

# Convert to epoch
FROM=$(date -d "$FROM" +'%s%3N')
TO=$(date -d "$TO" +'%s%3N')

# Replace dates with the actual variables
url=$(echo $DASHBOARD | sed "s/FROM_DATE/$FROM/")
url=$(echo "$url"     | sed "s/TO_DATE/$TO/")

# do the http request to grafana
curl -o $EXPORT -H "Authorization: Bearer $AUTHORIZATION" $url 2>/tmp/grafana_export_stderr
if [ $? -gt 0 ]
then
    ERROR=$(</tmp/grafana_export_stderr)
    echo $ERROR
    exit 1
fi

# end
exit 0
