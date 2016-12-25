# I påvente av hva som kan skje når Trump inntar presidentstolen, har Knowit begynt å regne på noen passende mot-tiltak. Den amerikanske regjeringen har allerede utredet mulighetene for å bygge en Death Star, og selv om Obama-administrasjonen sa nei til The Death Star Petition i 2012 så tror vi det er meget sannsynlig at Trump kommer til å bestille en. Energien i strålen fra en Death Star må nå ca 2.25 * 10^32 J for å ødelegge jorden [Boulderstone et al. 2011].
# Knowits ingeniører har funnet ut at for å stoppe dette trenger vi en legering bestående av et partall antall metaller. Det kan maks være 16 metaller med i legeringen. Metallene det er snakk om er for øyeblikket ikke kjent for andre enn forskerne i Area 51 og oss i Knowit. Dere kan kalle dem metall-1, metall-2 osv opp til metall-16.
# Metallene har en planet-killer-motstandskraft lik tallet opphøyd i seg selv (så metall 1 har en motstandskraft på 1, metall 16 har en motstandskraft på 16^16. Motstandskraften til en legering er produktet av kraften til metallene som er med i legeringen.
# Så legeringen bestående av metall-2 og metall-4 vil ha en motstandskraft lik produktet av motstanden i metall-2 og metall-4. Det blir (2^2) * (4^4), eller 4*256 = 1024.
# Finn metallene i den legeringen som har mostandskraft høyere enn energien som skal til for å ødelegge jorden, hvor summen av fakultetsverdiene av nummrene på metallene i legeringen er lavest mulig. For eksempel, om kandidatene er legeringen bestående av metall 13 og 14, eller metall 11 og 15, så må du sammenligne 13!+14! med 11!+15! og velge legeringen med lavest resultat.
# Svaret vi er ute etter er numrene på metallene som er med i legeringen konkatenert i stigende rekkefølge (ikke i kommaseparert liste).
# Eksempel: viser det seg at alt du trenger er elementene 1 og 16 i legeringen blir svaret 116.
# Help us! You're our only hope! (You're all rebels, aren't you?)

defmodule Luke14 do
	def combinations(_, 0), do: [[]]
	def combinations(xs, 1), do: xs |> Enum.map(&([&1]))
	def combinations(xs, k) when k >= length(xs), do: [xs]
	def combinations([h|t], k) do
		with_h = for cs <- combinations(t, k-1) do
			[h | cs]
		end
		with_h ++ combinations(t, k)
	end

	def factorial(0), do: 1
    def factorial(n) when n > 0 do
      n * factorial(n - 1)
    end

	def resistanse(list) do
		Enum.reduce(list, 1, fn(n, acc)->
			acc * round(:math.pow(n,n))
		end)
	end

	def sum_factorial(list) do
		Enum.map(list, &(factorial(&1))) |> Enum.sum
	end

	def list_to_string(list) do
		Enum.map(list, &(Integer.to_string(&1))) |> Enum.join
	end

	def level(n) do
		needed = 2.25e32
		
		combinations(Enum.to_list(1..16), n)
		|> Enum.map(fn(list) -> {resistanse(list), list_to_string(list), sum_factorial(list)} end)			
		|> Enum.filter(fn({x, _, _}) -> x > needed end)
	end

	def solve do
		1..8
		|> Enum.map(&(level(&1 * 2)))
		|> Enum.reduce([], fn(list, acc) ->
			Enum.concat(acc, list)
		end)
		|> Enum.min_by(fn({_,_,sf})-> sf end)	
	end

end