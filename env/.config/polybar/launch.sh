#!/bin/bash

killall -q polybar

polybar main &
polybar secondary &
