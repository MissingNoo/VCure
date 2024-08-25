function urukanote_create(obj){
	obj.explosionResized = false;
	obj.upDown = choose(-1,1);
	obj.coscounter = current_time;
	obj.noteStartX = obj.x;
	obj.noteStartY = obj.y;
	if (oPlayer.monsterUsed) {
		obj.hits = 9999;
		obj.tempKnockback = 15;
		obj.mindmg = obj.mindmg / 2;
		obj.maxdmg = obj.maxdmg / 2;
		obj.image_xscale = 0.1;
		obj.image_yscale = 0.1;
		obj.sprite_index = sMonsterPulse;
		obj.speed = 0;
		exit;
	}
	if (obj.idolDir == 90) {
		obj.idolDir = 270;
		obj.idolStartX= obj.owner.x + 20;
		obj.direction = obj.idolDir;
	}else{
		obj.idolDir = 90;
		obj.idolStartX= obj.owner.x - 20;
		obj.direction = obj.idolDir;
	}			
	if (obj.owner.image_xscale==1) {
		obj.direction = point_direction(obj.x,obj.y,obj.x+100,obj.y);
	}
	else {
		obj.direction = point_direction(obj.x,obj.y,obj.x-100,obj.y);
	}
	obj.image_xscale = obj.owner.image_xscale;
	obj.sprite_index = choose(sFullNote, sHalfNote, sQuarterNote, sEightNote);
	switch (obj.sprite_index) {
		case sFullNote:
			obj.hits = 3;
			break;
		case sHalfNote:
			obj.hits = 5;
			break;
		case sQuarterNote:
			obj.hits = 7;
			break;
		case sEightNote:
			obj.hits = 9999;
			break;
	}
	//extrainfo.coscounter = coscounter;
	//extrainfo.upDown = upDown;
	//extrainfo.travelWidth = upg[$ "travelWidth"];
	//extrainfo.noteStartY = noteStartY;
}
function urukanote_step(obj){
	if (obj.sprite_index == sMonsterPulse) {
		obj.image_xscale += 0.10;
		obj.image_yscale = obj.image_xscale;
		exit;
	}
	obj.y = cose_wave(obj.coscounter / 1000, 1 * obj.upDown, obj.upg[$ "travelWidth"], obj.noteStartY);
	obj.coscounter += 15;
	if (obj.image_xscale < 0) {
		obj.image_xscale = obj.image_xscale * -1;
	}
	if (obj.upg.level >= 4) {
		var _sizeGain = 0.003;
		obj.image_xscale += _sizeGain;
		obj.image_yscale += _sizeGain;
		obj.sizeGained = obj.image_xscale;
	}
}
function urukanote_outside_view(obj){
	if (obj.sprite_index != sMonsterPulse) {
		noteexplosion(obj);
	}
}
function urukanote_animation_end(obj){
	if (!instance_exists(obj)) { exit; }
	if (obj.sprite_index == sNoteExplosion) {
		obj.current_frame = obj.last_frame - 1;
	    instance_destroy(obj);
	}
}
function urukanote_on_hit(obj){
	if (obj.hits <= 0) {
	    obj.hits = 999;
		noteexplosion(obj);
	}
}
function noteexplosion(obj){
	if (obj.upg.level == 7) {
		instance_create_depth(obj.x, obj.y, obj.depth, oUpgradeNew, {
			upg : WEAPONS_LIST[Weapons.UrukaNoteExplosion][7], 
			image_xscale : obj.image_xscale / 1.5,
			image_yscale : obj.image_yscale / 1.5
		});
		if (instance_exists(obj)) { instance_destroy(obj); }
	}
}
function urukanote_explosion_animation_end(obj) {
	if (instance_exists(obj)) { instance_destroy(obj); }
}