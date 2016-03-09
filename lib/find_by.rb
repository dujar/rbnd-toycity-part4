class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    find_names = ["name","brand"]
    methods = %Q{
    find_names.each do |what| 
    def self.find_by_#{what} product_#{what}
      all.select{|product| product.#{what} == product_#{what}}.first
    end
    end
    }
    class_eval(methods)
  end

end
