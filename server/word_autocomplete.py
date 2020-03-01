# -*- coding: utf-8 -*-
"""
Created on Sat Feb  1 20:01:53 2020

@author: priya
"""

class TrieNode(): 
    def __init__(self): 
          
        # Initialising one node for trie 
        self.children = {} 
        self.last = False
  
class Trie(): 
    def __init__(self): 
          
        # Initialising the trie structure. 
        self.root = TrieNode() 
        self.word_list = [] 
  
    def formTrie(self, keys): 
          
        # Forms a trie structure with the given set of strings 
        # if it does not exists already else it merges the key 
        # into it by extending the structure as required 
        for key in keys: 
            self.insert(key) # inserting one key to the trie. 
  
    def insert(self, key): 
          
        # Inserts a key into trie if it does not exist already. 
        # And if the key is a prefix of the trie node, just  
        # marks it as leaf node. 
        node = self.root 
  
        for a in list(key): 
            if not node.children.get(a): 
                node.children[a] = TrieNode() 
  
            node = node.children[a] 
  
        node.last = True
  
    def search(self, key): 
          
        # Searches the given key in trie for a full match 
        # and returns True on success else returns False. 
        node = self.root 
        found = True
  
        for a in list(key): 
            if not node.children.get(a): 
                found = False
                break
  
            node = node.children[a] 
  
        return node and node.last and found 
  
    def suggestionsRec(self, node, word): 
          
        # Method to recursively traverse the trie 
        # and return a whole word.  
        if node.last: 
            self.word_list.append(word) 
  
        for a,n in node.children.items(): 
            self.suggestionsRec(n, word + a) 
  
    def printAutoSuggestions(self, key): 
          
        # Returns all the words in the trie whose common 
        # prefix is the given key thus listing out all  
        # the suggestions for autocomplete. 
        node = self.root 
        not_found = False
        temp_word = '' 
  
        for a in list(key): 
            if not node.children.get(a): 
                not_found = True
                break
  
            temp_word += a 
            node = node.children[a] 
  
        if not_found: 
            return 0
        elif node.last and not node.children: 
            return -1
  
        self.suggestionsRec(node, temp_word) 
  
        for s in self.word_list: 
            print(s) 
        return 1
  
    
def main(key):
    
    #keys = ["python", "pycharm", "rcnn", "rnn", "a",  "hel", "help", "helps", "helping"]
    key_x=pd.read_csv("word_autodict.csv")
    key_array=list(key_x.columns)
    final_array=[]
    for i in key_array:
        
        x=str(i).replace(' ','',1)
        x=x.lower()
        final_array.append(x)

    status = ["Not found", "Found"] 
    
    t = Trie() 
   
    t.formTrie(final_array) 
       
    comp = t.printAutoSuggestions(key) 
      
    if comp == -1: 
        print("No other strings found with this prefix\n") 
    elif comp == 0: 
        print("No string found with this prefix\n") 
        
main("d")
        
#key=pd.read_csv("word_autodict.csv")
#key_array=list(key.columns)
#print(key_array)

'''
key_array=str(key.columns)
key_array=key_array.split(",")
key_array=list(key_array)
'''