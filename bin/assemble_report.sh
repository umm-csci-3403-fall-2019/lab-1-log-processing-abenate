#!/bin/env bash

cat $1/country_dist.html $1/hours_dist.html $1/username_dist.html > $1/overAll.html    


./bin/wrap_contents.sh $1/overAll.html   ./html_components/summary_plots $1/failed_login_summary.html
