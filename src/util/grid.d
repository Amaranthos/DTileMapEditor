module util.grid;

import std.stdio;

import util.log;

public class Grid(T) {
private:
	T[] grid_;
	uint col;
	uint row;
	uint bucketSize;

public:
		
	T[] grid() @property {
		return grid_;
	}

	const(int) cols() const @property {
		return col;
	}

	const(int) rows() const @property {
		return row;
	}

	this(uint col, uint row, uint bucketSize) {
		this.col = col;
		this.row = row;
		this.bucketSize = bucketSize;

		for(uint i = 0; i < col * row; i++){
			grid_ ~= T.init;
		}
	}

	void Set(T element, uint x, uint y){
		if(x < col && y < row){
			grid_[x + y * col] = element;
		}
		else {
			Log(Level.warning, "Grid index out of range!");
		}
	}
}