# Vi har en rekke rektangler som er definert ved punkter i et kartesiansk koordinatsystem (dvs X og Y akse). Hvert rektangel er definert ved en liste med fire heltall. De to første tallene i lista representerer henholdsvis X og Y koordinatene for hjørnet nederst til venstre i rektangelet, mens de to siste tallene i lista representerer koordinatene til hjørnet øverst til høyre. Sidene i rektangelet er altså parallelle med X og Y aksene. 
#
# Gitt lista [1,2,3,4] Har man altså et rektangel med følgende hjørner:
#
# Nederst til venstre: (1,2)
# Nederst til høyre: (3,2)
# Øverst til venstre: (1,4)
# Øverst til høyre: (3,4)
#
# Om vi har n slike rektangler, der n >= 0, i samme koordinatsystem, og disse til sammen "overlapper"(dekker perfekt området, ikke som i at rektangler er oppe på hverandre) til å danne nøyaktig ett nytt rektangel (uten hull), sier vi at rektanglene utgjør en rektangelregion.

defmodule Luke22 do

	def rect_contains_point({a,b},{x1,y1,x2,y2}) do
		a > x1 and a <= x2 and
		b > y1 and b <= y2
	end

	def contains_point({x,y} = pt, arr) do
		1 == Enum.count(arr, fn(rect)->rect_contains_point(pt, rect) end)
	end

	def is_rectangle_region(arr) do

		rectangles = Enum.map(arr, fn(rect)->List.to_tuple(rect) end)

		if (Enum.count(rectangles) < 2) do
			true
		else
			{min_x,_,_,_} = Enum.min_by(rectangles, fn({x,_,_,_})->x end)
			{_,min_y,_,_} = Enum.min_by(rectangles, fn({_,y,_,_})->y end)
			{_,_,max_x,_} = Enum.max_by(rectangles, fn({_,_,x,_})->x end)
			{_,_,_,max_y} = Enum.max_by(rectangles, fn({_,_,_,y})->y end)

			width = max_x - min_x
			height = max_y - min_y

			min_x + 1 .. min_x + width 
			|> Enum.map(fn(x) ->
				min_y + 1 .. min_y + height
				|> Enum.map(fn(y)-> contains_point({x , y}, rectangles) end)
			end)
			|> List.flatten
			|> Enum.all?(fn(b)->b end)
		end
	end

	def test do
		[true, false] = [
  		[
		    [1,1,3,3],
		    [1,3,3,4]
		  ],
		  [
		    [1,1,3,3],
		    [3,1,4,2],
		    [1,3,2,4],
		    [2,3,3,4]
		  ]
		]
		|> Enum.map(&(is_rectangle_region(&1)))

	end

	def solve do
		content = [
		[
			[0,0,4,1],
			[7,0,8,2],
			[6,2,8,3],
			[5,1,6,3],
			[4,0,5,1],
			[6,0,7,2],
			[4,2,5,3],
			[2,1,4,3],
			[0,1,2,2],
			[0,2,2,3],
			[4,1,5,2],
			[5,0,6,1]
		],
		[
			[0,0,4,1],
			[7,0,8,2],
			[6,2,8,3],
			[5,1,6,3],
			[4,0,5,1],
			[6,0,7,2],
			[4,2,5,3],
			[2,1,4,3],
			[0,1,2,2],
			[0,2,2,3],
			[4,1,5,2],
			[5,0,6,1]
		],
		[
			[1,1,3,3],
			[3,1,4,2],
			[1,3,2,4],
			[2,3,3,4]
		],
		[
			[0,0,4,1],
			[7,0,8,2],
			[5,1,6,4],
			[6,0,7,2],
			[4,0,5,1],
			[4,2,5,3],
			[2,1,4,3],
			[0,2,2,3],
			[0,1,2,2],
			[6,2,8,3],
			[5,0,6,1],
			[4,1,5,2]
		],
		[
			[0,0,4,1],
			[0,0,4,1]
		],
		[
			[0,0,4,1],
			[7,0,8,2],
			[5,1,6,3],
			[6,0,7,2],
			[2,1,4,3],
			[0,2,2,3],
			[0,1,2,2],
			[6,2,8,3],
			[5,0,6,1]
		],
		[
			[0,0,1,1],
			[1,0,2,1],
			[1,0,3,1],
			[3,0,4,1]
		],
		[
			[0,0,4,1]
		],
		[
			[0,0,1,1],
			[0,1,1,2],
			[0,2,1,3],
			[0,3,1,4]
		],
		[
			[0,0,4,1],
			[7,0,8,2],
			[6,2,8,3],
			[5,1,6,3],
			[6,0,7,2],
			[4,2,5,3],
			[2,1,4,3],
			[0,1,2,2],
			[0,2,2,3],
			[4,1,5,2],
			[5,0,6,1]
		],
		[
			[0,0,4,1],
			[7,0,8,2],
			[5,1,6,3],
			[6,0,7,2],
			[4,0,5,1],
			[4,2,5,3],
			[2,1,4,3],
			[-1,2,2,3],
			[0,1,2,2],
			[6,2,8,3],
			[5,0,6,1],
			[4,1,5,2]
		],
		[
			[0,0,5,1],
			[7,0,8,2],
			[5,1,6,3],
			[6,0,7,2],
			[4,0,5,1],
			[4,2,5,3],
			[2,1,4,3],
			[0,2,2,3],
			[0,1,2,2],
			[6,2,8,3],
			[5,0,6,1],
			[4,1,5,2]
		],
		[],
		[
			[0,0,1,1],
			[1,0,2,1],
			[2,0,3,1],
			[3,0,4,1]
		],
		[
			[0,0,4,1],
			[7,0,8,3],
			[5,1,6,3],
			[6,0,7,2],
			[4,0,5,1],
			[4,2,5,3],
			[2,1,4,3],
			[0,2,2,3],
			[0,1,2,2],
			[6,2,8,3],
			[5,0,6,1],
			[4,1,5,2]
		]
		]
			content
			|> Enum.map(&(is_rectangle_region(&1)))
			|> Enum.join(",")
	end
end