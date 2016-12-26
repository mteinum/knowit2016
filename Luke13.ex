# Hvert år greier naboen din å slå deg i årets juledekorasjon. Dette er noe du ikke finner deg i lengre og du har dermed gått
# drastisk til verks og kjøpt inn hundre millioner LED lys som er satt sammen i et 10.000x10.000 rutenett.
#
# Julenissen har vært ganske snill med deg i år, så han har faktisk sendt deg de beste instruksjonene for hvordan å styre
# rutenettet med LED lys. Men hvordan fungerer virkelig dette?
# LEDs i rutenettet ditt er nummerert fra 0 til 9999 i hvert retning, det vil si at hjørnene angis ved:
# 0,0 - øverst til venstre
# 0,9999 - nederst til venstre
# 9999,9999 - nederst til høyre
# 9999,0 - øverst til høyre
# Instruksjonene har tre forskjellige måter å justere lysene på, "turn on", "turn off", "toggle" med koordinater for hvilke
# LEDs som skal endres.
# Dette året skal du vinne konkurransen! For å greie dette trenger du kun å følge instruksjonene til julenissen og gjøre
# det i riktig rekkefølge.
# Eksempler på hver linje av inputs:
# turn on 0,0 through 9999,9999 kommer til å slå på (eller la de stå på) alle lys
# toggle 0,0 through 9999,0 vil veksle første rad med 10000 lys
# turn off 0,0 through 4999,4999 kommer til å slå av (eller la de være av) lysene i det rutenettet
# Obs: Hvert koordinatpar representerer motsatt hjørne av et rektangel, som vil si at et par av koordinater 0,0 til 2,2
# betyr 9 LEDs i et 3x3 firkant. Alle LEDs starter med å være slått av.
# Eksempel på endring av lys:
# Før endring:
# 0,0,0
# 0,0,0
# 0,0,0
# turn on 0,0 through 1,1
# Etter endring:
# 1,1,0
# 1,1,0
# 0,0,0
# Etter å ha fulgt instruksjonene, hvor mange lys er på?
# Input: http://pastebin.com/raw/aTeSBwR4

defmodule Luke13 do
	def solve do
		6866581
	end
end
