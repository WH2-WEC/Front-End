



--
-- 	Scripted behaviour for launching the prelude
--



-- custom loading screens used when the "intro" option is checked on the frontend
custom_loading_screens_with_intro = {
	-- vortex campaign
	["2140784459"] = "wh2_main_hef_eataine_10",
	["2140784481"] = "wh2_main_def_naggarond_10",
	["2140784448"] = "wh2_main_lzd_hexoatl_10",
	["2140784539"] = "wh2_main_skv_clan_mors_10"
};


-- custom loading screens used when the "intro" option is NOT checked on the frontend
custom_loading_screens_no_intro = {
	-- vortex campaign
	["2140784459"] = "wh2_main_hef_eataine_01",
	["2140784490"] = "wh2_main_hef_order_of_loremasters_01",
	["2140784481"] = "wh2_main_def_naggarond_01",
	["2140784494"] = "wh2_main_def_cult_of_pleasure_01",
	["2140784448"] = "wh2_main_lzd_hexoatl_01",
	["2140784458"] = "wh2_main_lzd_last_defenders_01",
	["2140784539"] = "wh2_main_skv_clan_mors_01",
	["2140784529"] = "wh2_main_skv_clan_pestilens_01",
	["1757671472"] = "wh2_dlc09_skv_clan_rictus_01",
	["1314767883"] = "wh2_dlc09_tmb_followers_of_nagash_01",
	["306236299"] = "wh2_dlc09_tmb_khemri_01",
	["1661976522"] = "wh2_dlc09_tmb_lybaras_01",
	["2113968969"] = "wh2_dlc09_tmb_exiles_of_nehek_01",
	["2140784609"] = "wh2_dlc10_hef_alarielle_01",
	["2140784599"] = "wh2_dlc10_hef_alith_anar_01",
	["2140784671"] = "wh2_dlc10_def_hellebron_01",
	
	-- grand campaign
	["2140784849"] = "wh2_main_hef_tyrion_gc",
	["2140785030"] = "wh2_main_hef_teclis_gc",
	["2140784854"] = "wh2_main_def_malekith_gc",
	["2140784906"] = "wh2_main_def_morathi_gc",
	["2140784856"] = "wh2_main_lzd_hexoatl_gc",
	["2140785004"] = "wh2_main_lzd_last_defenders_gc",
	["2140785054"] = "wh2_main_skv_clan_mors_gc",
	["2140785051"] = "wh2_main_skv_clan_pestilens_gc",
	["2140785057"] = "wh2_dlc09_skv_clan_rictus_gc",
	["1865676509"] = "wh2_dlc09_tmb_followers_of_nagash_gc",
	["1224741822"] = "wh2_dlc09_tmb_khemri_gc",
	["1151049787"] = "wh2_dlc09_tmb_lybaras_gc",
	["1472604979"] = "wh2_dlc09_tmb_exiles_of_nehek_gc",
	["2140783388"] = "wh_main_emp_empire_karl_franz",
	["2140783648"] = "wh_main_emp_empire_balthasar",
	["2140784136"] = "wh_dlc04_emp_empire_volkmar",
	["2140782828"] = "wh_main_dwf_dwarfs_thorgrim",
	["566443942"] = "wh_main_dwf_dwarfs_ungrim",
	["2140783397"] = "wh_dlc06_dwf_karak_izor_belegar",
	["2140784160"] = "wh_main_dwf_dwarfs_grombrindal",
	["2140782841"] = "wh_main_grn_greenskins_grimgor",
	["2140783606"] = "wh_main_grn_greenskins_azhag",
	["2140783441"] = "wh_dlc06_grn_crooked_moon_skarsnik",
	["2140783445"] = "wh_dlc06_grn_orcs_of_the_bloody_hand_wurrzag",
	["2140782847"] = "wh_main_vmp_vampire_counts_mannfred",
	["2140783651"] = "wh_main_vmp_vampire_counts_heinrich",
	["2140784146"] = "wh_dlc04_vmp_vampire_counts_helman",
	["2140784138"] = "wh_pro02_vmp_schwartzhafen_vlad",
	["2140784202"] = "wh_pro02_vmp_schwartzhafen_isabella",
	["2140782858"] = "wh_main_chs_chaos_archaon",
	["2140783672"] = "wh_main_chs_chaos_kholek",
	["2140783662"] = "wh_main_chs_chaos_sigvald",
	["2140784064"] = "wh_dlc03_bst_beastmen_khazrak",
	["2140784127"] = "wh_dlc03_bst_beastmen_malagor",
	["2140784189"] = "wh_dlc03_bst_beastmen_morghur",
	["2140784177"] = "wh_dlc05_wef_wood_elves_orion",
	["2140784185"] = "wh_dlc05_wef_argwylon_durthu",
	["2140783351"] = "wh_dlc07_brt_bretonnia_louen",
	["2140784159"] = "wh_dlc07_brt_carcassonne_fay",
	["2140783515"] = "wh_dlc07_brt_bordeleaux_alberic",
	["2032938539"] = "wh_dlc08_nor_norsca_gc",
	["47377677"] = "wh_dlc08_nor_wintertooth_gc",
	["2140784950"] = "wh2_dlc10_hef_alarielle_gc",
	["2140784984"] = "wh2_dlc10_hef_alith_anar_gc",
	["2140785115"] = "wh2_dlc10_def_hellebron_gc"
};








--	load script libraries
load_script_libraries();


--	set the default campaign launch mode to not launch the prelude battle by default
core:svr_save_bool("sbool_player_selected_first_turn_intro_on_frontend", false);





--	listen for the singleplayer grand campaign screen being opened and
--	work out if we should check the 'start prelude' checkbox by default
function start_new_campaign_listener()
	core:add_listener(
		"start_new_campaign_listener",
		"FrontendScreenTransition",
		function(context) return context.string == "sp_grand_campaign" end,
		function(context)
			local uic_grand_campaign = find_uicomponent(frontend_ui_root, "sp_grand_campaign");
				
			if not uic_grand_campaign then
				script_error("ERROR: start_new_campaign_listener() couldn't find uic_grand_campaign, how can this be?");
				return false;
			end;
				
			if uic_grand_campaign:GetProperty("campaign_key") == "wh2_main_great_vortex" and should_check_start_prelude_by_default() then
				out("Checking prelude checkbox as player has not listened to any startup advice");
				
				uic_grand_campaign:InterfaceFunction("SetupForFirstTime");
			end;
		end,
		true	
	);
end;


--	listen for the 'start campaign' button being clicked and work out if we should
--	start the prelude battle based on the value of the 'start prelude' checkbox
function start_campaign_launch_listener()
	core:add_listener(
		"start_campaign_button_listener",
		"ComponentLClickUp",
		function(context) return context.string == "button_start_campaign" end,
		function(context)			
			-- work out if we have to load the full intro
			local uic_prelude = find_uicomponent(frontend_ui_root, "checkbox_start_prelude");
			intro_enabled = (uic_prelude and uic_prelude:CurrentState() == "selected") or core:is_tweaker_set("FORCE_FULL_CAMPAIGN_PRELUDE");
			
			-- try and set a custom loading screen
			set_custom_loading_screen(intro_enabled)
			
			if intro_enabled then
				-- this value will be read by the campaign script to decide what to do
				core:svr_save_bool("sbool_player_selected_first_turn_intro_on_frontend", true);
			end;
		end,
		true
	);
end;







function set_custom_loading_screen(intro_enabled)
	-- work out which campaign/lord is selected
	for i = 0, frontend_ui_root:ChildCount() - 1 do
		local uic_root_child = UIComponent(frontend_ui_root:Find(i));
		
		if uic_root_child:Visible() then
			-- this child of root is visible (it may be a campaign), see if we can find lord select list
			local uic_lord_select_list = find_uicomponent(uic_root_child, "lord_select_list", "list_box");
			
			if uic_lord_select_list then
				-- we have a campaign screen with a visible lord_select_list
				-- go through the lords in the list, and work out which one is selected
				for j = 0, uic_lord_select_list:ChildCount() - 1 do
					local uic_child = UIComponent(uic_lord_select_list:Find(j));
					
					if uic_child:CurrentState() == "selected" then
						local start_pos_id = uic_child:GetProperty("lord_key");
						
						-- the player is starting a campaign with this faction, see if we have a custom loading screen for it
						if intro_enabled then
							local loading_screen = custom_loading_screens_with_intro[start_pos_id];
							if loading_screen then
								out("set_custom_loading_screen() is overriding loading screen with text key [" .. loading_screen .. "], first-turn intro is enabled");
								effect.set_custom_loading_screen_key(loading_screen);
							else
								script_error("ERROR: set_custom_loading_screen() called, but couldn't find a loading screen override for character with start pos id " .. start_pos_id .. " (first-turn intro is enabled)");
							end;
						else
							local loading_screen = custom_loading_screens_no_intro[start_pos_id];
							if loading_screen then
								out("set_custom_loading_screen() is overriding loading screen with text key [" .. loading_screen .. "], starting normal campaign without first-turn intro");
								effect.set_custom_loading_screen_key(loading_screen);
							else
								script_error("ERROR: set_custom_loading_screen() called, but couldn't find a loading screen override for character with start pos id " .. start_pos_id .. " (normal campaign without first-turn intro)");
							end;
						end;
						
						return;
					end;
				end;
				
				script_error("ERROR: set_custom_loading_screen() called but couldn't find a selected lord");
				return;
			end;
		end;
	end;
	
	script_error("ERROR: set_custom_loading_screen() called but couldn't find a visible campaign screen");
end;











--	for each intro advice thread key, check its score - if it's above 0 then it's been played
--	before, so we shouldn't check the start prelude checkbox
function should_check_start_prelude_by_default()
	if _G.is_autotest then
		out("This is an autorun so not checking prelude checkbox");
		return false;
	end;
	
	if core:is_tweaker_set("PRELUDE_BATTLE_DISABLED_BY_DEFAULT") then
		out("Tweaker PRELUDE_BATTLE_DISABLED_BY_DEFAULT is set so not checking prelude checkbox");
		return false;
	end;

	if effect.get_advice_history_string_seen("player_has_stated_campaign") then
		return false;
	end;
	
	return true;
end;




function unlock_campaign_movies()
	local movies_to_unlock = {
		"def_horned_rat",
		"def_ritual_1",
		"def_ritual_2",
		"def_ritual_3",
		"def_ritual_4",
		"def_ritual_5",
		"def_win",
		"hef_horned_rat",
		"hef_ritual_1",
		"hef_ritual_2",
		"hef_ritual_3",
		"hef_ritual_4",
		"hef_ritual_5",
		"hef_win",
		"lzd_horned_rat",
		"lzd_ritual_1",
		"lzd_ritual_2",
		"lzd_ritual_3",
		"lzd_ritual_4",
		"lzd_ritual_5",
		"lzd_win",
		"skv_horned_rat",
		"skv_ritual_1",
		"skv_ritual_2",
		"skv_ritual_3",
		"skv_ritual_4",
		"skv_ritual_5",
		"skv_win",
		"skv_comet",
		"battle_arkhan",
		"battle_khalida",
		"battle_khatep",
		"battle_settra",
		"book_1",
		"book_1_arkhan",
		"book_2",
		"book_2_arkhan",
		"book_3",
		"book_3_arkhan",
		"book_4",
		"book_4_arkhan",
		"intro_arkhan",
		"intro_khalida",
		"intro_khatep",
		"intro_settra",
		"win_arkhan",
		"win_khalida",
		"win_khatep",
		"win_settra"
	};
	
	for i = 1, #movies_to_unlock do
		core:svr_save_registry_bool(movies_to_unlock[i], true);
	end;
end;



--	get a handle to the ui_root
frontend_ui_root = nil --:CA_UIC

core:add_listener(
	"frontend_ui_created_listener",
	"UICreated",
	true,
	function(context)
		frontend_ui_root = UIComponent(context.component)
		start_new_campaign_listener();
		start_campaign_launch_listener();
		
		-- go to the credits screen immediately if this saved value is set
		if core:svr_load_bool("sbool_frontend_play_credits_immediately") then
			core:svr_save_bool("sbool_frontend_play_credits_immediately", false);
		
			local uic_button_credits = find_uicomponent(frontend_ui_root, "button_credits");
			
			if uic_button_credits then
				uic_button_credits:SimulateClick();
			end;
		end;
		
		if core:is_tweaker_set("UNLOCK_FRONTEND_MOVIES") then
			unlock_campaign_movies();
		end;
	end,
	false
);