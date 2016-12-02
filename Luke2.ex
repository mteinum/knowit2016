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