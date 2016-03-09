class String 


  def self.create_colors
    Object.create_more_colors
    colors_hash.select do |key,value|
        class_methods = %Q{
           def #{key}
                \"\e[#{value}m\#\{self\}\e[0m\"
           end
        }
      class_eval(class_methods)
    end
  end

  def self.sample_colors
    colors_hash.keys.each do |k|
      print "this is "
       send(k,k)
    end
  end
end

class Object

def colors_hash
  colors1 = {
    :red => 31,
    :green => 32,
    :yellow => 33,
    :blue => 34,
    :pink => 35,
    :light_blue => 94,
    :white => 97,
    :light_grey => 37,
    :black => 30}

 return colors1
end

def colors
  return colors_hash.keys
end

  def create_more_colors
    colors_hash.select do |key,value|
        instance_methods = %Q{
           def #{key}(string)
               \"\e[#{value}m\#\{string\}\e[0m\"
           end
        }
      class_eval(instance_methods)
    end
  end
end

