# I en fantasiverden skal en Trollmann, en Kriger, en Prest og en Tyv kjempe seg igjennom noen farlige tuneller og rom der en goblin-klan holder 17 mennesker fanget. Eventyrerene skal igjennom 100 rom før de finner fangene. I hvert rom må de nedkjempe eller snike seg forbi onde goblins. Det er like mange goblins i hvert rom som nummeret på rommet. Så i det første rommet er det en goblin, i det neste 2, osv frem til og med rom 100 der det er 100 goblins. Når de har kommet forbi rom 100 kan de befri fangene. I hvert rom går kampen i runder frem til det ikke er noen goblins igjen, etter følgende regler (i rekkefølge):
#
# Hvis Tyven er i live og det er goblins igjen i dette rommet, dreper han 1 goblin.
# Hvis Trollmannen er i live og det er goblins igjen i dette rommet, dreper han (opptil) 10 goblins.
# Hvis Krigeren er i live og det er goblins igjen i dette rommet, dreper han 1 goblin.
# Hvis Presten er i live og en annen eventyrer ikke er det, gjenoppliver presten en av de som ikke er i live. Hvis det er flere som ikke er i live velger han først Krigeren, så Trollmannen. Tyven vil han ikke gjenopplive, han har syndet for mye. Presten kan gjøre dette maks en gang per rom, og han kan ikke gjenopplive eventyrere som ble forlatt døde i et tidligere rom.
# Hvis Tyven er den eneste som er i live, sniker han seg videre (til neste rom eller til fangene hvis dette er rom 100), og ignorerer de goblinene som var igjen i dette rommet. Goblinene som var igjen i rommet leter etter ham, men går seg bort i tunellene og starter et nytt og bedre liv et annet sted.
# Hvis det fremdeles er både eventyrere og goblins i rommet, og det er minst 10 ganger flere goblins enn eventyrerene som er igjen, så dreper goblinene en av eventyrerene. De dreper først Krigeren om han er i live, deretter Trollmannen, så Presten. Tyven finner de ikke.
# Hvis det fremdeles er både eventyrere og goblins i rommet, gå til punkt 1 (ny runde i samme rom). Hvis ikke, gå til neste rom og start en runde - med mindre dette var det siste rommet, i hvilket tilfelle de resterende eventyrerene finner fangene og befrir dem.
# Hvor mange overlevde historien?

defmodule Luke10 do


	def is_alive(map, who) do map[who] == true end
	def is_dead(map, who) do map[who] == false end
	def has_been_risen(map, who) do map[who] == true end
	def arise({goblins_in_room, adventurers, resurrection, goblins_alive}, who) do
		{goblins_in_room, Map.put(adventurers, who, true), Map.put(resurrection, who, true), goblins_alive }
	end
	def can_arise({_goblins, adventurers, resurrection, _goblins_alive}, who) do
		is_alive(adventurers, :priest) and
		is_dead(adventurers, who) and
		has_been_risen(resurrection, who) == false
	end

	def kill_if_alive(state = {goblins_in_room, adventurers, resurrection, goblins_alive}, who, numbers) do
		if is_alive(adventurers, who) and goblins_in_room > 0 do
			{max(goblins_in_room - numbers, 0), adventurers, resurrection, goblins_alive}
		else
			state
		end
	end

	def kill_adventurer({goblins_in_room, adventurers, resurrection, goblins_alive}, who) do
		{goblins_in_room, Map.put(adventurers, who, false), resurrection, goblins_alive}
	end

	def thief_step(state) do kill_if_alive(state, :thief, 1) end
	def magician_step(state) do kill_if_alive(state, :magician, 10) end
	def warrier_step(state) do kill_if_alive(state, :warrier, 1) end

	def priest_step(state) do
		cond do
			can_arise(state, :warrier) -> arise(state, :warrier)
			can_arise(state, :magician) -> arise(state, :magician)
			true -> state
		end
	end

	def thief_alone_step(state = {goblins_in_room, adventurers, resurrection, goblins_alive}) do
		if count_alive_adventurers(adventurers) == 1 do
		     {0, adventurers, resurrection, goblins_alive + goblins_in_room}
		else
			state
		end
	end

	def count_alive_adventurers(adventurers) do
		Enum.count(adventurers, fn(x) -> elem(x, 1) end)
	end

	def ten_times_more(alive_count, goblins_in_room) do
		goblins_in_room >= alive_count * 10
	end

	def goblins_step(state = {goblins_in_room, adventurers, _resurrection, _goblins_alive}) do
		alive_count = count_alive_adventurers(adventurers)

		cond do
			ten_times_more(alive_count, goblins_in_room) == false -> state
			is_alive(adventurers, :warrier) -> kill_adventurer(state, :warrier)
			is_alive(adventurers, :magician) -> kill_adventurer(state, :magician)
			is_alive(adventurers, :priest) -> kill_adventurer(state, :priest)
			true -> state
		end
	end

	def next_round(room, state = {goblins_in_room, adventurers, _resurrection, goblins_alive}) do

		if goblins_in_room == 0 do
			to_remove = Enum.filter(adventurers, fn(x) -> elem(x, 1) == false end)
			|> Enum.map(fn(x) -> elem(x, 0) end)

			new_round(room + 1, Map.drop(adventurers, to_remove), goblins_alive)
		else
			round(room, state)
		end
	end

	def round(room, state) do

		new_state = state
		|> thief_step
		|> magician_step
		|> warrier_step
		|> priest_step
		|> thief_alone_step
		|> goblins_step

		next_round(room, new_state)
	end

	def new_round(room, adventurers, goblins_alive) do
		IO.puts("=== ROOM #{room} goblins_alive: #{goblins_alive} ===")
		IO.inspect(adventurers)

		if room > 100 do
			{adventurers, goblins_alive, count_alive_adventurers(adventurers)}
		else
			round(room, {room, adventurers, %{}, goblins_alive})
		end
	end

	def solve do
		
		adventurers = %{:magician => true, :warrier => true, :priest => true, :thief => true}

		{_, goblins_alive, adventurers_alive} = new_round(1, adventurers, 0)

		IO.puts("adventurers_alive: #{adventurers_alive}, goblins_alive: #{goblins_alive}, total: #{adventurers_alive+goblins_alive+17}")
	end
end