module tiles.manager;

import std.stdio;
import std.string;
import std.file;
import std.xml;
import std.conv;

import derelict.sdl2.sdl;

import app;
import tiles.tile;
import textures.texture;
import math.vec2;

class TileManager {
	private Tile[string] tiles;	

	public this() {

	}

	public ~this() {
		RemoveAll();
	}

	public void LoadTileset(string path) {
		RemoveAll();

		if(path != ""){
			auto content = cast(string) read(path);

			if(content != ""){

				check(content);

				auto xml = new DocumentParser(content);
				
				xml.onStartTag["image"] = (ElementParser xml) {
					Texture texture = App.Inst.TextureMan.Get(xml.tag.attr["path"]);
					
					SDL_Rect tile = SDL_Rect();
					string name;
					tile.w = to!int(xml.tag.attr["tilesize"]);
					tile.h = to!int(xml.tag.attr["tilesize"]);

					xml.onStartTag["tile"] = (ElementParser e){
						tile.x = to!int(e.tag.attr["x"]);
						tile.y = to!int(e.tag.attr["y"]);

						Add(new Tile(tile, texture), e.tag.attr["name"]);
					};
					xml.parse();
				};
				xml.parse();

			}
			else writeln("Warning! Could not read file: ", path);
		}
		else writeln("Warning! Invalid path");
	}

	public void Add(Tile tile, string name) {
		tiles[name] = tile;
	}

	public Tile Get(string name){
		return tiles[name];
	}

	public void RemoveAll(){
		foreach(tile; tiles.keys){
			tiles.remove(tile);
		}
	}
}