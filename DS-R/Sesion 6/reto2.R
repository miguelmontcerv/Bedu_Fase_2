# Reto 2. Proceso ARIMA(1, 1, 1)

# 1. Simula n = 1000 valores de un proceso ARIMA(1, 1, 1) con par�metros
# ar = 0.6 y ma = 0.2

# 2. Ajusta un modelo Arima a la serie simulada para estimar los
# par�metros y observa las estimaciones de los par�metros

# 3. Obt�n el correlograma de los residuales del ajuste

# 4. Realiza tres predicciones con ayuda del modelo ajustado y la funci�n
# `predict`

# **Soluci�n**

# A continuaci�n, simulamos datos de un modelo ARIMA(1, 1, 1) 

set.seed(9)
x <- arima.sim(model = list(order = c(1, 1, 1), 
                            ar = 0.6, ma = 0.2), n = 1000)

# ajustamos un modelo a la serie simulada para recuperar los par�metros 
# estimados

fit <- arima(x, order = c(1, 1, 1))

# observamos las estimaciones de los par�metros

coefficients(fit)

# obtenemos el correlograma de los residuales del ajuste

acf(resid(fit), main = "")
title(main = "Autocorrelaciones para los Residuales del Ajuste")

# Llevamos a cabo tres predicciones con el modelo ajustado y la funci�n `predict`

pred <- predict(fit, n.ahead = 3)
pred$pred