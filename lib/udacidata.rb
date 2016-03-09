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

  def self.destroy id_destroy
    all_new = all
    deleted_product = all.delete_at(id_destroy-1)
    CSV.open(@data_path, "wb") do |row|
      row << ["id", "brand", "product", "price"]
    end
    all_new.each do |product|
      if product.id != id_destroy-1
        CSV.open(@data_path,"a") do |row|
          row << [product.id, product.brand, product.name, product.price]    
        end
      end
    end
    deleted_product
  end

  def self.find_by_brand brand_name
    all.select{|product| product.brand == brand_name}.first
  end

  def self.find_by_name product_name
    all.select{|product| product.name == product_name}.first
  end

  def self.where opts = {}
    all.select{|product| product.brand == opts[:brand]}
  end

  def update opts = {}
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    puts @data_path
    recorded = {id: id, brand: brand, name: name, price: price}
    opts.each_pair{|k,v| recorded[k] = v}#update de recorded hash
    into_array = recorded.to_a.map{|e| e[1].to_s}#will provide correct array of updated product
    puts into_array.inspect
    csv = CSV.read(@data_path)
    puts csv.inspect
    csv.select!{|a,b,c,d| a != id.to_s}
    puts csv.inspect
    csv.insert(id,into_array)
    puts csv.inspect
    CSV.open(@data_path, "wb") do |row|
    csv.each do |product|
         row << product
      end 
    end
    return Product.new(recorded)
  end


end
