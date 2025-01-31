extends CanvasLayer

var inputed_value = "";


func _ready() -> void:
	for child in $ColorRect.get_children():
		child.pressed.connect(_button_pressed.bind(child))


func _process(delta: float) -> void:
	$Label.text = inputed_value;

func _button_pressed(button):
	print(button.text);
	if len(inputed_value) <= 3:
		inputed_value += button.text;


func _on_clear_pressed() -> void:
	inputed_value = "";
