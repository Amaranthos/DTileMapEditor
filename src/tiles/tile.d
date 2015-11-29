module tiles.tile;

import std.stdio;

import derelict.sdl2.sdl;

import textures;
import math.vec2;
import app;
import window;

class Tile {
private:
	Texture texture_;
	SDL_Rect tile_;
	Vec2 pos;

public:
	this(SDL_Rect tile, Texture texture) {
		tile_ = tile;
		texture_ = texture;
	}

	~this() {

	}

	const(Texture) texture() const @property{
		return texture_;
	}

	const(Vec2) position() const @property{
		return pos;
	}

	const(int) width() const @property {
		return tile_.w;
	}

	const(int) height() const @property {
		return tile_.h;
	}

	void position(Vec2 position) @property{
		pos = position;
	}

	void Draw(Window window, float scale = 1) {
		if(true){ //Check on screen, when camera is implemented
			SDL_RenderSetScale(window.Renderer, scale, scale);
			texture_.Render(cast(int)pos.x, cast(int)pos.y, App.Inst.AppWindow, &tile_);
			SDL_RenderSetScale(window.Renderer, 1, 1);
		}
	}
}