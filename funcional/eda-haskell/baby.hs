doubleMe x = x + x
doubleUs x y =doubleMe x + doubleMe y
doubleSmallNumber x = if x >100
                     then x
                     else x*2

sumRec xs= if (length xs==0)
            then 0
            else 
                head xs+
                sumRec (tail xs)
        
          

