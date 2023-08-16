# radarr-purge-stalled-downloads
A small set of scripts that allow you to automatically blocklist stalled downloads from Radarr. Can be adapted for other software in the *arr suite (like Sonarr).
This is designed for a Linux machine because I am automating a Linux machine. If you're running your setup on a Windows machine, too bad. (you'll have to rewrite the bash script to something Windowsy. Windowsish? Windchime.)

# I do not condone piracy,
but I am a colossal fan of automation.

## Wha?
I'm glad you asked. Radarr has a mechanism to monitor the state of your download client, and even to know when a download has stalled because of a lack of seeds. It has a mechanism to remove downloads from your download client at the push of a button. However, it has *no* mechaism which combines these two functionalities and purges/blocklists bad downloads automatically. This has been a problem for a while, and I have decided to fix it myself.

## How does it work?
Magic. And Bash. Some Python too. The idea is easy enough to implement in theory:
- Query Radarr to figure out what downloads are stalled
- Tell Radarr to blocklist those stalled downloads

<!-- -->

The only problem is that this *supposedly* two-step process requires web interaction and JSON parsing, and that's where my scripts come into play. It uses Python to query Radarr for stalled downloads, then pipes the JSON output to jq to get a list of bad download IDs (which are converted to a Bash-style array), then iterates through that list using Python to tell Radarr to blocklist those downloads.

## How do I use this?
To get started, you'll need the pyarr Python library available for your machine.
That's easy, just do `pip install pyarr` with Python installed. If you're on a shared machine, you'll want to use this within virtualenv. If you don't know what that is, it's probably not an issue for you.

Next, you'll need to place all three files somewhere on your machine, and set up the correct file references within the Bash script. Don't worry, I've left comments in all the places where you need to do that. You'll also need to update some variables in the Python scripts. I've made that easy enough as well.

You will then want to make a crontab entry that runs the Bash script every so often -- I have mine set to every 10 minutes. Bing bang boom, automation.

For n00bz (why yes, I did just transport you to 2005), you'll want to run `crontab -e` and then add this line into your crontab file: `*/10 * * * * /bin/bash /**YOUR SCRIPT DIRECTORY**/remove_script.sh >/dev/null 2>&1`

OH, before I forget. The Python scripts will contain your Radarr API key. Don't forget to set file permissions to make it so only you can read/write the file, and so that cron can execute it.

## Reference material in case you want to expand on this:
- crontab (for scheduling) [man page](https://www.man7.org/linux/man-pages/man5/crontab.5.html). It's pretty easy to use.
- jq (for parsing JSON) [documentation](https://jqlang.github.io/jq/). It probably came with your Linux disrtibution?????
- pyarr (Python library for interacting with *arr software) [documentation](https://pypi.org/project/pyarr/).

# Do not ask me to expand this to other *arr software. That would make me cry.
Feel free to make PRs if you get that working though. It helps other people who are having the same frustration I once did.

## Things you probably searched to get here (I am become SEO, the destroyer of frustration.)
How to automatically remove stalled downloads in Radarr or Sonarr

How to block stalled downloads in Radarr or Sonarr
