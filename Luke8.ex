defmodule Luke8 do

 	def handle_draw({current, draw}) when current + draw > 90 do current end
	def handle_draw({current, draw}) do current + draw end 

	def handle_latter(position, latter) when latter == nil do position end
	def handle_latter(_, latter) do latter end

	def count_latter(e) do Enum.count(e, fn({_, latter}) -> latter end) end
	def count_latter(winner, e) when winner == nil do count_latter(e) end
	def count_latter(winner, e) do count_latter(Enum.take(e, winner + 1)) end

	def handle_round(lattercount, game) do

		latters = %{3=>17, 8=>10, 15=>44, 22=>5, 39=>56, 49=>75, 62=>45, 64=>19, 65=>73, 80=>12, 87=>79}

		f = Enum.map(game, fn(player) ->
			position_after_draw = handle_draw(player)
			position_after_latter = handle_latter(position_after_draw, latters[position_after_draw])

			{position_after_latter, latters[position_after_draw] != nil}
		end)

		winner = Enum.find_index(f, fn({position, _}) -> position == 90 end)

		partial_latter_count = count_latter(winner, f)

		if winner do
			{:halt, {lattercount + partial_latter_count, winner + 1}}
		else
			{:cont, {lattercount + partial_latter_count, Enum.map(f, fn({posision, _}) -> posision end) }}
		end

	end

	def create_list_of(n) do Enum.map(1..1337, fn(_) -> n end) end

	def solve_game do
		start = {0, create_list_of(1)}

		{latters, winner} = read_game
		|> Enum.reduce_while(start, fn(x, {lattercount, game}) ->
			handle_round(lattercount, Enum.zip(game, x))
		end)

		latters * winner

	end

	def read_game do
		File.stream!("./Luke8.txt")
		|> Enum.map(&(String.replace_trailing((&1), "\n", "")))
		|> Enum.map(&(String.to_integer((&1))))
		|> Enum.chunk(1337, 1337, create_list_of(0))
	end
end
