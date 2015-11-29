module textures.manager;

import std.stdio;
import std.string;

import derelict.sdl2.sdl;

import app;
import textures.texture;

class TextureManager {
	private Texture[string] textures;

public:
	this() {

	}

	~this() {
		RemoveAll();
	}

	Texture Get (string name) {
		if(name in textures)
			return textures[name];
		else {
			Texture texture = new Texture();

			if(!(texture.LoadFromFile(name, App.Inst.AppWindow))){
				
				delete texture;
			}

			textures[name] = texture;

			
			return texture;
		}
	}

	void RemoveAll() {
		foreach(texture; textures.keys){
			textures.remove(texture);
		}		
	}
}