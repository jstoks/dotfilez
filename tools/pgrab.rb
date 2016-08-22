#!/usr/bin/env ruby

class PGrab

  def initialize(host:,user:,database:,search_path: '')
    @host = host
    @user = user
    @database = database
    @search_path = search_path
  end

  def sample(query,limit = 10)
    command("#{clean(query)} limit #{limit}")
  end

  def csv(query)
    query = "copy (#{clean(query)}) to stdout with csv header"
    _command(query)
  end

  def command(query)
    _command(clean(query))
  end

  private

  def _command(query)
    %Q|#{psql} "set default_transaction_read_only=on;set search_path to #{search_paht};#{query};"|
  end

  def clean(query)
    query.strip.gsub(/;$/,'').gsub('"','\"')
  end

  def psql
    "psql -h #{host} -U #{user} -d #{database} -c "
  end

  attr_reader :host,:user,:database,:search_path
end

if __FILE__ == $PROGRAM_NAME
  require 'slop'

  
end
