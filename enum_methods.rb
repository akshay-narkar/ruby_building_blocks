module Enumerable
  def my_each
    if block_given?
      for i in self
        yield(i)
      end
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    count = 0
    if block_given?
      for i in self
        yield(i, count)
        count += 1
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      if instance_of?(Hash)
        result = {}
        my_each { |key, value| result[key] = value if yield(key, value) == true }
      else
        result = []
        my_each { |value| result.push(value) if yield(value) == true }
      end
      result
    else
      to_enum(:my_select)
    end
  end

  def my_all?(arg = nil)
    count = 0
    unless arg.nil?
      case arg
      when Class
        my_each do |value|
          count -= 1 unless value.is_a?(arg)
          break if count.negative?
        end
      when Regexp
        my_each do |value|
          count -= 1 unless value.match(arg)
          break if count.negative?
        end
      else
        my_each do |value|
          count -= 1 unless value == arg
          break if count.negative?
        end
      end
      return count.negative? ? false : true
    end

    if block_given?
      my_each do |value|
        count -= 1 unless yield(value)
        break if count.negative?
      end
      count.negative? ? false : true
    else
      include?(nil) || include?(false) ? false : true
    end
  end

  def my_any?(arg = nil)
    count = 0
    unless arg.nil?
      case arg
      when Class
        my_each do |value|
          count -= 1 if value.is_a?(arg)
          break if count.negative?
        end
      when Regexp
        my_each do |value|
          count -= 1 if value.match(arg)
          break if count.negative?
        end
      else
        my_each do |value|
          count -= 1 if value == arg
          break if count.negative?
        end
      end
      return count.negative?
    end

    if block_given?
      my_each do |value|
        count -= 1 if yield(value)
        break if count.negative?
      end
    else
      my_each do |value|
        count -= 1 unless value.nil? || value == false
        break if count.negative?
      end
    end
    count.negative?
  end

  def my_none?(arg = nil)
    count = 0
    unless arg.nil?
      case arg
      when Class
        my_each do |value|
          count -= 1 if value.is_a?(arg)
          break if count.negative?
        end
      when Regexp
        my_each do |value|
          count -= 1 if value.match(arg)
          break if count.negative?
        end
      else
        my_each do |value|
          count -= 1 if value == arg
          break if count.negative?
        end
      end
      return count.negative? ? false : true
    end

    if block_given?
      my_each do |value|
        count -= 1 if yield(value)
        break if count.negative?
      end
      count.negative? ? false : true
    else
      my_each do |value|
        return false unless value.nil? || value == false
      end
      true
    end
  end

  def my_count(arg = nil)
    count = 0
    if block_given? && arg.nil?
      my_each { |value| count += 1 if yield(value) }
    elsif block_given? && !arg.nil?
      my_each { |value| count += 1 if value == arg }
    elsif !block_given? && arg.nil?
      my_each { count += 1 }
    else
      my_each { |value| count += 1 if value == arg }
    end
    count
  end

  # #8 my_map
  def my_map(proc = nil)
    result = []
    if proc.nil?
      if block_given? && is_a?(Hash)
        my_each { |key, value| result.push(yield(key, value)) }
        result
      elsif block_given?
        my_each { |key| result.push(yield(key)) }
        result
      else
        to_enum(:my_map)
      end
    else
      my_each { |key, value| result.push(proc.call(key, value)) }
      result
    end
  end

  def my_inject(arg1 = nil, arg2 = nil)
    raise LocalJumpError unless block_given? || !arg1.nil?

    if (!arg1.nil? && arg2.nil?) && (arg1.is_a?(Symbol) || arg2.is_a?(String))
      arg2 = arg1
      arg1 = nil
    end
    arr = is_a?(Range) ? to_a : self
    if !block_given? && !arg2.nil?
      arr.my_each do |value|
        arg1 = if arg1.nil?
                 value
               else
                 arg1.send(arg2, value)
               end
      end
    else
      arr.my_each do |value|
        arg1 = if arg1.nil?
                 value
               else
                 yield(arg1, value)
               end
      end
    end
    arg1
  end
end

# Multiply_els using my_inject
def multiply_els(arg)
  arg.my_inject { |counter, value| counter * value }
end
p multiply_els([2, 4, 5])
