# En skøyen alv har gjemt pakkene til nissen og julaften står i fare! Alven etterlot seg et kart over med et rødt kryss midt på finnmarksvidda med tekst 'start here'. På baksiden av kartet er det instruksjoner som sier hvor du skal gå fra krysset. Du har fått som oppgave å hjelpe nissen med å finne pakkene og redde julaften.
# Skattekartet har veldig mange steg, men du ser kjapt at det bare består av 4 forskjellige instruksjoner, å gå x antall meter nord (north), sør (south), øst (east), eller vest (west). Du bestemmer deg for å lage et program som samler disse stegene og returnerer antall meter nord og antall meter vest, hvor et negativt tall betyr motsatt retning.

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