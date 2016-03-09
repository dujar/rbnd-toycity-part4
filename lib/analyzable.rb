require 'pp'
require 'colorizr'
module Analyzable
  # Your code goes here!
String.create_colors

  def average_price product_brands
    (product_brands.map{|product| product.price.to_f}.inject{|sum, n| sum +n} / product_brands.length.to_f).round(2)
  end
  
  def print_report object
      print "#=> Average Price: $ #{average_price(object)} \n"
      "Inventory by Brand:\n" +
      "#{count_by_brand(object).map{ |k,v| "   -#{k}: #{v} \n"}.join}"+
      
      "Inventory by Name:\n"+
      "#{count_by_name(object).map{ |k,v| "   -#{k}: #{v} \n"}.join}"
  end

  def count_by_brand object
    brand_hash = Hash.new(0)
    object.map{|o| o.brand}.each{|k| brand_hash[k] += 1}
    brand_hash.each{|k,v| " #{k} => #{v}"}
  end

  def count_by_name object
    name_hash = Hash.new(0)
    object.map{|o| o.name}.each{|k| name_hash[k] += 1}
    name_hash.each{|k,v| "#{k} => #{v}"}
  end
end
