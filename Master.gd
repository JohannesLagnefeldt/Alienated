extends Node

var current_masks : Array[int] = []
var secret_masks : Array[int] = []
var guess : Array[int] = []

func _ready() -> void:
	secret_masks = [1,2,3,4]
	add_guess(2)
	add_guess(2)
	add_guess(3)
	add_guess(4)
	print(try_solve())
	add_guess(1)
	add_guess(2)
	add_guess(3)
	add_guess(4)
	print(try_solve())
	add_guess(3)
	add_guess(3)
	add_guess(3)
	add_guess(3)
	print(try_solve())
	add_guess(2)
	add_guess(2)
	add_guess(3)
	add_guess(4)
	add_guess(6)
	print(try_solve())

func try_solve() -> Vector2:
	var temp = secret_masks.duplicate()
	var solution : Vector2 = Vector2.ZERO
	for i : int in range(temp.size()):
		if temp[i] == guess[i]:
			temp[i] = 0
			solution.x += 1
	
	for j : int in range(temp.size()):
		if temp.has(guess[j]):
			solution.y += 1
	
	guess = []
	return solution
	
func add_guess(new_guess : int):
	print("next step")
	if guess.size() < secret_masks.size():
		guess.push_back(new_guess)
		
func remove_guess():
	guess.pop_back()
