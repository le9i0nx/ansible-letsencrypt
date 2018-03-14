#!/usr/bin/env bash

deploy_challenge() {
    local DOMAIN="${1}" TOKEN_FILENAME="${2}" TOKEN_VALUE="${3}"

{% if (item|d() and item.hook|d() and item.hook.deploy_challenge|d()) %}
{%  for i in item.hook.deploy_challenge %}
    {{i}}
{%  endfor%}
{% endif %}
}

clean_challenge() {
    local DOMAIN="${1}" TOKEN_FILENAME="${2}" TOKEN_VALUE="${3}"

{% if (item|d() and item.hook|d() and item.hook.clean_challenge|d()) %}
{%  for i in item.hook.clean_challenge %}
    {{i}}
{%  endfor%}
{% endif %}
}

deploy_cert() {
    echo "Hook for domain $1 triggerd, add to {{ letsencrypt__configdir }}/to_deploy folder!"
    echo "$@" > "{{ letsencrypt__configdir }}/to_deploy/$1"
}

HANDLER="$1"; shift
if [[ "${HANDLER}" =~ ^(deploy_cert|deploy_challenge|clean_challenge)$ ]]; then
  "$HANDLER" "$@"
fi
