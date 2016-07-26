#!/bin/bash

MAXSTART_U=`cut -d ':' -f 2 /etc/subuid | sort -rn | head -n1`
RANGE_U=`grep :$MAXSTART_U: /etc/subuid | cut -d ':' -f 3`
echo subuid_next=$((MAXSTART_U+RANGE_U))

MAXSTART_G=`cut -d ':' -f 2 /etc/subgid | sort -rn | head -n1`
RANGE_G=`grep :$MAXSTART_G: /etc/subgid | cut -d ':' -f 3`
echo subgid_next=$((MAXSTART_G+RANGE_G))

