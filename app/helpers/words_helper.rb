module WordsHelper
  def previous_category id
    @previous_category = Category.previous id
    @previous_category = (@previous_category.instance_of? Category) ?
      @previous_category : nil
  end

  def next_category id
    @next_category = Category.next id
    @next_category = (@next_category.instance_of? Category) ?
      @next_category : nil
  end

  def length_part_list category
    lengthPart = @category.words.count / Settings.words_list_column
    @words = Array.new(4)
    4.times{
      |i| @words[i] = @category.words[lengthPart*i..lengthPart*(i+1)]
    }
    return @words
  end
end
