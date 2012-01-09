ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "data/sqlite/rod.sqlite3",
  pool: 1,
  timeout: 5000,
  encoding: "utf8"
)
#ActiveRecord::Base.establish_connection(
#  adapter: "postgresql",
#  database: "rod_benchmark_1",
#  pool: 1,
#  timeout: 5000,
#  login: "fox",
#  password: "",
#  host: "localhost",
#  encoding: "utf8",
#  port: 5431
#)
#require 'logger'
#ActiveRecord::Base.logger = Logger.new(STDOUT)
#r.to_a
