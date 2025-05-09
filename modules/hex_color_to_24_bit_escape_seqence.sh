hex() {
	hex_to_dec() {
		printf "%d" "$((16#$1))"
	}

	# Hex color code
	hex_color="$1"

	# Split hex into R, G, B components (remove the #)
	red_hex="${hex_color:1:2}"
	green_hex="${hex_color:3:2}"
	blue_hex="${hex_color:5:2}"

	# Convert hex to decimal
	red_dec=$(hex_to_dec "$red_hex")
	green_dec=$(hex_to_dec "$green_hex")
	blue_dec=$(hex_to_dec "$blue_hex")

	# Set foreground color using 24-bit ANSI escape sequence
	printf "\e[38;2;%s;%s;%sm" "$red_dec" "$green_dec" "$blue_dec"
}
