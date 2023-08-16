#! /bin/bash

# Uncomment and fix the line below if you're having to set this up in your own virtualenv environment.
# source /**YOUR VIRTUALENV DIRECTORY**/virtualenv/bin/activate

# You'll just need to point this at the get_queue.py script that sits on your machine.
parsed=($(python /**YOUR SCRIPT DIRECTORY**/get_queue.py \
| jq -r '[.records[] | select(.errorMessage == "The download is stalled with no connections") | .id] | @sh'))
# If you're on a non-English localization of Radarr, change the text above to select the correct error.
# Yeah, it's pretty janky, but without more canonical error codes given by Radarr this is just how it is.

for id in "${parsed[@]}"
do
        # Update this as well to the correct directory.
        python /**YOUR SCRIPT DIRECTORY**/del_queue.py "$id"
done
