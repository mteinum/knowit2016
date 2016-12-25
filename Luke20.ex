# Å nei, i julestresset har Alvin glemt det eneste han skulle huske hele julen; det hemmelige tallet! 
# Det eneste han husker er at tallet er det høyeste mulige produktet hvis du multipliserer to tall som består av sifrene 0-9 hvor man bare kan bruke hvert siffer én gang.
#
# F.eks er dette to gyldige tall å multiplisere: 12340 * 56789, mens dette er ikke to gyldige tall å multiplisere: 220135 * 74896
#
# Hva er det hemmelige tallet Alvin har glemt?

defmodule Luke20 do

	def solve do
		1..5
		|> Enum.map(fn(x) -> best_of_number(x) end)
		|> Enum.max
	end

	def best_of_number(n) do
		digits = [9,8,7,6,5,4,3,2,1,0]
		
		Luke14.combinations(digits, n)
		|> Enum.map(fn(n) -> {n, digits -- n} end)
		|> Enum.map(fn({a, b}) -> Integer.undigits(a) * Integer.undigits(b) end)
		|> Enum.max
	end
end