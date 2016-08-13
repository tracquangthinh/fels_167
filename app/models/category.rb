class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words, dependent: :destroy
  scope :previous, ->(id) {where("id < ?", id).last}
  scope :next, ->(id) {where("id > ?", id).first}
  validates :name, presence: true, length: {maximum: 45}, uniqueness: true
  validates :description, presence: true, length: {maximum: 255}

  class << self
    def find_ids ids
      begin
        @categories = self.find ids
      rescue ActiveRecord::RecordNotFound
        return nil
      else
        return @categories
      end
    end

    def import file
      spreadsheet = open_spreadsheet file
      header = spreadsheet.row 1
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        category = new
        category.attributes = row.to_hash.slice "name", "description"
        category.save!
      end
    end

    def open_spreadsheet file
      case File.extname file.original_filename
        when ".csv" then Roo::Csv.new file.path, packed: nil,
          file_warning: :ignore
        when ".xls" then Roo::Excel.new file.path, packed: nil,
          file_warning: :ignore
        when ".xlsx" then Roo::Excelx.new(file.path, packed: nil,
          file_warning: :ignore)
        else raise "#{t :unknown_file} #{file.original_filename}"
      end
    end
  end
end
