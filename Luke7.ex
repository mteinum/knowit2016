defmodule Luke7 do

	def translate({"east", meters}) do { 0, -meters } end
	def translate({"west", meters}) do { 0, meters } end
	def translate({"north", meters}) do { meters, 0 } end
	def translate({"south", meters}) do { -meters, 0 } end

	def solve do
		f = File.stream!("./Luke7.txt")
		|> Enum.map(&(String.replace_trailing((&1), "\n", "")))
		|> Enum.map(
			fn line -> 
				["walk", n, "meters", direction] = String.split(line, " ", trim: true)
				{meters, ""} = Integer.parse(n)
				translate({direction, meters})
			end)
		
		Enum.reduce(f, {0,0}, fn({a, b}, {x, y}) -> {a+x, b+y} end)

	end
end