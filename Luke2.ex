# Fibonaccirekken er en tallrekke som genereres ved at man adderer de to
# foregående tallene i rekken. f.eks. om man starter med 1 og 2 blir de
# første 10 termene 1, 2, 3, 5, 8, 13, 21, 34, 55 og 89.
# Finn summen av alle partall i denne rekken som er mindre enn 4.000.000.000

defmodule Luke2 do
	import Integer

	def fib(a, _, 0 ) do a end
	def fib(a, b, n) do fib(b, a+b, n-1) end
	def fib(n) do fib(1,1,n) end

	defp in_range(n) do n < 4000000000 end

	def solve do

		Stream.iterate(1, &(&1 + 1))
		|> Stream.map(&(fib(&1)))
		|> Stream.take_while(&(in_range(&1)))
		|> Stream.filter(&(Integer.is_even(&1)))
		|> Enum.sum

	end
end