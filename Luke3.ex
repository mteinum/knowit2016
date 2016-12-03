
defmodule Luke3 do

	def have_relation(relations, relation, name) do
		relations
		|> Enum.filter(fn({a, _}) -> a == relation end)
		|> Enum.any?(fn({_, person}) -> person == name end)
	end
 
	def is_friend(relations, name) do
		have_relation(relations, :friend, name)
	end

	def do_hate(relations, name) do
		have_relation(relations, :hate, name)
	end

	def chameleon_count(name, relations, data) do
		
		relations
		 # finn person som denne har en relasjon til
		|> Enum.map(fn({_, other}) -> other end)
		|> Enum.uniq
		 # vi ser på de relasjonene som hates
		|> Enum.filter(fn(other) -> do_hate(relations, other) end)
		 # finn den andre personen
		|> Enum.map(fn(other) -> {other, Map.get(data, other)} end)
		 # den andre hater ikke denne
		|> Enum.filter(fn({_, otherRelations}) ->
				not do_hate(otherRelations, name)
			end)
		# de er venner
		|> Enum.filter(fn({other, otherRelations}) ->
				is_friend(relations, other) or
				is_friend(otherRelations, name)
			end)
		|> Enum.count
	end



	def parse_file do
		File.stream!("./Luke3.txt")
		|> Enum.map(&(String.replace_trailing((&1), "\n", "")))
		|> Enum.map(
			fn line -> 
				[a, b, c] = String.split(line, " ", trim: true)

				case {a, b, c} do
					{"friends", b, c} -> [:friend, b, c]
					{a, "hates", c} -> [:hate, a, c]
				end
			end
			)
		|> Enum.to_list
	end

	def solve do

		data = parse_file()
		|> Enum.group_by(fn([_, x, _]) -> x end, fn([a, _, y]) -> { a, y } end)

		data
		|> Enum.map(fn({name, relations}) ->
			{name, chameleon_count(name, relations, data)}
		end)
		|> Enum.max_by(fn({_, count}) -> count end)
		
	end

end