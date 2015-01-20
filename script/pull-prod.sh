curl -o latest.dump `heroku pgbackups:url` && \
pg_restore --verbose --clean --no-acl --no-owner \
  -h localhost \
  -U Chris \
  -d store_development \
  latest.dump && \
rm latest.dump
