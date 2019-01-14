class Cards

    @@filepath = nil
    @@filecat = File.join(APP_ROOT, 'files', 'categories')

    def self.filepath=(path=nil)
      @@filepath = File.join(APP_ROOT, 'files', path)
    end

    attr_accessor :front, :back
    
    def self.file_exists?
      if @@filepath && File.exists?(@@filepath)
        return true
      else
        return false
      end
    end
    
    def self.file_usable?
      return false unless @@filepath 
      return false unless File.exists?(@@filepath)
      return false unless File.readable?(@@filepath)
      return false unless File.writable?(@@filepath)
      return true
    end

    def self.cat_file_usable?
        return false unless @@filecat
        return false unless File.exists?(@@filecat)
        return false unless File.readable?(@@filecat)
        return true
      end
    
    def self.create_file
      File.open(@@filepath, 'w') unless file_exists?
      return file_usable?
    end
    
    def save_card
        return false unless Cards.file_usable?
        File.open(@@filepath, 'a') do |file|
          file.puts "#{[@front, @back].join("\t")}\n"
        end
        return true
    end

    def self.saved_categories
        categories = []
        if cat_file_usable?
            file = File.new(@@filecat, 'r')
            file.each_line do |line|
                categories.push(line)
            end
            file.close
        end
        return categories
    end

    def self.save_category_name(category)
      File.open(@@filecat, 'a') do |file|
        file.puts "#{category}\n"
      end
    end

    def self.saved_card
        cards = []
        if file_usable?
            file = File.new(@@filepath, 'r')
            file.each_line do |line|
                cards << Cards.new.import_line(line.chomp)
            end
            file.close
        end
        
        return cards.shuffle
    end

    def import_line(line)
        line_array = line.split("\t")
        @front = line_array[0]
        @back = line_array[1]
        return self
    end
    
end