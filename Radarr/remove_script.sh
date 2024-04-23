#! /bin/bash

# Uncomment and fix the line below if you're having to set this up in your own virtualenv environment.
# If you don't know what that is, then it doesn't apply to you.
# source /**YOUR VIRTUALENV DIRECTORY**/virtualenv/bin/activate

# You'll need to point this at the get_queue.py script that sits on your machine.

scriptDir="."
parsed=($(python ${scriptDir}/del_queue.py | jq -r '[.records[] | select(.errorMessage == "The download is stalled with no connections") | .id] | @sh'))
# If you're using a non-English localization of Radarr, change the text in the string here ^^^ to the error you get in the same situation.
# I know that's pretty bad but Radarr doesn't give proper error codes so that's how it has to be done.

for id in "${parsed[@]}"
do
        python ${scriptDir}/del_queue.py "$id"
done
