#!/usr/bin/env bash

# AWFA by danito
# (c) 2022 - Danny Ismarianto Ruhiyat

# Astra DB's Build-A-Thon by DataStax and AngelHack

timestamp=$(date '+%Y-%m-%d %H:%M:%S %Z')
epoch=$(date -d "$timestamp" +"%s")

# echo timestamp=\"$timestamp\"
# echo epoch=\"$epoch\"

strRandom8=$(tr -dc a-f0-9 < /dev/urandom | head -c 8)
strRandom4a=$(tr -dc a-f0-9 < /dev/urandom | head -c 4)
strRandom4b=$(tr -dc a-f0-9 < /dev/urandom | head -c 4)
strRandom4c=$(tr -dc a-f0-9 < /dev/urandom | head -c 4)
strRandom12=$(tr -dc a-f0-9 < /dev/urandom | head -c 12)

uuid=$(echo $strRandom8-$strRandom4a-$strRandom4b-$strRandom4c-$strRandom12)

# echo uuid = \"$uuid\"

export ASTRA_DB_ID=4773245c-e04f-45cd-906c-9048b088007b
export ASTRA_DB_REGION=asia-south1
export ASTRA_DB_KEYSPACE=awfa
export ASTRA_DB_APPLICATION_TOKEN=AstraCS:xZjNWjrTuYyMbPJdDOedTQBv:ed0920374ed6c07d57b5412cc8bdf2d7a86ddcc6608a969c35fa7d042d6a9161

sleep 1

user_email="user@test.com"
user_phone="+621234567890"
user_fullname="Danny Ismarianto Ruhiyat"
user_nickname="danito"
user_gender="Male"
user_password="P455W012D"
user_device_id="AWFA-001"
user_device_status=1
user_attache_locale="en_US"
user_attache_gender="Female"
user_attache_status=1
user_created="${timestamp}"

timestamp=$(date '+%Y-%m-%d %H:%M:%S %Z')

user_last_edited="${timestamp}"
user_notes="-"
user_status=1
user_id=$(echo $uuid)

echo " "
echo user_email = \"$user_email\"
echo user_phone = \"$user_phone\"
echo user_fullname = \"$user_fullname\"
echo user_nickname = \"$user_nickname\"
echo user_gender = \"$user_gender\"
echo user_password = \"$user_password\"
echo user_device_id = \"$user_device_id\"
echo user_device_status = \"$user_device_status\"
echo user_attache_locale = \"$user_attache_locale\"
echo user_attache_gender = \"$user_attache_gender\"
echo user_attache_status = \"$user_attache_status\"
echo user_created = \"$user_created\"
echo user_last_edited = \"$user_last_edited\"
echo user_notes = \"$user_notes\"
echo user_status = \"$user_status\"
echo user_id = \"$uuid\"
echo " "

export ASTRA_DB_TABLE=users

curl --request POST \
     --url https://${ASTRA_DB_ID}-${ASTRA_DB_REGION}.apps.astra.datastax.com/api/rest/v2/keyspaces/${ASTRA_DB_KEYSPACE}/${ASTRA_DB_TABLE} \
     --header 'content-type: application/json' \
     --header "x-cassandra-token: ${ASTRA_DB_APPLICATION_TOKEN}" \
     --data "{\"email\":\"$user_email\", \"phone\":\"$user_phone\", \"fullname\":\"$user_fullname\", \"nickname\":\"$user_nickname\", \"gender\":\"$user_gender\", \"password\":\"$user_password\", \"device_id\":\"$user_device_id\", \"device_status\":$user_device_status, \"attache_locale\":\"$user_attache_locale\", \"attache_gender\":\"$user_attache_gender\", \"attache_status\":$user_attache_status, \"created\":\"$user_created\", \"last_edited\":\"$user_last_edited\", \"notes\":\"$user_notes\", \"status\":$user_status, \"user_id\":\"$user_id\"}"

