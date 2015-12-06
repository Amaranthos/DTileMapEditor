module util.window;

import std.stdio;
import std.string : toStringz;
import std.conv : to;

import derelict.sdl2.sdl;

import util.colour;
import util.log;

class Window {
	//Member variables
private:
	SDL_Window* window;
	SDL_Renderer* renderer;
	int windowID;
	int displayID;
	
	int width;
	int height;
	string name;
	Colour clear;

	bool mouseFocus;
	bool keyboardFocus;
	bool fullscreen;
	bool minimized;
	bool shown;

public:
	public this() {
		window = null;
		renderer = null;
		mouseFocus = false;
		keyboardFocus = false;
		fullscreen = false;
		minimized = false;
		width = 0;
		height = 0;
		clear = Colour(0,0,0);
	}

	public ~this() {
		Free();
	}

	public bool Init(int width, int height, const string name, const Colour clear) {
		window = SDL_CreateWindow(name.toStringz, SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, width, height, SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE);


		if(window) {
			Log(Level.success, "SDL window '", name, "' created!");
			mouseFocus = true;
			keyboardFocus = true;
			this.width = width;
			this.height = height;
			this.name = name;
			this.clear = clear;

			renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

			if(renderer) {
				Log(Level.success, "SDL renderer created from window '", name, "'!");
				SDL_SetRenderDrawColor(renderer, clear.r, clear.g, clear.b, clear.a);
				windowID = SDL_GetWindowID(window);
				displayID = SDL_GetWindowDisplayIndex(window);
				shown = true;
			}
			else {
				Log(Level.error, "SDL render could not be created from window '", name, "'! SDL Error: ", SDL_GetError());
				Free();
			}
		}
		else {
			Log(Level.error, "SDL window '", name, "' could not be created! SDL Error: ", SDL_GetError());
		}

		return !!window && !!renderer;
	}

	public void HandleEvent(ref SDL_Event e){
		if(e.type == SDL_WINDOWEVENT && e.window.windowID == windowID) {
			bool updateCaption = false;

			switch(e.window.event) {
				case SDL_WINDOWEVENT_MOVED:
					displayID = SDL_GetWindowDisplayIndex(window);
					updateCaption = true;
					break;

				case SDL_WINDOWEVENT_SHOWN:
					shown = true;
					break;

				case SDL_WINDOWEVENT_HIDDEN:
					shown = false;
					break;

				case SDL_WINDOWEVENT_SIZE_CHANGED:
					width = e.window.data1;
					height = e.window.data2;
					SDL_RenderPresent(renderer);
					break;

				case SDL_WINDOWEVENT_EXPOSED:
					SDL_RenderPresent(renderer);
					break;

				case SDL_WINDOWEVENT_ENTER:
					mouseFocus = true;
					updateCaption = true;
					break;

				case SDL_WINDOWEVENT_LEAVE:
					mouseFocus = false;
					updateCaption = true;
					break;

				case SDL_WINDOWEVENT_FOCUS_GAINED:
					keyboardFocus = true;
					updateCaption = true;
					break;

				case SDL_WINDOWEVENT_FOCUS_LOST:
					keyboardFocus = false;
					updateCaption = true;
					break;

				case SDL_WINDOWEVENT_MINIMIZED:
					minimized = true;
					break;

				case SDL_WINDOWEVENT_MAXIMIZED:
					minimized = false;
					break;

				case SDL_WINDOWEVENT_RESTORED:
					minimized = false;
					break;

				case SDL_WINDOWEVENT_CLOSE:
					SDL_HideWindow(window);
					break;

				default:
					break;
			}

			if(updateCaption) {
				string caption;
				caption ~= name ~ "- Window: " ~ to!string(windowID) ~ " Display: " ~ to!string(displayID) ~ " Mouse Focus: " ~ ((mouseFocus)? "On" : "Off") ~ " Keyboard Focus: " ~ ((keyboardFocus) ? "On" : "Off");
				SDL_SetWindowTitle(window, caption.toStringz);
			}
		}
		else if(e.type == SDL_KEYDOWN && e.key.keysym.sym == SDLK_F11) {
			if(fullscreen) {
				SDL_SetWindowFullscreen(window, SDL_FALSE);
				fullscreen = false;
			}
			else{
				SDL_SetWindowFullscreen(window, SDL_TRUE);
				fullscreen = true;
				minimized = false;
			}
		}
	}

	public void Clear() {
		if(!minimized) {
			SDL_SetRenderDrawColor(renderer, clear.r, clear.g, clear.b, clear.a);
			SDL_RenderClear(renderer);
		}
	}

	public void Render() {
		if(!minimized) SDL_RenderPresent(renderer);
	}

	public void Focus() {
		if(!shown) SDL_ShowWindow(window);
		SDL_RaiseWindow(window);
	}

	public void Free() {
		if(renderer) SDL_DestroyRenderer(renderer);
		if(window) SDL_DestroyWindow(window);

		renderer = null;
		window = null;

		mouseFocus = false;
		keyboardFocus = false;
		width = 0;
		height = 0;
	}

	public void SetSize(int x, int y) {
		SDL_SetWindowSize(window, x, y);
	}

	public SDL_Window* Inst() @property {
		return window;
	}

	public SDL_Renderer* Renderer() @property {
		return renderer;
	}

	public int Width() const @property {
		return width;
	}

	public int Height() const @property{
		return height;
	}

	public bool HasMouseFocus() const @property {
		return mouseFocus;
	}

	public bool HasKeyboardFocus() const @property {
		return keyboardFocus;
	}

	public bool IsMinimized() const @property {
		return minimized;
	}

	public bool IsShown() const @property {
		return shown;
	}
}