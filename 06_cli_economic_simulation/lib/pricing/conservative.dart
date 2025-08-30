/* 

Пример описания (conservative):
- smoothingWindow = 5
- price = average(last N prices) * (1 + smallNoise)
- clamp change to +/- (volatility * 0.2) relative to basePrice

 */