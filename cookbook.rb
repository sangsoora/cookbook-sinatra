require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path = '')
    @filepath = csv_file_path
    @recipes = []
    if @filepath == ''
      @recipes
    else
      load_csv
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  def mark_recipe
    save_to_csv
  end

  def find(index)
    @recipes[index]
  end

  private

  def load_csv
    csv_options = {
      headers: true,
      header_converters: :symbol
    }
    CSV.foreach(@filepath, csv_options) do |row|
      @recipes << Recipe.new(row)
    end
  end

  def save_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@filepath, 'wb', csv_options) do |csv|
      csv << ['name', 'description', 'difficulty', 'prep_time', 'done']
      @recipes.each do |r|
        csv << [r.name, r.description, r.difficulty, r.prep_time, r.done]
      end
    end
  end
end
