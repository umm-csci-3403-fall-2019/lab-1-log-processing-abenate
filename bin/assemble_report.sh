#!/bin/env bash

# Combine contents of all HTML dist files into one
cat $1/country_dist.html $1/hours_dist.html $1/username_dist.html > $1/overAll.html    


# Wrap the combined file "overall.html" into the final html file (temp dir)
./bin/wrap_contents.sh $1/overAll.html ./html_components/summary_plots $1/failed_login_summary.html

# Wrap the combined file "overall.html" into the final html file (top level)
./bin/wrap_contents.sh $1/overAll.html ./html_components/summary_plots failed_login_summary.html

# We are outputting this file twice...because the test file for this script expects it to be 
# in the temp directory. However, process_logs expects it to be at the top level.
