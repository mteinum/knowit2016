# I regnearkprogrammer er ofte kolonner angitt ved strenger bestående av bokstavene A til Z. Kolonnenummer 1 er angitt med bokstaven A, 2 er B osv. Flere, og mer komplekse eksempler:
# 1 -> A
# 2 -> B
# 3 -> C
# …
# 26 -> Z
# 27 -> AA
# 28 -> AB
# ...
# 52 -> AZ
# 53 -> BA
# ...
# 79 -> CA

Hva blir kolonnetittelen på kolonne nummer 90101894?

defmodule Luke24 do

	def column_name(0, acc), do: acc
	def column_name(n, acc) do
	  column_name(div(n-1, 26), [?A + rem(n-1, 26)] ++ acc)
	end
	def column_name(n), do: column_name(n, [])

	def solve do
		'A' = column_name(1)
		'B' = column_name(2)
		'C' = column_name(3)		
		'Z' = column_name(26)
		'AA' = column_name(27)
		'AB' = column_name(28)
		'AZ' = column_name(52)
		'CA' = column_name(79)
		column_name(90101894)
	end
end