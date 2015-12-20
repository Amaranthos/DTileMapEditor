module camera;

import derelict.sdl2.sdl;

import math.vec2;

class Camera {
private:
	SDL_Rect viewRect;
	Vec2 pos;

public:
	const(SDL_Rect) view() const @property {
		return viewRect;
	}

	const(Vec2) position() const @property {
		return pos;
	}

	void position(Vec2 position) @property {
		pos = position;
	}

	this(SDL_Rect view, Vec2 position) {
		this.viewRect = view;
		this.pos = position;
	}

	~this() {

	}
}