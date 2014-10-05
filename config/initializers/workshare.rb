require "#{Rails.root}/lib/workshare/workshare"

Workshare::Client.config api_key:  Rails.application.secrets.workshare_api_key, 
                         api_host: 'https://api.workshare.com'