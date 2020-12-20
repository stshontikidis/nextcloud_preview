# Nextcloud w/ Preview Generator CRON

This is building off Nextcloud stable base image and add cron service along with the
cron job for the www-data user to pre-generate previews every 10 minutes. This image
does not add the actual preview generator app you must install that via the marketplace
or manually via GIT at this time. You also might want to adjust default config of sizes for preview
and file types.