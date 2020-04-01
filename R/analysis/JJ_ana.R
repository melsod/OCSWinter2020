# Create 2 models for age indentify

fit1 <- glm(Correct|age ~ caregiving$data + childcare$data, data, family = binomial())
summary(fit1)

fit2 <- glm(Correct|age ~ caregiving$data + childcare$data + gender$data , data, family = binomial())
summary(fit2)

# Compare 2 models
R-square.change <- summary(fit2)$r.squared - summary(fit1)$r.squared

# test of change in R-square
anova(fit1,fit2,test="F")
