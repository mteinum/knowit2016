# Julenissen starter i et av hjørnene av en likesidet trekant og skal velge mellom de to mest nærliggende verdiene på neste rad mens han går mot den andre siden. Hva er den største mulige totale verdien han kan finne langs stien gjennom triangelet, og i hvilket hjørne må han starte for å finne denne?
# Svarformat: [hjørne][sum], hvor hjørnene er navngitt [A, B, C], fra toppen med klokka.
defmodule Luke21 do

	def solve do
  		a = read_file
		b = triangle_rotate(a)
		c = triangle_rotate(b)

		[{"A", triangle_path(a)}, {"B", triangle_path(b)}, {"C", triangle_path(c)}]
		|> Enum.max_by(fn({_,n}) -> n end)
		|> (fn({l,n})-> "#{l}#{n}" end).()
	end

	def test do
		read_file |> triangle_path
	end

	def triangle_path(triangle) do
		# rosettacode
		triangle
		|> Enum.reduce([], fn(x, total) ->
			Enum.chunk([0] ++ total ++ [0], 2, 1)
			|> Enum.map(&Enum.max(&1))
			|> Enum.zip(x)
			|> Enum.map(fn({a,b}) -> a+b end)
			end)
		|> Enum.max
	end

	def triangle_rotate(triangle), do: triangle_rotate(triangle, [])
	def triangle_rotate([], acc), do: acc
	def triangle_rotate(triangle, acc) do
		triangle
		|> Enum.map(&(tl(&1)))
		|> Enum.filter(&(Enum.any?(&1)))
		|> triangle_rotate([triangle |>  Enum.map(&(hd(&1)))] ++ acc)
	end

	def read_file do
		File.stream!("./Luke21.txt")
		|> Enum.map(&(String.replace_trailing((&1), "\n", "")))
		|> Enum.map(fn line -> String.split(line) |> Enum.map(&String.to_integer(&1)) end)
	end
end