# Julenissen er glad i å leke med tall og å kombinere det med en gjettelek er alltid en slager. I dagens luke tenker han på et sekssifret tall hvor summen av sifrene er 43. Og hvor bare to av de tre påstandene under er sanne:
# det er et kvadratisk tall
# det er et kubisk tall
# tallet er mindre enn 500 000
# Hvilket tall er det Julenissen tenker på?

defmodule Luke16 do

	def is_square(n) do
		s = round(:math.sqrt(n))
		s * s == n
	end

	def is_cubic(n) do
		[head|_] = Stream.unfold(1, fn(x) -> {x, x + 1} end)
		|> Stream.map(&(round(:math.pow(&1, 3))))
		|> Stream.take_while(fn(x) -> x <= n end)
		|> Enum.reverse

		head == n
	end

	def is_sum43(n) do
		43 == Integer.digits(n) |> Enum.sum
	end


	def solve do

		100000..999999
		|> Enum.filter(&(is_sum43(&1)))
		|> Enum.map(fn(x) -> {x, [is_square(x), is_cubic(x), x < 500000]} end)
		|> Enum.filter(fn(x = {_, arr}) ->
			Enum.count(arr, fn(b) -> b end) == 2
		end)

	end
end