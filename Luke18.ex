# Du befinner deg i et rom der den eneste lyskilden er en gammel digital vekkerklokke (det er ingenting annet som gir lys i rommet enn denne). Sifrene på vekkerklokka er LEDs organisert i et såkalt 7-segments display. Klokkevisningen er på formatet hh:mm:ss, og er konfigurert opp til å vise klokkeslettet i 24 timersformat. Det første sifferet i timevisningen er blankt om tallet på timeplassen er mindre enn 10.
# Anta at alle LEDene bidrar like mye til lysstyrken i rommet. Hvor lang tid går det fra rommet er på sitt mørkeste til det er på sitt lyseste? Svaret oppgis på formatet hh:mm:ss.
# Eksempel: Tar dette 3 timer og 15 minutter og 3 sekunder blir svaret 03:15:03

defmodule Luke18 do
	def leds(digits) do
		digits
		|> Enum.map(fn(x) ->
			%{ 0=>6, 1=>2, 2=>5, 3=>5, 4=>4, 5=>5, 6=>6, 7=>3, 8=>7, 9=>6 }[x]
		end)
		|> Enum.sum
	end

	def h_to_leds(n), do: leds(Integer.digits(n))
	def ms_to_leds(n) when n < 10, do: leds([0, n])
	def ms_to_leds(n), do: n |> Integer.digits |> leds
	def time_to_leds({h,m,s}), do: h_to_leds(h) + ms_to_leds(m) + ms_to_leds(s)

	def solve do
		0..86399
		|> Enum.map(fn(x)-> {x, :calendar.seconds_to_time(x)} end)
		|> Enum.map(fn({sec, time})-> {sec, time_to_leds(time)} end)
		|> Enum.min_max_by(fn({_s, led_count})-> led_count end)
		|> (fn({{sec_min, _}, {sec_max, _}}) ->
			:calendar.seconds_to_time(sec_max - sec_min)
		end).()
	end
end