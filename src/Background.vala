using Bg;

class Background{
    public Background () {
        this.init_object();
        
        for(int i = 0; i != 6; i++){
            m_sprite_building[i].move({m_texture_building.get_W() * i, 420});
        }
        
        for(int i = 0; i != 6; i++){
            m_sprite_grass[i].move ({m_texture_grass.get_W() * i, 650 - m_texture_grass.get_H()});
        }
    }
    private void init_object(){
        a_grass = new Animate(15);
        a_building = new Animate(60);
        a_tuyau_move = new Animate(10);
        m_texture_grass = new Texture();
        m_texture_background = new Texture();
        m_texture_building = new Texture();
        
        if(m_texture_grass.set_texture(IMAGE_DIR + "grass.bmp")){
            m_texture_grass.set_texture("data/grass.bmp");
        }
        if(m_texture_background.set_texture(IMAGE_DIR + "back.bmp")){
            m_texture_background.set_texture("data/back.bmp");
        }
        if(m_texture_building.set_texture(IMAGE_DIR + "building.bmp")){
            m_texture_building.set_texture("data/building.bmp");
        }

        m_sprite_background = new Sprite(m_texture_background);
        for(int i = 0; i != 6; i++){
            m_sprite_grass[i] = new Sprite(m_texture_grass);
        }
        for(int i = 0; i != 6; i++){
            m_sprite_building[i] = new Sprite(m_texture_building);
        }
        for(int i = 0; i != m_tuyau.length; i++)
            m_tuyau[i] = new Tuyau();
    }
    
    public void init(){
        for(int i = 0; i != m_tuyau.length; i++)
            m_tuyau[i].init();
            is_dead = false;
        }
    public void draw(ref Window win){
        this.animate();
        win.draw(m_sprite_background);
        win.draw(m_sprite_building[0]);
        
        for(int i = 0; i != 6; i++){
            win.draw(m_sprite_building[i]);
        }
        for(int i = 0; i != m_tuyau.length; i++)
            m_tuyau[i].draw(ref win);
        for(int i = 0; i != 6; i++){
            win.draw(m_sprite_grass[i]);
        }
    }
    
    public void kill(){
        is_dead = true;
    }
    
    protected void animate(){
        if(is_dead == true)
            return;
        if(a_grass.animate()){
            for(int i = 0; i != 6; i++){
                m_sprite_grass[i].move({-3,0});
                if(m_sprite_grass[i].get_position().x < -m_texture_grass.get_W())
                    m_sprite_grass[i].move ({m_texture_grass.get_W() * 5,0});
            }
        }
        if(a_building.animate()){
            for(int i = 0; i != 6; i++){
                m_sprite_building[i].move({-01,0});
                if(m_sprite_building[i].get_position().x < -m_texture_building.get_W())
                    m_sprite_building[i].move ({m_texture_building.get_W() * 5,0});
            }
        }
        if(a_tuyau_move.animate()){
            for(int i = 0; i != m_tuyau.length; i++)
                m_tuyau[i].move();
        }
    }
    public void add_tuyau(){
        diff_activate = SDL.Timer.get_ticks();
        m_tuyau[index_activate].activate();
        index_activate++;
        if(index_activate == m_tuyau.length)
            index_activate = 0;
    }
    public bool is_collision(Sprite perso){
        for(int i = 0; i != m_tuyau.length; i++){
            if(m_tuyau[i].is_collision(perso))
                return true;
        }
        return false;
    }
    public bool is_go_on(Sprite perso){
        for(int i = 0; i != m_tuyau.length; i++){
            if(m_tuyau[i].is_go_on(perso))
                return true;
        }
        return false;
    }
    
    private uint32 diff_activate = 0;
    private uint index_activate = 0;
    
    private Sprite m_sprite_background;
    private Texture m_texture_background;
    
    private Texture m_texture_grass;
    private Sprite m_sprite_grass[6];
    
    private Sprite m_sprite_building[6];
    private Texture m_texture_building;
    
    private Animate a_building;
    private Animate a_grass;
    private Animate a_tuyau_move;

    private Tuyau m_tuyau[4];
    private bool is_dead = false;
}
