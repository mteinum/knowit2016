# Alle kjenner til leken hvor man går runden rundt og teller men må hoppe over (klappe e.l) alle tall som enten har 7 i seg eller er delig på 7. Et eksempel er gitt under der '( )' indikerer et slikt tall.
# 1 2 3 4 5 6 ( ) 8 9 10 11 12 13 ( ) 15 16 ( ) 18 ...
#
# Algemannens versjon av denne leken er å fylle inn alle disse '( )' med begynnelsen på tallrekken igjen. Et eksempel under er gitt (legg merke til det siste 1'tallet der..):
# 1 2 3 4 5 6 (1) 8 9 10 11 12 13 (2) 15 16 (3) 18 19 20 (4) 22 23 24 25 26 (5) (6) 29 30 31 32 33 34 (1) 36 (8) 38 ..
#
# Vi er ute etter hvilket tall som blir stående på plass nr 1337. Svaret oppgis uten '( )' rundt.

defmodule Luke4 do

	def contains_or_mod_seven(n) do
		rem(n, 7) == 0 or Enum.any?(Integer.digits(n), fn(x) -> x == 7 end)
	end

	def get_next_value({_, current, inner}) do
		next = current + 1
		if (contains_or_mod_seven(next)) do
				if inner == nil do
					{1, next, {1, 1, nil}}
				else
					state = {value, _, _} = get_next_value(inner)
					{value, next, state}
				end
			else
				{next, next, inner}
			end
	end

	def generate_sequence() do
		Stream.unfold({0,0,nil}, fn(acc) ->
			# IO.inspect(acc)
			state = {value, _, _} = get_next_value(acc)
			{value, state}
		end)
	end

	def solve do
		generate_sequence()
		|> Enum.take(1337)
		|> Enum.reverse
		|> Enum.take(1)
	end
end