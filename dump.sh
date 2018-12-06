#!/bin/bash

DB_USER=${DB_USER:-${MYSQL_ENV_DB_USER}}
DB_PASS=${DB_PASS:-${MYSQL_ENV_DB_PASS}}
DB_NAME=${DB_NAME:-${MYSQL_ENV_DB_NAME}}
DB_HOST=${DB_HOST:-${MYSQL_ENV_DB_HOST}}
DB_TABLES=${DB_TABLES:-${MYSQL_ENV_DB_TABLES}}


if [[ ${DB_USER} == "" ]]; then
	echo "Missing DB_USER env variable"
	exit 1
fi
if [[ ${DB_PASS} == "" ]]; then
	echo "Missing DB_PASS env variable"
	exit 1
fi
if [[ ${DB_HOST} == "" ]]; then
	echo "Missing DB_HOST env variable"
	exit 1
fi

if [[ ${DB_NAME} == "" ]]; then
  echo "Missing DB_NAME env variable"
  exit 1
fi


NOW=`date +%Y-%m-%d-%H-%M`
FILENAME=mysql-dump.$NOW.sql

if [[ ${DB_TABLES} == "" ]]; then
  mysqldump --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOST}" "$@" "${DB_NAME}" > /mysqldump/$FILENAME
else
mysqldump --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOST}" "$@" "${DB_NAME}" --tables "$@" ${DB_TABLES} > /mysqldump/$FILENAME
fi
cd /mysqldump/
tar zcf ${FILENAME}.tar.gz ${FILENAME}
rm  ${FILENAME}
echo "backup finished:${NOW}"
