Rails.application.config.generators do |g|
  g.osm :active_record, primary_key_type: :uuid
end
