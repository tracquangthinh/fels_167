module Admin::CategoriesHelper
  def to_json category
    new_category = Hash.new
    new_category[:id] = category.id
    new_category[:name] = category.name
    new_category[:description] = category.description
    new_category[:numberWords] = category.words.size
    return new_category
  end
end
