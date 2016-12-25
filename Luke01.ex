# Finn det minste naturlige tallet som ender på 6 og som har følgende egenskap:
# - hvis man fjerner det siste tallet og plasserer det først så blir tallet
# fire ganger så stort som det opprinnelige tallet.

defmodule Luke1 do

	defp rotate_number(n) do
		Integer.undigits([6] ++ Integer.digits(n))
	end

	defp four_times_bigger(n) do
		n * 4
	end

	defp make_number(i) do
		i * 10 + 6
	end

	def solve do
		solve(0)
	end

	defp solve(i) do
		x = make_number(i)

		if rotate_number(i) === four_times_bigger(x) do
			x
		else
			solve(i + 1)
		end
	end
end
