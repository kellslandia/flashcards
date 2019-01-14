class Guide
          
    def initialize
        launch
        # Cards.filepath = path
        # if Cards.file_usable?
        #   puts "Found flashcard file."
        # # or create a new file
        # elsif Cards.create_file
        #   puts "Created flashcard file."
        # # exit if create fails
        # else
        #   puts "Exiting.\n\n"
        #   exit!
        # end
    end

    def launch
        introduction
        # action loop
        puts "Press: \n0 - View Flash Cards \n1 - Add Flash Cards \n2 - Edit Flash Cards \n3 - Quit Application \n\n"
        print "> "
        user_response = gets.chomp
        # do that action
        result = do_action(user_response)

        conclusion
    end

    def do_action(action)
        case action
        when '0'
            choose_category
        when '1'
            add_flash_cards
        when '2'
            puts "Editing flash cards..."
        when '3'
            return :quit
        else
            puts "\nThis command does not exist!\n"
        end
    end

    def add_flash_cards 
        puts "Press: \n0 - Add new category"
        if Cards.saved_categories.any?
            puts "or Add cards to existing category:\n"  
            cards = Cards.saved_categories
            cards.to_enum.with_index(1).each do |category, i|
                puts "#{i} - #{category}"
            end
        end

        print "> "
        user_response = gets.chomp
        result = do_category(user_response)
    end

    def do_category(action)
        path = nil
        if action == '0'
            new_category
        elsif Cards.saved_categories.any?
            cards = Cards.saved_categories
            cards.to_enum.with_index(1).each do |category, i|
                if action == "#{i}"
                    path = "#{category}"                
                end
            end
            Cards.filepath = path.downcase.strip
            puts "\nCatergory Selected: " + path
            add_card
        else
            puts "Command not understood"
        end
    end    

    def choose_category
        if Cards.saved_categories.any?
            puts "Choose a category:\n"  
            cards = Cards.saved_categories
            cards.to_enum.with_index(1).each do |category, i|
                puts "#{i} - #{category}"
            end
        end    
        
        print "> "
        user_response = gets.chomp
        result = view_cards(user_response)
    end

    def view_cards(action)
        path = nil
        if Cards.saved_categories.any?
            puts "View Category:" + action
            cards = Cards.saved_categories
            cards.to_enum.with_index(1).each do |category, i|
                if action == "#{i}"
                    path = "#{category}"                
                end
            end
            Cards.filepath = path.downcase.strip
            puts "\nCatergory Selected: \s" + path
            
            # view cards here
            i = 0  
            play_cards(i)

        else
            puts "Command not understood"
        end
    end       

    def list_cards(path)
        puts "\nListing cards in category: " + path
        cards = Cards.saved_card
        cards.each do |card|
            puts card.front + " | " + card.back
        end
    end

    def play_cards(i)
        cards = Cards.saved_card

        f = "CARD FRONT: " + cards[i].front
        puts f   

        puts "Press 'c' to check back of card, Press '1' to Exit"
        user_response = gets.chomp    
        
        if user_response == 'c' 
            b = "CARD BACK: " + cards[i].back + "\n"
            puts b  
            
            if cards[i + 1] == nil
                i = 0
            end
            play_cards(i) 
        elsif user_response == '1'
            guide = Guide.new
        else
            puts("Command not found")
        end

    end

    def play_card(cards, i)
        f = "CARD FRONT: " + cards[i].front
        puts f       
    end

    def new_category
        puts "What would you like to call this category of flashcards?"
        print "> "
        user_response = gets.chomp
        path = user_response.downcase.strip

        Cards.filepath = path
        if Cards.file_usable?
          puts "It looks like this category already exists!"
        # or create a new file
        elsif Cards.create_file
          puts "Created flashcard category named " + path
          Cards.save_category_name(path)
          list_categories
        # exit if create fails
        else
          puts "Exiting.\n\n"
          exit!
        end
    end

    def list_categories
        puts "Listing Categories"
        cards = Cards.saved_categories
        cards.each do |card|
            puts card
        end
    end

    def add_card
        puts "\nAdd a card\n"
        cards = Cards.new
        
        print "Front of card: "
        cards.front = gets.chomp.strip
    
        print "Back of card: "
        cards.back = gets.chomp.strip
        
        if cards.save_card
          puts "\nCard Added\n\n"
        else
          puts "\nSave Error: Card not added\n\n"
        end   
        
        puts "\nAdd another card to this category type: ('yes' || 'no') \n"
        answ = gets.chomp.strip

        if answ == 'yes'
            add_card
        else
            launch
        end
    end    
    
    def introduction
        puts "\n\n<<< Welcome to Flash Cards >>>\n\n"
        puts "Add words and definitions to help you learn new things\n\n"
    end
    
    def conclusion
        puts "\n<<< Goodbye! Exiting Flash Cards >>>\n\n\n"
    end    
end
