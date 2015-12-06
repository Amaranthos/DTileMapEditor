module tiles.manager;

//import std.stdio;
//import std.string;
//import std.file;
//import std.xml;
//import std.conv;

//import derelict.sdl2.sdl;

//import app;
//import tiles.tile;
//import textures.texture;
//import math.vec2;
//import ui.button;

//class TileManager {
//	private Tile*[string] tiles;	

//public:
//	this() {

//	}

//	~this() {
//		RemoveAll();
//	}

//	void LoadTileset(string path) {
//		RemoveAll();

//		if(path != ""){
//			auto content = cast(string) read(path);

//			if(content != ""){

//				check(content);

//				auto xml = new DocumentParser(content);
				
//				xml.onStartTag["image"] = (ElementParser xml) {
//					Texture texture = App.Inst.TextureMan.Get(xml.tag.attr["path"]);
					
//					SDL_Rect tile = SDL_Rect();
//					string name;
//					tile.w = to!int(xml.tag.attr["tilesize"]);
//					tile.h = to!int(xml.tag.attr["tilesize"]);

//					xml.onStartTag["tile"] = (ElementParser e){
//						tile.x = to!int(e.tag.attr["x"]) * tile.w;
//						tile.y = to!int(e.tag.attr["y"]) * tile.h;

//						Add(new Tile(tile, texture, e.tag.attr["name"]), e.tag.attr["name"]);
//					};
//					xml.parse();
//				};
//				xml.parse();

//			}
//			else writeln("Warning! Could not read file: ", path);
//		}
//		else writeln("Warning! Invalid path");
//	}

//	void Add(Tile* tile, string name) {
//		tiles[name] = tile;
//	}

//	Tile* Get(string name){
//		return tiles[name];
//	}

//	void RemoveAll(){
//		foreach(tile; tiles.keys){
//			tiles.remove(tile);
//		}
//	}

//	Button[] CreateButtons(int startX, int startY, int padX, int padY, bool incrX, bool incrY) {
//		Button[] ret;
		
//		int x = 0;
//		int y = 0;

//		foreach(tile; tiles.keys){
//			auto b =  new Button();
//			b.position = SDL_Rect(startX + x * (tiles[tile].width + padX), startY + y * (tiles[tile].height + padY), tiles[tile].width, tiles[tile].height);
//			b.SetTile(tile);
//			ret ~= b;

//			if(incrX){
//				x++;
//			}
//			if(incrY){
//				y++;
//			}
//		}

//		return ret;
//	}
//}