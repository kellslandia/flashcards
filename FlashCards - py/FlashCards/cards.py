import sys
import random

class Cards :
    path = ""

    def __init__(self, front, back) :
        self.front = front
        self.back = back

    def make_category_file(self) :
        file = open("files/categories.txt", "a")
        file.close
        return True

    def save_category_name(self, category) :
        file = open("files/categories.txt", "a")
        file.write(str(category) + "\n")
        file.close

        path = str(category.strip)
        cat_file = open("files/" + category + ".txt", "a")

    def saved_categories(self) :
        categories = []
        file = open("files/categories.txt", "r")
        for category in file:
            categories.append(category.strip())
        file.close
        return categories
    
    def save_card(self, category, card) :
        path = str(category.strip())
        file = open("files/" + path + ".txt", "a")
        file.write(str(card) + "\n")
        file.close
        return True 

    def saved_card(self, path) :
        cardsList = []
        p = str(path.strip())
        file = open("files/" + p + ".txt", "r")
        for cards in file:
            make = cards.strip().split("\t")
            front = make[0]
            back = make[1]
            nwCard = Cards(front, back) 
            cardsList.append(nwCard)

        file.close
        random.shuffle(cardsList)
        return cardsList   

    # def import_line(line) :
    #     line_array = line.split("\t") 
    #     self.front = line_array[0]
    #     self.back = line_array[1]
    #     return self


        