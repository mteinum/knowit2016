# Hvert år greier naboen din å slå deg i årets juledekorasjon. Dette er noe du ikke finner deg i lengre og du har dermed gått
# drastisk til verks og kjøpt inn hundre millioner LED lys som er satt sammen i et 10.000x10.000 rutenett.
#
# Julenissen har vært ganske snill med deg i år, så han har faktisk sendt deg de beste instruksjonene for hvordan å styre
# rutenettet med LED lys. Men hvordan fungerer virkelig dette?
# LEDs i rutenettet ditt er nummerert fra 0 til 9999 i hvert retning, det vil si at hjørnene angis ved:
# 0,0 - øverst til venstre
# 0,9999 - nederst til venstre
# 9999,9999 - nederst til høyre
# 9999,0 - øverst til høyre
# Instruksjonene har tre forskjellige måter å justere lysene på, "turn on", "turn off", "toggle" med koordinater for hvilke
# LEDs som skal endres.
# Dette året skal du vinne konkurransen! For å greie dette trenger du kun å følge instruksjonene til julenissen og gjøre
# det i riktig rekkefølge.
# Eksempler på hver linje av inputs:
# turn on 0,0 through 9999,9999 kommer til å slå på (eller la de stå på) alle lys
# toggle 0,0 through 9999,0 vil veksle første rad med 10000 lys
# turn off 0,0 through 4999,4999 kommer til å slå av (eller la de være av) lysene i det rutenettet
# Obs: Hvert koordinatpar representerer motsatt hjørne av et rektangel, som vil si at et par av koordinater 0,0 til 2,2
# betyr 9 LEDs i et 3x3 firkant. Alle LEDs starter med å være slått av.
# Eksempel på endring av lys:
# Før endring:
# 0,0,0
# 0,0,0
# 0,0,0
# turn on 0,0 through 1,1
# Etter endring:
# 1,1,0
# 1,1,0
# 0,0,0
# Etter å ha fulgt instruksjonene, hvor mange lys er på?
# Input: http://pastebin.com/raw/aTeSBwR4

defmodule Luke13 do
	@width 10000

	def solve do
		commands = read_file

		0 .. @width
		|> Enum.reduce(0, &(process_line(&1, commands) + &2))
	end

	def process_line(line_number, commands) do

		bitmap = :hipe_bifs.bitarray(@width, false)

		commands
		|> Enum.filter(&(command_valid_for_line(&1, line_number)))
		|> Enum.map(&(apply_command(&1, bitmap)))

		0 .. bit_size(bitmap) - 1
		|> Enum.reduce(0, &(count(:hipe_bifs.bitarray_sub(bitmap, &1), &2)))
	end

	def command_valid_for_line({{_, from_y}, {_, to_y}, _}, line_number) do
		line_number >= from_y and line_number <= to_y
	end

	def apply_command({{from_x, _}, {to_x, _}, op}, bitmap) do
		from_x .. to_x |> Enum.each(&(update(bitmap, &1, op)))
	end

	def update(bitmap, index, value) when is_boolean(value) do
		:hipe_bifs.bitarray_update(bitmap, index, value)
	end

	def update(bitmap, index, :toggle) do
		update(bitmap, index, !:hipe_bifs.bitarray_sub(bitmap, index))
	end

	def count(bit, acc) when bit, do: acc + 1
	def count(_, acc), do: acc

	def position([x, y]) do {String.to_integer(x), String.to_integer(y)} end
	def position(s) do position(String.split(s, ",")) end

	def operation("on"), do: true
	def operation("off"), do: false

	def parse_line(["turn", op, from, "through", to]) do {position(from), position(to), operation(op)} end
	def parse_line(["toggle", from, "through", to]) do {position(from), position(to), :toggle} end

	def valid_line({{from_x, from_y}, {to_x, to_y}, _}) do
		to_x > from_x and to_y > from_y
	end

	def read_file do
		File.stream!("./Luke13.txt")
		|> Enum.map(&(String.replace_trailing((&1), "\n", "")))
		|> Enum.map(&(parse_line(String.split(&1, " "))))
		|> Enum.filter(&(valid_line(&1)))
	end
end
