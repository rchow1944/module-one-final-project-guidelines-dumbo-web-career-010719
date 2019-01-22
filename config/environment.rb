require 'bundler/setup'
Bundler.require

# <<<<<<< HEAD
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'lib'
require_all 'app'
# =======
# require 'rake'
# require 'active_record'
# require 'yaml/store'
# require 'ostruct'
# require 'date'
#
# DBNAME = "champions"
#
# Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
# Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}
#
# DBRegistry[ENV["ACTIVE_RECORD_ENV"]].connect!
# DB = ActiveRecord::Base.connection
#
# if ENV["ACTIVE_RECORD_ENV"] == "test"
#   ActiveRecord::Migration.verbose = false
# end
# >>>>>>> effab1b74d3856a18c67e31976cabb25a606bc1b
