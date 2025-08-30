/* 
Пример описания (trend):
- slope = (lastPrice - price N ticks ago) / N
- trendComponent = slope * trendMultiplier
- price = basePrice + trendComponent + noise */