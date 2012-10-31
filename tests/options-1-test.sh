#!/usr/bin/env roundup
#
# This file contains the test plan for the options command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m digirest -p options
#

# Helpers
# ------------

rerun() {
    command $RERUN -M $RERUN_MODULES "$@"
}

# The Plan
# --------

describe "options"

it_runs_without_arguments() {
    rerun digirest:options
}
