local mod = get_mod("ThirdPerson")

return {
  name = "Third Person",
  description = mod:localize("mod_description"),
  is_togglable = true,
  is_mutator = false,
  options_widgets = {
    {
      ["setting_name"] = "mode",
      ["widget_type"] = "dropdown",
      ["text"] = "Mode",
      ["tooltip"] = "Mode\n\n" ..
        "-- THIRD PERSON --\nCamera is always in third person.\n\n" ..
        "-- AUTOMATIC --\nSetup camera settings for specific situations.",
      ["options"] = {
        {text = "Third Person", value = "third_person"}, --1
        {text = "Automatic", value = "automatic"}, --2
      },
      ["default_value"] = "third_person",
      ["sub_widgets"] = {
        -- Automatic
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_ranged",
          ["widget_type"] = "checkbox",
          ["text"] = "Ranged Weapon",
          ["tooltip"] = "Ranged Weapon\n" ..
            "Camera settings when holding a ranged weapon.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_ranged_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_ranged_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_ranged_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_ranged_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_ranged_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_aim",
          ["widget_type"] = "checkbox",
          ["text"] = "Aiming",
          ["tooltip"] = "Aiming\n" ..
            "Camera settings for aiming with a ranged weapon.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_aim_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_aim_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_aim_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_aim_zoom",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Zoom",
                  ["tooltip"] = "Zoom\n" ..
                    "Change the zoom strength.",
                  ["options"] = {
                    {text = "Default", value = 1},
                    {text = "Medium", value = 2},
                    {text = "Low", value = 3},
                    {text = "Off", value = 4},
                  },
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_aim_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_aim_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_reload",
          ["widget_type"] = "checkbox",
          ["text"] = "Reloading",
          ["tooltip"] = "Reloading\n" ..
            "Camera settings for reloading a ranged weapon.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_reload_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_reload_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_reload_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_reload_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_reload_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_vent",
          ["widget_type"] = "checkbox",
          ["text"] = "Venting Overcharge",
          ["tooltip"] = "Venting Overcharge\n" ..
            "Camera settings when venting overcharge.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_vent_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_vent_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_vent_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_vent_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_vent_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_melee",
          ["widget_type"] = "checkbox",
          ["text"] = "Melee Weapon",
          ["tooltip"] = "Melee Weapon\n" ..
            "Camera settings with a melee weapon.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_melee_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_melee_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_melee_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_melee_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_melee_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_block",
          ["widget_type"] = "checkbox",
          ["text"] = "Blocking",
          ["tooltip"] = "Blocking\n" ..
            "Camera settings for blocking with a melee weapon.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_block_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_block_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_block_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_block_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_block_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.5,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_push",
          ["widget_type"] = "checkbox",
          ["text"] = "Pushing",
          ["tooltip"] = "Pushing\n" ..
            "Camera settings for pushing with a melee weapon.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_push_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_push_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_push_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_push_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_push_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_stunned",
          ["widget_type"] = "checkbox",
          ["text"] = "Stunned",
          ["tooltip"] = "Stunned\n" ..
            "Camera settings when stunned after was broken.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_stunned_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_stunned_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_stunned_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_stunned_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_stunned_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_potion",
          ["widget_type"] = "checkbox",
          ["text"] = "Holding Potion",
          ["tooltip"] = "Holding Potion\n" ..
            "Camera settings when holding a potion.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_potion_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_potion_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_potion_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_potion_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_potion_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_healthkit",
          ["widget_type"] = "checkbox",
          ["text"] = "Holding Healing Item",
          ["tooltip"] = "Holding Healing Item\n" ..
            "Camera settings when holding a healing item.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_healthkit_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_healthkit_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_healthkit_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_healthkit_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_healthkit_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_grenade",
          ["widget_type"] = "checkbox",
          ["text"] = "Holding Grenades",
          ["tooltip"] = "Holding Grenades\n" ..
            "Camera settings when holding a grenade.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_grenade_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_grenade_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_grenade_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_grenade_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_grenade_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        {
          ["show_widget_condition"] = {2},
          ["setting_name"] = "automatic_level_event",
          ["widget_type"] = "checkbox",
          ["text"] = "Carrying Event Item",
          ["tooltip"] = "Carrying Event Item\n" ..
            "Camera settings when carrying objective items.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "automatic_level_event_mode",
              ["widget_type"] = "dropdown",
              ["text"] = "Mode",
              ["tooltip"] = "Mode\n" ..
                "Camera mode to be used by this event.",
              ["options"] = {
                {text = "First Peson", value = "first_person"}, --1
                {text = "Third Person", value = "third_person"}, --2
              },
              ["default_value"] = "first_person",
              ["sub_widgets"] = {
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_level_event_side",
                  ["widget_type"] = "dropdown",
                  ["text"] = "Side",
                  ["tooltip"] = "Side\n" ..
                    "Choose if the camera is to left or right of your character.",
                  ["options"] = {
                    {text = "Right", value = "right"},
                    {text = "Left", value = "left"},
                  },
                  ["default_value"] = "right",
                },
                {
                  ["show_widget_condition"] = {2},
                  ["setting_name"] = "automatic_level_event_offset",
                  ["widget_type"] = "numeric",
                  ["text"] = "Offset",
                  ["unit_text"] = "",
                  ["tooltip"] = "Offset\n" ..
                    "Change the distance between the camera and the character.",
                  ["range"] = {50, 400},
                  ["default_value"] = 100,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_level_event_length",
                  ["widget_type"] = "numeric",
                  ["text"] = "Length",
                  ["unit_text"] = "",
                  ["tooltip"] = "Length\n" ..
                    "Change the length of the transition.",
                  ["range"] = {0.1, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 1,
                },
                {
                  ["show_widget_condition"] = {1, 2},
                  ["setting_name"] = "automatic_level_event_delay",
                  ["widget_type"] = "numeric",
                  ["text"] = "Delay",
                  ["unit_text"] = " sec",
                  ["tooltip"] = "Delay\n" ..
                    "Change the delay of the transition.",
                  ["range"] = {0, 2},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.1,
                },
              },
            },
          },
        },
        -- Normal
        {
          ["show_widget_condition"] = {1},
          ["setting_name"] = "side",
          ["widget_type"] = "dropdown",
          ["text"] = "Side",
          ["tooltip"] = "Side\n" ..
            "Choose if the camera is to left or right of your character.",
          ["options"] = {
            {text = "Right", value = "right"},
            {text = "Left", value = "left"}
          },
          ["default_value"] = "left",
        },
        {
          ["show_widget_condition"] = {1},
          ["setting_name"] = "offset",
          ["widget_type"] = "numeric",
          ["text"] = "Offset",
          ["unit_text"] = "",
          ["tooltip"] = "Offset\n" ..
            "Change the distance between the camera and the character.",
          ["range"] = {50, 400},
          ["default_value"] = 100,
        },
        {
          ["show_widget_condition"] = {1},
          ["setting_name"] = "zoom",
          ["widget_type"] = "dropdown",
          ["text"] = "Zoom",
          ["tooltip"] = "Zoom\n" ..
            "Change the zoom strength.",
          ["options"] = {
            {text = "Default", value = 1},
            {text = "Medium", value = 2},
            {text = "Low", value = 3},
            {text = "Off", value = 4},
          },
          ["default_value"] = 1,
        },
        {
          ["show_widget_condition"] = {1, 2},
          ["setting_name"] = "sway",
          ["widget_type"] = "checkbox",
          ["text"] = "Dynamic Swaying",
          ["tooltip"] = "Dynamic Swaying\n" ..
            "In third person the camera smoothly sways from left to right when strafing.",
          ["default_value"] = false,
          ["sub_widgets"] = {
            {
              ["setting_name"] = "sway_speed",
              ["widget_type"] = "numeric",
              ["text"] = "Speed",
              ["unit_text"] = "",
              ["tooltip"] = "Speed\n" ..
                "Camera sway speed.",
              ["range"] = {0.1, 1},
              ["decimals_number"] = 1,
              ["default_value"] = 0.5,
            },
            {
              ["setting_name"] = "sway_normalize",
              ["widget_type"] = "checkbox",
              ["text"] = "Normalize",
              ["tooltip"] = "Normalize\n" ..
                "Smoothly resets sway amount when not strafing.",
              ["default_value"] = false,
            },
            {
              ["setting_name"] = "sway_input",
              ["widget_type"] = "dropdown",
              ["text"] = "Input Type",
              ["tooltip"] = "Input Type\n" ..
                "The type of input used for camera sway.",
              ["options"] = {
                {text = "Keyboard", value = "keyboard"},
                {text = "Mouse", value = "mouse"},
              },
              ["default_value"] = "mouse",
            },
            {
              ["setting_name"] = "sway_avoid_character",
              ["widget_type"] = "checkbox",
              ["text"] = "Avoid Character",
              ["tooltip"] = "Avoid Character\n" ..
                "Avoids the character being in front of the camera.",
              ["default_value"] = false,
              ["sub_widgets"] = {
                {
                  ["setting_name"] = "sway_avoid_vertical",
                  ["widget_type"] = "numeric",
                  ["text"] = "Vertical",
                  ["unit_text"] = "",
                  ["tooltip"] = "Vertical\n" ..
                    "The strength of sway applied vertically to avoid the character.",
                  ["range"] = {0, 1},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.75,
                },
                {
                  ["setting_name"] = "sway_avoid_backwards",
                  ["widget_type"] = "numeric",
                  ["text"] = "Backwards",
                  ["unit_text"] = "",
                  ["tooltip"] = "Backwards\n" ..
                    "The strength of sway applied backwards to avoid the character.",
                  ["range"] = {0, 1},
                  ["decimals_number"] = 1,
                  ["default_value"] = 0.75,
                },
              }
            },
          },
        },
        {
          ["show_widget_condition"] = {1},
          ["setting_name"] = "toggle_side",
          ["widget_type"] = "keybind",
          ["text"] = "Toggle Side",
          ["tooltip"] = "Toggle side left / right.",
          ["default_value"] = {},
          ["action"] = "toggle_side"
        },
        {
          ["show_widget_condition"] = {1},
          ["setting_name"] = "switch_offset",
          ["widget_type"] = "keybind",
          ["text"] = "Switch Offset",
          ["tooltip"] = "Switch camera offset.",
          ["default_value"] = {},
          ["action"] = "switch_offset"
        },
        {
          ["show_widget_condition"] = {1},
          ["setting_name"] = "switch_zoom",
          ["widget_type"] = "keybind",
          ["text"] = "Switch Zoom",
          ["tooltip"] = "Switch camera zoom.",
          ["default_value"] = {},
          ["action"] = "switch_zoom"
        },
      },
    },
    {
      ["setting_name"] = "reload_stop_when_finished",
      ["widget_type"] = "checkbox",
      ["text"] = "Stop Reload When Finished",
      ["tooltip"] = "Stop Reload When Finished\n" ..
        "Toggle stop reload when finished off or on.\n\n" ..
        "The first- and third person animations can differ a lot.\n" ..
        "Especially the reload animation for ranged weapons.\n" ..
        "Stops third person reload animation after the correct time.",
      ["default_value"] = true,
    },
    {
      ["setting_name"] = "reload_extend_too_short",
      ["widget_type"] = "checkbox",
      ["text"] = "Extend Short Reload Animations",
      ["tooltip"] = "Extend short Animations\n" ..
        "Toggle extend short animations off or on.\n\n" ..
        "The first- and third person animations can differ a lot.\n" ..
        "Especially the reload animation for ranged weapons.\n" ..
        "Repeats third person reload animation if too short.",
      ["default_value"] = true,
    },
    {
      ["setting_name"] = "toggle_mod",
      ["widget_type"] = "keybind",
      ["text"] = "Toggle",
      ["tooltip"] = "Toggle third person on / off.",
      ["default_value"] = {},
      ["action"] = "toggle_mod_state"
    },
  }
}