extends Sprite

func _process(delta):
	var mpos = get_global_mouse_position()
	var ang = (get_global_mouse_position() - self.get_global_position()).angle()

	look_at(mpos)

	print(rad2deg(ang))

	if (ang >= 90):
		elf.set_flip_h(false)
		self.set_flip_v(false)
	elif (ang >= -90):
		self.set_flip_h(true)
		self.set_flip_v(true)
