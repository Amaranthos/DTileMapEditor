module util.rect;

import std.algorithm;

import derelict.sdl2.sdl;

import math.vec2;

public SDL_Rect BuildRect (ref SDL_Rect rect) {
	int x1 = rect.x;
	int y1 = rect.y;
	int x2 = rect.w;
	int y2 = rect.h;

	rect.x = min(x1, x2);
	rect.y = min(y1, y2);

	rect.w = max(x1, x2) - rect.x;
	rect.h = max(y1, y2) - rect.y;

	return rect;
}

public bool MouseOver (SDL_Rect rect, float scale = 1){
	int x, y = 0;
	SDL_GetMouseState(&x, &y);

	if(x < rect.x * cast(int)scale) return false;
	if(x > (rect.x + rect.w) * cast(int)scale) return false;
	if (y < rect.y * cast(int)scale) return false;
	if (y > (rect.y + rect.h) * cast(int)scale) return false;
	
	return true;
}

public bool ContainsPosition(SDL_Rect rect, Vec2 pos, float scale = 1) {
	if(pos.x < rect.x * cast(int)scale) return false;
	if(pos.x > (rect.x + rect.w) * cast(int)scale) return false;
	if (pos.y < rect.y * cast(int)scale) return false;
	if (pos.y > (rect.y + rect.h) * cast(int)scale) return false;
	
	return true;
}

public bool ContainsRect(SDL_Rect a, SDL_Rect b, float scale = 1) {
	if ((a.y + a.h) * cast(int)scale <= b.y * cast(int)scale) return false;
	if (a.y * cast(int)scale >= (b.y + b.h) * cast(int)scale) return false;
	if ((a.x + a.w) * cast(int)scale <= b.x * cast(int)scale) return false;
	if (a.x * cast(int)scale >= (b.x + b.w) * cast(int)scale) return false;

	return true;
}