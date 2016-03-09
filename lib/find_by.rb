class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |what| 
    methods = %Q{
    def self.find_by_#{what} product_#{what}
      all.select{|product| product.#{what} == product_#{what}}.first
    end
    }
    class_eval(methods)
    end
  end

end
