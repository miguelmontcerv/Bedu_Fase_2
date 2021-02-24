#Reto 2

#Tomamos datos de -10 a 10 para que sea más variado
ran <- rnor(44)
(ran)

el <- vector() #Declaramos el vector
for (i in 1:15) {
  el[i] <- (ran[i]^3) + 12
  print(el[i])
}

df.al <- data.frame(rango = ran[1:15],valor = el)
(df.al)
