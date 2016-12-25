# Ormehull
# Du befinner deg i et rutenett som er 100.000x100.000 stort.
#
# Du står i øvre venstre hjørnet av rutenettet, punktet 0,0, og skal til nedre høyre hjørne, punktet 99.999, 99.999. I rutenettet kan du bevege deg opp, ned, til høyre og til venstre. Hver bevegelse tar ett skritt. Hvis f.eks. fra start går ett skritt til høyre havner du på punktet 1,0. Hvis du så går ett skritt ned havner du på punktet 1,1 osv.
#
# På rutenettet finnes det 11 ormehull som kan transportere deg fra ett punkt til et annet. Ormehullene fungerer begge veier, fra x til y og fra y til x og koster ingen skritt å bruke. 
# Ditt mål er å finne veien med kortest antall skritt til mål.
#
# Eks:
# Hvis rutenettet var 10x10 stort og det fantes 2 ormehull;
# 1,2-5,3
# 3,4-7,8
#
# Ville antall skritt fra 0,0 til 9,9 være 9. F.eks. via. veien høyre, ned, ned, (ormehull fra 1,2 til 5,3), venstre, venstre, ned, (ormehull fra 3,4 til 7,8), ned, høyre, høyre.

defmodule Luke17 do

	def holes do
		[
{{14519,47295},{54910,18357}},
{{45202,1108},{9617,37834}},
{{34172,74888},{38215,50481}},
{{4027,98283},{83695,63613}},
{{41187,8287},{94719,64497}},
{{49969,28072},{21579,16713}},
{{96264,65077},{17247,22643}},
{{41952,229},{88333,84187}},
{{7527,68937},{22294,31187}},
{{8800,49312},{11296,83909}},
{{88405,32174},{54748,58082}}]
	end

	def test do
		# er på 0,0, skal til  99.999,  99.999

		Enum.map(holes, fn({{x,y},{a,b}}) ->
			# distance to
			{{x + y, x, y}, {a, b, 99999 - a + 99999 - b}}
		end)
		|> Enum.sort_by(fn({{distance, _, _}, _}) -> distance end)

		# 0,0
		# til 41952,229: 42181 steg
		# overføres til
		# 88333, 84187
		# antall steg til mål: 27478
		#
		# totalt: 42181 + 27478
		#

	end


end