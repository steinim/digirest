#!/usr/bin/env roundup
#
# This file contains the test plan for the open command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m digirest -p open
#

# Helpers
# ------------

rerun() {
    command $RERUN -M $RERUN_MODULES "$@"
}

# The Plan
# --------

describe "open"

it_runs_without_arguments() {
    rerun digirest:open
}
