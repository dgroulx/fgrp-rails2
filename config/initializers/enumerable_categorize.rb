module Enumerable
  def categorize
    result = Hash.new do |h,k| h[k] = [] end
    each do |value|
      result[yield(value)] << value
    end
    result
  end
end

