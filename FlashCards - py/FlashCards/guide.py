import sys
import cards

class Guide:
    def __init__(self) :
        self.launch()

    def launch(self) :
        self.introduction()
        print("Press: \n0 - View Flash Cards \n1 - Add Flash Cards \n2 - Edit Flash Cards \n3 - Quit Application")
        user_response = sys.stdin.readline().strip()        
        
        cards.Cards.make_category_file(self)
        self.do_action(user_response)
        self.conclusion()

    def do_action(self, action) :   
        if action == '0' :
            # view flashcards
            self.choose_category()
        elif action == '1' :
            # create flashcards
            self.add_flash_cards()
        elif action == '2' :
            # edit flashcards
            print("Editing Flash Cards")
        elif action == '3' :
            exit()
        else :
            print("\nThis command does not exist!")

    def add_flash_cards(self) :
        print("Press: \n0 - Add new category:")
        categories = cards.Cards.saved_categories(self)
        if categories :
            print("or Add cards to existing category:")
            for i, category in enumerate(categories):
                print (str(i+1) + " - " + category)
        
        user_response = sys.stdin.readline().strip()
        self.do_category(user_response)

    def do_category(self, action) :
        path = ""
        categories = cards.Cards.saved_categories(self)
        if action == '0' :
            self.new_category()
        elif categories :
            for i, category in enumerate(categories):
                i = i + 1
                if action == str(i) :
                    path = category
            cards.Cards.save_category_name(self, path)
            print("Saved path: " + str(path))
            self.add_card(path) 
            ##
        else :
            print("Command not understood") 
            self.launch()

    def new_category(self) :
        print("What would you like to call this category of flashcards?")
        path = sys.stdin.readline().strip().lower()

        cards.Cards.make_category_file(self)
        cards.Cards.save_category_name(self, path)
        self.add_card(path)

    def add_card(self, path) :
        print("\nAdd a card:")
        
        print("Front of card:")
        front = sys.stdin.readline().strip().lower()

        print("Back of card:")
        back = sys.stdin.readline().strip().lower()

        card = ("\t").join([front, back])

        if cards.Cards.save_card(self, path, card) :
            print("Card Added")
        else :
            print("Save error: Card not added")

        print("Add another card to this category? type: (yes || no)")  
        res = sys.stdin.readline().strip().lower()  
        if res == 'yes' :
            self.add_card(path)
        elif res == 'no' :
            self.launch()
        else :
            print("Type either 'yes' or 'no' to proceed")
            print("Add another card to this category?")
        
    def choose_category(self) :
        car = cards.Cards.saved_categories(self)
        
        if car :
            print("Choose a category:")
            for i, category in enumerate(car):
                print (str(i) + " - " + category)
        else :
            print("You haven't added anything yet!")
            self.add_flash_cards()

        user_response = sys.stdin.readline().strip().lower()
        self.view_cards(user_response)


    def view_cards(self, user_response) :
        path = ""
        cars = cards.Cards.saved_categories(self)
        if cars :
            print("View Category: " + user_response)
            for i, category in enumerate(cars):
                if user_response == str(i) :
                    path = str(category)
            
                    x = 0
                    self.play_cards(path, x)

    # def list_cards(self, path) :
    #     print("Listing cards in categeory: " + path)
    #     car = cards.Cards.saved_card(self, path)
    #     print(car[0].front)

    def play_cards(self, path, i) :
        car = cards.Cards.saved_card(self, path)

        f = "CARD FRONT: " + car[i].front
        print(f)

        print("Press 'c' to check back of card, Press '1' to Exit")
        user_response = sys.stdin.readline().strip().lower()

        if user_response == 'c' :
            b = "CARD BACK: " + car[i].back
            print(b)

            self.play_cards(path, i)

        elif user_response == '1' :
            self.launch()
        else:
            print("Command not found")



    def introduction(self) :
        print("\n\n<<< Welcome to Flash Cards >>>\n")
        print("Add words and definitions to help yourself learn new things")

    def conclusion(self) :
        print("\n<<< Goodbye! Exiting Flash Cards! >>>\n\n")