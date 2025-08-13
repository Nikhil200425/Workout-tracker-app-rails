require "pagy"
# config/initializers/pagy.rb
require "pagy/extras/bootstrap" # or other frontend helper

Pagy::DEFAULT[:items] = 2 # default items per page if not overridden
