sends = File.readlines('sends.csv')
receives = File.read('receives.csv')

sends.unshift # get rid of header
total = sends.count

missing = sends.reject { |send| receives.include?(send.split(',').last) }
puts "Missing #{missing.count} of #{total}"
puts missing
