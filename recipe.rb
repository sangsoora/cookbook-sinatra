class Recipe
  attr_reader :name, :description, :difficulty, :prep_time, :done
  def initialize(options = {})
    @name = options[:name] || 'No Name Recipe'
    @description = options[:description] || 'No Description'
    @difficulty = options[:difficulty] || 'N/A'
    @prep_time = options[:prep_time] || 'N/A'
    @done = options[:done] == 'true'
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
