# Explicitly require and initialize Propshaft
require 'propshaft'

# Configure Propshaft if needed
Rails.application.config.assets.paths ||= []
Rails.application.config.assets.paths << Rails.root.join('app/assets/builds')
Rails.application.config.assets.paths << Rails.root.join('app/assets/images')

