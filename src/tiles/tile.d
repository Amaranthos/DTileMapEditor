module tiles.tile;

import std.stdio;

import derelict.sdl2.sdl;

import textures;
import math.vec2;
import app;
import window;

class Tile {
private:
	Texture img;
	SDL_Rect tile_;
	Vec2 pos;
	string name_;

public:
	this(SDL_Rect tile, Texture texture, string name) {
		this.tile_ = tile;
		this.img = texture;
		this.name_ = name;
	}

	~this() {

	}

	const(Texture) texture() const @property{
		return img;
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

	const(string) name() const @property {
		return name_;
	}

	void position(Vec2 position) @property{
		pos = position;
	}

	void Draw(Window window, float scale = 1) {
		if(true){ //Check on screen, when camera is implemented
			SDL_RenderSetScale(window.Renderer, scale, scale);
			img.Render(cast(int)pos.x, cast(int)pos.y, App.Inst.AppWindow, &tile_);
			SDL_RenderSetScale(window.Renderer, 1, 1);
		}
	}
}