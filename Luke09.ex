# I en cryptocurrency som f. eks. Bitcoin bestemmes balansen til en konto ut av historikken av transaksjoner. Det vil si at
# hvis historikken kun består av én transaksjon hvor addresse X mottok 10 penger, så sier vi at balansen til X er 10.
# Dersom det kommer en ny transaksjon fra X til Y hvor det sendes 7 penger, så er balansen til Y: 7 og X: 3.
# I filen det lenkes til finnes det to typer transaksjoner. Den ene typen er som den første beskrevet her, hvor penger
# trykkes ut av intet, og en heldig adresse mottar en viss sum penger. I den andre typen går pengene fra en adresse til en annen.
# Ved å holde rede på alle transaksjoner i filen http://pastebin.com/raw/2vstb018, hvor mange adresser har en balanse
# på mer enn 10 penger når samtlige transaksjoner er utført?
# Alle transaksjoner er gyldige, så du slipper å validere dem.

defmodule Luke9 do

	def solve do
		File.stream!("./Luke09.txt")
		|> Enum.map(&(String.replace_trailing(&1, "\n", "")))
		|> Enum.map(&(String.split(&1, ",")))
		|> Enum.map(fn([from, to, amount]) ->  {from, to, String.to_integer(amount)} end)
		|> Enum.reduce(Map.new, fn({from, to, amount}, acc) ->
			acc 
			|> Map.update(from, -amount, fn(ledger) -> ledger - amount end)
			|> Map.update(to, amount, fn (ledger) -> ledger + amount end)
		end)
		|> Enum.filter(fn(t) -> elem(t, 1) > 10 end)
		|> Enum.count
	end
end
