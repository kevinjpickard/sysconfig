function beer_song --description 'Makes me sing 99 Bottles of Beer. Cuz I love beer.'
	for quant in (seq 99 -1 1)
		if math "$quant > 1" > /dev/null
			echo "$quant bottles of beer on the wall, $quant bottles of beer."
				if math "$quant > 2" > /dev/null
					set suffix (math "$quant - 1")
					set suffix "$suffix bottles of beer on the wall."
				else
					set suffix "1 bottle of beer on the wall."
				end
			else if math "$quant == 1" > /dev/null
				echo "1 bottle of beer on the wall, 1 bottle of beer."
				set suffix "no more beer on the wall!"
			end
		echo "Take one down, pass it around, $suffix"
		echo "--"
	end
end

