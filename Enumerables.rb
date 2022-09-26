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


    def my_reject(&prc)
        rejected = []
        self.my_each do |r|
            rejected << r if !prc.call(r)
        end
        rejected
    end

    def my_any?(&prc)
        self.my_each do |k|
            return true if prc.call(k)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |k|
            return false if !prc.call(k)
        end

        true
    end

    def my_flatten

        return flatten if !(flatten.my_any? {|i| i.is_a? Array})

        #return [self] if !self.is_a? Array

        flatten = []
        self.my_each do |r|
            if !r.is_a? Array
                flatten << r
            else
            r.my_flatten
            end
        end
        return flatten
    end


end

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
