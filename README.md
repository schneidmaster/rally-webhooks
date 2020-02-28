Scripts to capture missing webhooks from changes in Rally.

* send.rb sends a request every 5 seconds to update the description of a Rally user story to a randomly generated string
* receive.rb is a lightweight Sinatra server that receives webhooks from Rally and logs them
* compare.rb compares the sends and receives to see what may be missing

## Setup

1. Clone the repository: `git clone https://github.com/schneidmaster/rally-webhooks.git`
2. Install dependencies: `bundle install`
3. Start the server: `ruby receive.rb`
4. Start up ngrok (to proxy webhooks from a publicly accessible URL to the local server): `ngrok http localhost:4567`
5. Use the Rally webhooks API to create a new webhook pointed at `https://b0e2ddbd.ngrok.io/receive` (replacing the subdomain hash with the randomly generated subdomain that ngrok gives you)
6. Create a user story in the project, copy its ID and paste in the URL at the top of `send.rb`
7. Create a Rally API key at https://rally1.rallydev.com/login and add it to the key variable at the top of `send.rb`
8. Run `ruby send.rb`

You should immediately see `send.rb` logging every 5 seconds that it is updating the Rally user story to a random nonce, and you should also quickly see the `receive.rb` terminal window logging inbound webhooks. The send script logs outbound webhooks to `sends.csv` and the receive script logs inbound webhooks to `receives.csv`. After you've let it run for a while, you can run `ruby compare.rb` which reports back on what webhooks are missing.
