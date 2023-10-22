# frozen_string_literal: true

DOMAIN_REGEX = /\A([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}\Z/i

redirects = ENV.fetch('REDIRECTS', '').split(',')

conf_file = redirects.map do |raw_redirect_data|
  from, to = raw_redirect_data.split('>', 2).tap do |data|
    data.each do |domain|
      raise StandardError, "#{domain} is not a valid domain" unless domain.match?(DOMAIN_REGEX)
    end
  end
  raise StandardError, 'The two domains specified can not be the same' if from == to

  puts "Creating a redirect for #{from} -> #{to}"

  <<~NGINX_SERVER_BLOCK
    server {
      listen 8080;
      server_name #{from};
      access_log /var/log/nginx/access.log redirect_log;
      return 302 https://#{to}$request_uri;
    }
  NGINX_SERVER_BLOCK
end

File.write('redirects.conf', conf_file.join("\n"))
