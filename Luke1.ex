defmodule Luke1 do

	defp rotate_number(n) do
		Integer.undigits([6] ++ Integer.digits(n))
	end

	defp qubic(n) do
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

		if rotate_number(i) === qubic(x) do
			x
		else
			solve(i + 1)
		end
	end
end