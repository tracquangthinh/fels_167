module Admin::WordsHelper
  def to_json word, answer_right
    new_word = Hash.new
    new_word[:id] = word.id
    new_word[:category_id] = word.category.id
    new_word[:content] = word.content
    numberAnswers = word.word_answers.size
    new_word[:answers] = Array.new(numberAnswers)
    numberAnswers.times{
      |i| new_word[:answers][i] = word.word_answers[i].content
    }
    new_word[:answer_right] = answer_right
    return new_word
  end
end
