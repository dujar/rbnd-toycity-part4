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

  def self.all
    array_of_products = []
    CSV.foreach(@data_path) do |row|
      if row[0] != "id"
        array_of_products << new(id: row[0].to_i, brand: row[1], name: row[2], price: row[3])
      end
    end
    return array_of_products
  end
  
  def self.first num = 1
    num == 1 ? all[0] : all[0..num-1].each{|product| product}
  end

  def self.last num = -1
    num == -1 ? all[-1] : all[(-num)..-1].each{|product| product}
  end

  def self.find number_id
    all[number_id-1]
  end

end
