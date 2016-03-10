require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  create_finder_methods('brand','name')
    @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create opts = {}

    object = new(id: opts[:id], brand: opts[:brand], name: opts[:name], price: opts[:price])
####whether object id is a match in @data.csv
    matched = self.all.select {|product| product.id == object.id}
######
    unless !matched
      record = [object.id, opts[:brand], opts[:name], opts[:price]]
      CSV.open(@@data_path, "a") do |csv|
        csv << record 
      end
    end
    return object
  end

  def self.all
    array_of_products = []
    all_array = CSV.read(@@data_path).drop(1)
    unless !all_array
    all_array.each do  |row|
       array_of_products << self.new(id: row[0], brand: row[1], name: row[2], price: row[3]) 
    end
    end
    array_of_products
  end
  
  def self.first num = 1
    self.all.first(num).size >1 ? self.all.first(num) : self.all.first(num).first
  end

  def self.last num = 1
    self.all.last(num).size >1 ? self.all.last(num) : self.all.last(num).first
  end

  def self.find number_id
    record = self.all.reject{|product| product.id != number_id}
    unless record 
    fail ToyCityErrors::ProductNotFoundError, "Product :#{number_id} does not exist" 
    end
    return record.first
  end

  def self.destroy id_destroy
    record = self.find(id_destroy)
    unless record 
    fail ToyCityErrors::ProductNotFoundError, "Product :#{id_destroy} does not exist" 
    end
#array of new data to register in database
    all_new = all.reject{|product| product.id == id_destroy}
    CSV.open(@@data_path, "wb") do |row|
      row << ["id", "brand", "product", "price"]
    end
    all_new.each do |product|
        CSV.open(@@data_path,"a") do |row|
          row << [product.id, product.brand, product.name, product.price]
        end
    end
    return record
  end

  #def self.find_by_brand brand_name
  #  all.select{|product| product.brand == brand_name}.first
  #end

  #def self.find_by_name product_name
  #  all.select{|product| product.name == product_name}.first
  #end

  def self.where opts = {}
    return all.select{|product| product.brand == opts[:brand]||product.name == opts[:name] }
    #if opts[:brand]
    #return all.select{|product| product.brand == opts[:brand] }
    #else
    #return all.select{|product| product.name ==opts[:name]}
    #end
  end

  def update opts = {}
    recorded = {id: id, brand: brand, name: name, price: price}
    opts.each_pair{|k,v| recorded[k] = v}#update de recorded hash
    into_array = recorded.to_a.map{|e| e[1].to_s}#will provide correct array of updated product
    csv = CSV.read(@@data_path)
    csv.select!{|a,b,c,d| a != id.to_s}
    csv.insert(id,into_array)
    CSV.open(@@data_path, "wb") do |row|
    csv.each do |product|
         row << product
      end 
    end
    return Product.new(recorded)
  end


end

