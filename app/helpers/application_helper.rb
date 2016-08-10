module ApplicationHelper
  def avatar_for user, options = {size: 80}
    if user.avatar?
      image_tag user.avatar, class: "my-avatar-home"
    else
      image_tag "medium/missing.png", class: "my-avatar-home"
    end
  end

  def color_for result, answer
    return "green" if answer.is_correct
    return "red"  if answer.id == result.word_answer_id
    return "black"
  end

  def check_answer result
    if result.word_answer_id == 0
      return t :dont_answer
    end
  end
end
