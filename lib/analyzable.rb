require 'pp'
require 'colorizr'
module Analyzable
  # Your code goes here!
String.create_colors

  def average_price product_brands
    (product_brands.map{|product| product.price.to_f}.inject{|sum, n| sum +n} / product_brands.length.to_f).round(2)
  end
  
  def print_report object
      report = "#=> Average Price: $ #{average_price(object)} \n"
      report <<  "Inventory by #{"Brand".red}:\n"
      count_by_brand(object).each_pair do |k,v|
        report << "   -#{k.red}: #{v.to_s.blue} \n"
      end
      puts report.class
      report <<  "Inventory by #{"Name".red}:\n"
      count_by_name(object).each_pair do |k,v|
        report << "   -#{k.red}: #{v.to_s.blue} \n"
         
      end
      report
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
