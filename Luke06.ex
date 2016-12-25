# I et rutenett som strekker seg uendelig i alle retninger starter en sjakk-springer i koordinat (0,0). Alle rutene har i utgangspunktet en tallverdi som tilsvarer summen av x og y-koordinaten. Så rute (0,0) har verdi 0, rute (1,1) har verdi 2, rute (-1, 5) har verdi 4, rute (8000,-8000) har verdi 0, osv.
#
# I hver runde skal springeren flytte seg en gang, og den flytter seg selvfølgelig på de måtene som er lovlige for en springer i sjakk. Springeren velger å flytte seg til den tilgjengelige ruten som har verdi nærmest verdien til den ruta den for øyeblikket står på. Hvis det er flere kandidater velges den med lavest x-koordinat, og hvis dette også er likt velges den med lavest y-koordinat.
#
# Etter at springeren har flyttet settes verdien i den ruta den nettopp forlot til 1000 - med mindre den allerede var 1000, i hvilket tilfelle den settes til 0.
#
# Avstanden mellom to ruter defineres som summen av absoluttverdiene av forskjellene på de to koordinatene. Så avstanden fra (-6,7) til (18,18) er |-6-18| + |7-18| = 24+11 = 35.
#
# Hva er den største avstanden mellom to ruter springeren har besøkt når den har besøkt 1 000 000 000 000 000 forskjellige ruter? (Både den første ruta og den siste den lander på teller som besøkte.)


defmodule Luke6 do
	def solve do
		(1000000000000000 - 1) * 3
	end
end