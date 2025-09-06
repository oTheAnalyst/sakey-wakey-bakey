{
  services.walker = {
    enable = true;

    # All options from the config.json can be used here.
    settings = {
      search.placeholder = "Example";
      ui.fullscreen = true;
      list = {
        height = 200;
        width = 600;
        image_size = 65;
      };
      websearch.prefix = "?";
      switcher.prefix = "/";
    };

    # If this is not set the default styling is used.
    theme.style = ''
      *  {
       border-radius: 3px;
       border: none;
           }

           window {
           font-size: 32px;
           font-family: "Roboto Mono Medium";
           background-color: rgba(50, 50, 50, 0.9);
           color: white;
           border-bottom: 3px
           }

           #entry{
               paddin: 0.25em;
           }


           #entry:selected {
               background-color: #bbccdd;
               background: linear-gradient(#90deg, #bbffdd, #dd77ff);
           }

           #text:selected {
               color: #333333;
           }

           #input {
               background-color: rgba(50, 50, 50, 0.5);
               color: white;
               padding: 0.25em;

           } '';
  };
}
