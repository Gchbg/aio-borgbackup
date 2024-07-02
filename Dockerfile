FROM nextcloud/aio-borgbackup:20240701_074701-latest
RUN awk -v line='    BORG_OPTS+=(--exclude-if-present=.noaiobackup --keep-exclude-tags)' -v after='BORG_OPTS=' 'BEGIN { see = 0; nr = 0 } { if ($0 == line) { see = 1; exit } lines[++nr] = $0; if ($0 ~ after) { lines[++nr] = line }} END { if (!see) { for (i = 1; i <= nr; i++) { print lines[i] > FILENAME }}}' /backupscript.sh
