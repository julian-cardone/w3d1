require 'byebug'

class Array

    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
    end

    def my_select(&prc)
        selected = []
        self.my_each do |r|
            selected << r if prc.call(r) 
        end
        selected
    end

end

a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

# return_value = [1, 2, 3].my_each do |num|
#     puts num
#    end
#    # => 1
#       # 2
#       # 3
#       # 1
#       # 2
#       # 3
# return_value


