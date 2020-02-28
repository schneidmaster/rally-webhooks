require 'rest-client'
require 'securerandom'
require 'json'

# Rally API key from https://rally1.rallydev.com/login
key = '<key goes here>'

# URL of your test user story in Rally
# example: 'https://rally1.rallydev.com/slm/webservice/v2.0/hierarchicalrequirement/372999751372'
url = 'https://rally1.rallydev.com/slm/webservice/v2.0/hierarchicalrequirement/<user story numerical id goes here>'

while true do
  random = SecureRandom.hex(16)
  payload = {
    HierarchicalRequirement: {
      Description: "<p>#{random}</p>"
    }
  }
  begin
    RestClient.post(url, payload.to_json, { content_type: :json, zsessionid: key })
    puts "Set body to #{random}"

    open('sends.csv', 'a') do |f|
      f << [Time.now.utc, random].join(",") + "\n"
    end
  rescue StandardError => e
    # ignore any random Rally API failures -- it occasionally
    # returns a 302 or 502 for no particular reason
    puts "Ignoring Rally API error: #{e.message}"
  end

  sleep 5
end
