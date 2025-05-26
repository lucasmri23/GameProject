function tilemap_autotile(_map, _cx, _cy, _addTile, _fill_edges = false) 
{
                
    // _map     : The tilemap id
    // _cx, _cy : The cell x/y of the tile (not room x/y)
    // _addTile : sets tile empty or not (true/false)
                
    // Set (cx, cy) 
    tilemap_set(_map, _addTile, _cx, _cy);
 
    var _row = _cx + 2, _col = _cy + 2;
    _cx--;
    _cy--;
    
    var _gw = tilemap_get_width(_map) - 1 ,
        _gh = tilemap_get_height(_map) - 1;
    
    // Set mask for 3x3 area centered on (cx, cy)
    for (var _tx = _cx, _mask = 0; _tx < _row; _tx++)
        for (var _ty = _cy; _ty < _col; _ty++)
        {       
            if tilemap_get(_map, _tx, _ty) { 
                // The mask consists of powers of 2, so take advantage of bitwise
                        
                var _e  = tilemap_get(_map, _tx+1, _ty)   > 0,
                    _ne = tilemap_get(_map, _tx+1, _ty-1) > 0,
                    _n  = tilemap_get(_map, _tx,   _ty-1) > 0, 
                    _nw = tilemap_get(_map, _tx-1, _ty-1) > 0, 
                    _w  = tilemap_get(_map, _tx-1, _ty)   > 0, 
                    _sw = tilemap_get(_map, _tx-1, _ty+1) > 0, 
                    _s  = tilemap_get(_map, _tx,   _ty+1) > 0, 
                    _se = tilemap_get(_map, _tx+1, _ty+1) > 0; 
                        
                if (_fill_edges)
                {
                    // Treat edges outside of the tilemap as if they contain tiles
                    var _top   = _ty - 1 < 0,
                        _bot   = _ty + 1 > _gh,
                        _left  = _tx - 1 < 0 ,
                        _right = _tx > _gw;
                        
                    _n  |= _top;
                    _s  |= _bot;
                    _e  |= _right;
                    _w  |= _left;
                    _nw |= _left || _top;
                    _sw |= _left || _bot;
                    _ne |= _right || _top;
                    _se |= _right || _bot;
                }
                    
                _mask = 0                  // = 0
                    + (_w << 3)            // + 8
                    + (_e << 4);           // + 16
                
                if (_n) _mask = _mask | 2  // OR 2
                    + (_nw && _w)          // +  1
                    + ((_ne && _e) << 2);  // +  4
                
                if (_s) _mask = _mask | 64 // OR 64
                    + ((_sw && _w) << 5)   // +  32
                    + ((_se && _e) << 7);  // + 128
                    
            } else _mask = -1;
            
            // Large switch of constants is a jump-table of O(1) at runtime no worries 
switch _mask 
{
    case 255: _mask = 1; break; // Cheio (completamente cercado)
    case 254: _mask = 2;  break;   //  certo
    case 251: _mask = 3;  break;  //  certo
    case 250: _mask = 4;  break; // certo
    case 248: _mask = 22; break;  //  certo
    case 223: _mask = 9;  break; // certo
    case 222: _mask = 10;  break; // certo
    case 219: _mask = 11; break; // certo? 
    case 218: _mask = 12; break; // certo?
    case 216: _mask = 24; break; // certo?
    case 214: _mask = 18; break; // certo
    case 210: _mask = 18; break; // 
    case 208: _mask = 38; break;  //  certo
    case 127: _mask = 5;  break; //  certo
    case 126: _mask = 6;  break; // certo?
    case 123: _mask = 7;  break; //  certo
    case 120: _mask = 23; break; // certo
    case 107: _mask = 27; break; // certo
    case 106: _mask = 29; break; // certo?
    case 104: _mask = 40; break; // certo
    case 95:  _mask = 13; break; //  certo
    case 94:  _mask = 18; break; //
    case 91:  _mask = 18; break; //
    case 90:  _mask = 18; break; // 
    case 88:  _mask = 18; break; // 
    case 86:  _mask = 18; break; // 
    case 82:  _mask = 18; break; // 
    case 80:  _mask = 3; break; //
    case 75:  _mask = 28; break; // certo
    case 74:  _mask = 30; break; // certo
    case 72:  _mask = 3; break; // 
    case 66:  _mask = 36; break;  //  certo 
    case 64:  _mask = 47; break;  // certo  
    case 31:  _mask = 31; break; //  certo
    case 30:  _mask = 32; break; //  certo
    case 27:  _mask = 33 break; //  certo
    case 26:  _mask = 34; break; // certo
    case 24:  _mask = 37 break; //  certo
    case 22:  _mask = 45; break;//  certo
    case 18:  _mask = 3; break; // 
    case 16:  _mask = 48; break; // certo
    case 11:  _mask = 42; break; // certo
    case 10:  _mask = 44; break; // certo
    case 8:   _mask = 50; break; // certo
    case 2:   _mask = 49; break; // certo
    case 0:   _mask = 51; break; // certo
    case -1:  _mask = 0;  break; // Tile vazio
}

//37 corredor
            
            // Set the new index
            tilemap_set(_map, _mask, _tx, _ty);
        }
}