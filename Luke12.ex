# Etter å ha mottatt en kryptert julehilsen fra kongen i Indonesia vil vi gjerne sende en hyggelig melding tilbake på
# samme krypteringsformat vi fikk meldingen på.
#
# Vi ønsker å sende følgende melding:
#
# Your message was received with gratitude! We do not know about you, but Christmas is definitely our favourite holiday.
# The tree, the lights, all the presents to unwrap. Could there be anything more magical than that?! We wish you a happy
# holiday and a happy new year!
#
# Meldingen skal være på et format hvor hver bokstav er representert av to romertall som utgjør et par.  Et par gir til
# sammen bokstavens verdi, hvor a/A=1 og z/Z=26. En melding er satt sammen av par i ei liste. Man finner hvert tall i
# paret ved å dele bokstavens verdi på to. Hvis bokstavens verdi er oddetall legges det største tallet i paret først i
# lista og det minste tallet bakerst i lista. Lista med romertall starter med en hakeparentes "[" og avsluttes med en
# hakeparentes "]", romertallene i lista er adskilt med mellomrom mellom komma og neste romertall.
#
# For eksempel hvis vi skal kryptere bokstaven 'M' eller 'm', har denne bokstaven verdien 13, det er et oddetall så da
# legges 7 nærmest starten av lista og 6 nærmest slutten av lista og vi får : [VII, VI]
#
# Romertallene skriver vi med store bokstaver [VII, VI], ikke [vii, vi].
#
# Hvis ett av tallene i parene er 0, representeres det også som '0' i lista. Før kryptering fjerner vi at alle mellomrom
# og alle skilletegn (“!..?”).
#
# Eksempelvis blir både “abc” og ”a!Bc.,” kryptert til [I, I, II, I, I, 0]
#
# Hva blir den krypterte meldingen?

defmodule Luke12 do
	import Enum

	def solve do
		"Your message was received with gratitude! We do not know about you, but Christmas is definitely our favourite holiday. The tree, the lights, all the presents to unwrap. Could there be anything more magical than that?! We wish you a happy holiday and a happy new year!"
		|> String.downcase
		|> to_charlist
		|> filter(&(&1 >= ?a and &1 <= ?z))
		|> encode
		|> concat
		|> map(&(%{ 0 => "0", 1 => "I", 2 => "II", 3 => "III", 4 => "IV", 5 => "V", 6 => "VI", 7 => "VII", 8 => "VIII", 9 => "IX", 10 => "X", 11 => "XI", 12 => "XII", 13 => "XIII" }[&1 - div(?a, 2)]))
		|> join(", ")
	end

	def encode(msg) do [msg |> map(&(round(&1/2))), reverse(msg) |> map(&(div(&1, 2)))] end
end
