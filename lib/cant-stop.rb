require 'lotus/model'
Dir["#{ __dir__ }/cant-stop/**/*.rb"].each { |file| require_relative file }

Lotus::Model.configure do
  ##
  # Database adapter
  #
  # Available options:
  #
  #  * Memory adapter
  #    adapter type: :memory, uri: 'memory://localhost/cant-stop_development'
  #
  #  * SQL adapter
  #    adapter type: :sql, uri: 'sqlite://db/cant-stop_development.sqlite3'
  #    adapter type: :sql, uri: 'postgres://localhost/cant-stop_development'
  #    adapter type: :sql, uri: 'mysql://localhost/cant-stop_development'
  #
  adapter type: :sql, uri: ENV['CANT_STOP_DATABASE_URL']

  ##
  # Migrations
  #
  migrations 'db/migrations'
  schema     'db/schema.sql'

  ##
  # Database mapping
  #
  # Intended for specifying application wide mappings.
  #
  # You can specify mapping file to load with:
  #
  mapping "#{__dir__}/config/mapping"
end.load!
