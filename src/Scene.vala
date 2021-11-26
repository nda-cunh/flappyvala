class Scene{
    public Scene () {
        this.init_object();
        
        m_s_gameover.move({45,100});
        m_s_title.move({50,100});
        m_s_retry.move({135,240});
        if(m_t_title.set_texture("/home/hydral/Desktop/flappyvala/data/titre.bmp")){
           m_t_title.set_texture("data/titre.bmp");
        }
        if(m_t_gameover.set_texture("/home/hydral/Desktop/flappyvala/data/gameover.bmp")){
            m_t_gameover.set_texture("data/gameover.bmp");
        }
        if(m_t_retry.set_texture("/home/hydral/Desktop/flappyvala/data/retry.bmp")){
            m_t_retry.set_texture("data/retry.bmp");
        }
        
    }
    private void init_object(){
        m_win = new Window("flappy bird", 450, 650);
        m_background = new Background();
        m_perso = new Personnage();
        m_t_title = new Texture();
        m_t_gameover = new Texture();
        m_t_retry = new Texture();
        
        m_s_title = new Sprite(m_t_title);
        m_s_gameover = new Sprite(m_t_gameover);
        m_s_retry = new Sprite(m_t_retry);
    }
    public void run(){
        while(m_win.is_open())
        {
            this.event();
            m_win.clear();
            this.drawing();
            m_win.present();
        }
    }
    
    public void drawing(){
        m_background.draw(ref m_win);
        m_perso.draw(ref m_win);
        if(m_background.is_collision(m_perso.get_sprite()))
        {
            m_perso.kill();
            m_background.kill();
            if(activity != OVER)
                diff_restart = SDL.Timer.get_ticks();
            activity = Activity.OVER;
            if(SDL.Timer.get_ticks() >= diff_restart + 850)
            {
                m_win.draw(m_s_retry);
            }
            
            
        }
        if(activity == Activity.PAUSE)
            m_win.draw(m_s_title);
        if(activity == Activity.GAME)
            m_background.add_tuyau();
        if(activity == Activity.OVER)
        {
            m_win.draw(m_s_gameover);
        }
    }
    
    public void event(){
        SDL.Event.poll(out m_event);
        if(m_event.type == SDL.EventType.QUIT){
            m_win.close();
        }
        if(m_event.type == SDL.EventType.KEYUP){
		    if(m_event.key.keysym.scancode.get_name() == "Space"){
		        if(activity == Activity.PAUSE){
		            activity = Activity.GAME;
		            m_perso.saute();
		            return;
		        }
		        if(activity == Activity.OVER){
		            activity = Activity.PAUSE;
		            if(SDL.Timer.get_ticks() >= diff_restart + 850)
                    {
                        diff_restart = SDL.Timer.get_ticks();
                        m_background.init();
		                m_perso.init();
                    }
		            
		            return;
		        }
		        m_perso.saute();
		        
		    }
		}
    }
    private Personnage m_perso;
    private Background m_background;
    private Window m_win;
    private SDL.Event m_event;
    
    private Sprite m_s_title;
    private Sprite m_s_gameover;
    
    private Texture m_t_title;
    private Texture m_t_gameover;
    
    private Sprite m_s_retry;
    private Texture m_t_retry;
    
    private uint32 diff_restart;
    private Activity activity = PAUSE;
    
}

enum Activity{
    GAME,PAUSE,OVER
}
