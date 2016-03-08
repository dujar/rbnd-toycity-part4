require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  def self.create opts = {}
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    object = new(id: opts[:id], brand: opts[:brand], name: opts[:name], price: opts[:price])
####whether object id is a match in data.csv
    matched = []
    CSV.foreach(@data_path) do |row|
        matched << (row[0] == object.id)
    end
######
    if matched.select{|e| e==false}
      record = [object.id, opts[:brand], opts[:name], opts[:price]]
      CSV.open(@data_path, "a") do |csv|
        csv << record 
      end
    end
      
    object
  end
end
