// Feather disable all

function scribble(_string = "", _unique_id = undefined)
{
    if (is_struct(_string) && (instanceof(_string) == "__scribble_class_element"))
    {
        __scribble_error("scribble() should not be used to access/draw text elements\nPlease instead call the .draw() method on a text element e.g. scribble(\"text\").draw(x, y);");
        return;
    }
    
    static _ecache_dict = __scribble_get_cache_state().__ecache_dict;
    
    var _weak = _ecache_dict[$ string(_string) + ((_unique_id == undefined)? SCRIBBLE_DEFAULT_UNIQUE_ID : (":" + string(_unique_id)))];
    if ((_weak == undefined) || !weak_ref_alive(_weak) || _weak.ref.__flushed)
    {
        return new __scribble_class_element(string(_string), _unique_id);
    }
    else
    {
        return _weak.ref;
    }
}