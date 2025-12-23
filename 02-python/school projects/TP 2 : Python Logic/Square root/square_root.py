'''
comment il fonctione :
si la valeur de derniere iteration et de cette itteration sont les meme sans la vergule 
donc on a trouver la racine 
'''
number = -1
while number < 0:
    number = int(input("Enter a positif number :"))

haut = number
bas = 0
milieu = (haut + bas)/2
old = haut   # intialization de valeure de dernier itteration par haut car est toujour different de milieu
while old != int(milieu) :
    old = int(milieu)
    if milieu * milieu > number :
        haut = milieu
    else :
        bas = milieu
    milieu = (haut + bas )/2 
print ('the approximated result is :',int(milieu))
