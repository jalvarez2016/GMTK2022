#enable text color menu to adjust text color when playing scene
extends RichTextLabel

export(Color,RGB) var text_color

func _ready():
	set_modulate(text_color)
	pass # Replace with function body.
