#!/usr/bin/env bash

command=ansible

if [[ $# > 0 ]]; then
    case "$1" in
        ansible)
            shift
            ;;
        playbook | vault | doc | pull | console | config )
            command="ansible-$1"
            shift
            ;;
    esac
fi

if [[ $# > 0 ]]; then
    echo "$command $@"
else
    $command --help
fi
