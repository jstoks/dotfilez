#!/usr/bin/env ruby


class PGrab

  attr_reader :host, :user, :database, :schema_path

  def initialize(host:,user:,database:,schema_path: '')
    @host = host
    @user = user
    @database = database
    @schema_path = schema_path
  end

  def sample(query,limit=10)
   query = "#{clean(query)} limit #{limit}"
   query(query)
  end

  def report(query)
    query = clean(query)
    query(%Q|copy (#{query}) to stdout with csv header|)
  end

  def query(query)
    %x[ #{psql} "set default_transaction_read_only=on;#{query.gsub('"','\"')};" ]
  end

  private

  def clean(query)
    query.strip.sub(/;$/,'')
  end

  def psql
    "psql -h #{host} -U #{user} -d #{database} -c "
  end

end

if __FILE__ == $0
  require 'slop'

  opts = Slop.parse do |o|
    o.string '-h', '--host', 'host to connect to', default: ENV['PGRAB_HOST']
    o.string '-d', '--database', 'database to connect to', default: ENV['PGRAB_DATABASE']
    o.string '-u', '--user', 'user that will connect to the database', default: ENV['PGRAB_USER']
  end
end
