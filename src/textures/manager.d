module textures.manager;

import std.stdio;
import std.string;

import derelict.sdl2.sdl;

import app;
import textures.texture;

class TextureManager {
	private Texture[string] textures;

	public this() {

	}

	public ~this() {
		RemoveAll();
	}

	public Texture Get (string name) {
		if(name in textures)
			return textures[name];
		else {
			Texture texture = new Texture();

			if(!(texture.LoadFromFile(name, App.Inst.GetWindow))){
				
				delete texture;
			}

			textures[name] = texture;

			
			return texture;
		}
	}

	public void RemoveAll() {
		foreach(texture; textures.keys){
			textures.remove(texture);
		}		
	}
}