# Kongen av Indonesia har som tradisjon å sende sine julehilsener kryptert til sine venner. I år skjedde det en glipp og kongen sendte meldingen til alle i hele verden med en email adresse, vi har også fått meldingen og trenger hjelp til å dekryptere den. Med meldingen fulgte også følgende instruksjoner på hvordan den kan dekrypteres:
# For å dekryptere meldingen må man først legge sammen parene i listen, ett par er første og siste element, andre og nest siste element og så videre. Når du har alle verdiene kan du oversette disse til bokstaver, hvor a = 1 og z = 26.

defmodule Luke5 do

	def handle_negative("IV") do "IIII" end
	def handle_negative("IX") do "VIIII" end
	def handle_negative(a) do a end

	def roman_to_dec("0") do 0 end
	def roman_to_dec("I") do 1 end
	def roman_to_dec("V") do 5 end
	def roman_to_dec("X") do 10 end

	def roman([], acc) do acc end
	def roman([head|tail], acc) do
		[roman_to_dec(head)] ++ roman(tail, acc)
	end
	def roman(value) do
		roman(String.codepoints(value), []) |> Enum.sum
	end


	def numbers_to_pair([], acc) do acc end
	def numbers_to_pair([head|tail], acc) do
		[last|rest] = Enum.reverse(tail)
		[<< ?a + head + last - 1 :: utf8 >>] ++ numbers_to_pair(rest, acc)
	end


	def solve do
		content = File.read!("./Luke05.txt")
		
		numbers = String.slice(content, 1, String.length(content) - 2)
		|> String.split(", ")
		|> Enum.map(&(handle_negative(&1)))
		|> Enum.map(&(roman(&1)))

		numbers_to_pair(numbers, []) |> to_string
	end

end
