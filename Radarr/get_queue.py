from pyarr import RadarrAPI
import json
# If this script is on the same machine as Radarr, you can use the loopback address below.
# Actually, I've had no need to test this myself, but this whole setup should work over the Internet.
# In either case, you'll need to specify the port number that Radarr is using.
host_url = 'http://127.0.0.1:12345/'
# Get this API key from your Radarr's web UI.
api_key = 'blahblahblahapikey'

radarr = RadarrAPI(host_url, api_key)
print(json.dumps(radarr.get_queue(page_size=100)))
