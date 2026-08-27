{
  programs = {
    kitty = {
      enable = true;
      font.name = "nerd-fonts-fira-code";
      font.size = 14;
      settings.shell = "fish";
      extraConfig =
        /*
        lua
        */
        ''
           cremember_window_size  no
           initial_window_width  640
           initial_window_height  400
           confirm_os_window_close  0
           background_opacity  0.95
           hide_window_decorations  yes

           #: The basic colors

          foreground #878ba6
          background #1e202f
          selection_foreground #878ba6
          selection_background #292c3d


          #: Cursor colors

          cursor #d14781
          cursor_text_color #1e202f


          #: URL underline color when hovering with mouse

          url_color #d2d8fe
                  

          #: layouts
          enabled_layouts fat:bias=50;
                          full_size=1;
                          mirrored=false
                          # Create a new window splitting the space used by the existing one so that

          # the two windows are placed one above the other
          map f5 launch --location=hsplit

          # Create a new window splitting the space used by the existing one so that
          # the two windows are placed side by side
          map f6 launch --location=vsplit

          # Create a new window splitting the space used by the existing one so that
          # the two windows are placed side by side if the existing window is wide or
          # one above the other if the existing window is tall.
          map f4 launch --location=split

          # Rotate the current split, changing its split axis from vertical to
          # horizontal or vice versa
          map f7 layout_action rotate

          # Move the active window in the indicated direction
          map shift+up move_window up
          map shift+left move_window left
          map shift+right move_window right
          map shift+down move_window down

          # Move the active window to the indicated screen edge
          map ctrl+shift+up layout_action move_to_screen_edge top
          map ctrl+shift+left layout_action move_to_screen_edge left
          map ctrl+shift+right layout_action move_to_screen_edge right
          map ctrl+shift+down layout_action move_to_screen_edge bottom

          # Switch focus to the neighboring window in the indicated direction
          map ctrl+left neighboring_window left
          map ctrl+right neighboring_window right
          map ctrl+up neighboring_window up
          map ctrl+down neighboring_window down

          # Set the bias of the split containing the currently focused window. The
          # currently focused window will take up the specified percent of its parent
          # windows size.
          map ctrl+. layout_action bias 80

          # Maximize the active window along the horizontal axis (fill full width),
          # keeping other windows visible in their vertical positions. Press again to
          # restore the original layout.
          map ctrl+shift+right layout_action maximize horizontal

          # Maximize the active window along the vertical axis (fill full height),
          # keeping other windows visible in their horizontal positions. Press again
          # to restore the original layout.
          map ctrl+shift+up layout_action maximize vertical

          # Equalize all splits so that windows share available space proportionally.
          map ctrl+shift+e layout_action equalize


          #: kitty window border colors and terminal bell colors

          active_border_color #444864
          inactive_border_color #1e202f
          bell_border_color #5165e6
          visual_bell_color none


          #: OS Window titlebar colors

          wayland_titlebar_color #292c3d
          macos_titlebar_color #292c3d


          #: Tab bar colors

          active_tab_foreground #fbf9fa
          active_tab_background #1e202f
          inactive_tab_foreground #b0a6aa
          inactive_tab_background #292c3d
          tab_bar_background #292c3d
          tab_bar_margin_color none


          #: Colors for marks (marked text in the terminal)

          mark1_foreground #1e202f
          mark1_background #6375ee
          mark2_foreground #1e202f
          mark2_background #8d8186
          mark3_foreground #1e202f
          mark3_background #e44e8c


          #: The basic 16 colors

          #: black
          color0 #1e202f
          color8 #4f5472

          #: red
          color1 #7586f5
          color9 #fe81b5

          #: green
          color2 #fb6fa9
          color10 #292c3d

          #: yellow
          color3 #ffb3d2
          color11 #444864

          #: blue
          color4 #8696fd
          color12 #5b6080

          #: magenta
          color5 #fb6fa9
          color13 #d2d8fe

          #: cyan
          color6 #a0acfe
          color14 #f764a1

          #: white
          color7 #878ba6
          color15 #ebedff     '';
    };
  };
}
