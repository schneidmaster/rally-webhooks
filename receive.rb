require 'sinatra'
require 'json'

get '/heartbeat' do
  status 200
  'Server is running'
end

post '/receive' do
  body = JSON.parse(request.body.string)
  description = body["message"]["changes"]["b5bae981-bfe6-4980-844a-b5ecf3e9a156"]
  if description
    value = description["value"].gsub("<p>", "").gsub("</p>", "").gsub("\n", "")
    puts "Received #{value}"
    unless File.read('receives.csv').include?(value)
      open('receives.csv', 'a') do |f|
        f << [Time.now.utc, value].join(",") + "\n"
      end
    end
  end
  status 200
end
