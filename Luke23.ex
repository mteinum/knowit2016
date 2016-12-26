# Et barn løper opp en trapp med 250 trinn, og kan ta enten ett, to eller tre steg om gangen. Hvor mange ulike måter
# kan barnet løpe opp trappen?
defmodule Luke23 do
	def stairs(_, _, c, 0), do: c
	def stairs(a, b, c, n), do: stairs(b, c, a + b + c, n - 1) 
	def stairs(n), do: stairs(0, 0, 1, n)

	def solve do
		stairs(250)
	end
end
