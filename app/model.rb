require 'pg'
require 'singleton'

class PostgresConnector
	include Singleton

	def initialize() 
	    db_parts = ENV['DATABASE_URL'].split(/\/|:|@/)
	    username = db_parts[3]
	    password = db_parts[4]
	    host = db_parts[5]
	    db = db_parts[7]
	    @conn = PGconn.open(:host =>  host, :dbname => db, :user=> username, :password=> password)
		@conn.prepare("insert_query", "insert into query (query_text) values ($1)")

	end

	def createTables
		@conn.exec("DROP TABLE IF EXISTS query CASCADE;
		CREATE TABLE query (
			id_query serial PRIMARY KEY,
			query_text text NOT NULL,
			date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
		);
		");
	end

	def addQuery(query)
    	@conn.exec_prepared("insert_query", [query])
	end

	def disconnect
    	@conn.close
  	end
end

def createModel
	p = PostgresConnector.instance
	p.createTables
end

def addQuery(query)
	p = PostgresConnector.instance
	p.addQuery(query)
end