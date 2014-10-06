configuration = YAML.load_file("#{Rails.root}/config/retrieved_file_configuration.yml")

WorkshareFileRetrieval::File.config configuration