collision_list = ds_list_create(); //lista da colisao
hitbox_list = ds_list_create(); //lista de quem já tomou o dano
var c = instance_place_list(x,y,obj_player,collision_list,false);

if(c > 0){
	for(var i = 0; i < ds_list_size(collision_list);i++){
		var target = collision_list[|i];
		if(!ds_list_find_value(hitbox_list,target)){
			ds_list_add(hitbox_list,target);
			with(target){
				if(state = player_state_def) life-=0;
				else {
					life -=5;
					if (state != player_state_hurt) {
						state = player_state_hurt;
					}
				}
			}
		}
	}
}