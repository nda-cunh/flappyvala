const int RECTX = 28;
const int RECTY = 36;

class Score{
    public Score(){
        this.init_object();
        card[1] = {RECTX*0, 0};
        card[2] = {RECTX*1, 0};
        card[3] = {RECTX*2, 0};
        card[4] = {RECTX*3, 0};
        card[5] = {RECTX*4, 0};
        card[6] = {RECTX*0, RECTY};
        card[7] = {RECTX*1, RECTY};
        card[8] = {RECTX*2, RECTY};
        card[9] = {RECTX*3, RECTY};
        card[0] = {RECTX*4, RECTY};
        m_sprite[0].set_Position(450 - RECTX - 20, 20);
        m_sprite[0].rect = {card[0].x, card[0].y,RECTX, RECTY};

        m_sprite[1].set_Position(450 - RECTX * 2 - 20, 20);
        m_sprite[1].rect = {card[0].x, card[0].y, RECTX, RECTY};

        m_sprite[2].set_Position(450 - RECTX * 3 - 20, 20);
        m_sprite[2].rect = {card[0].x, card[0].y, RECTX, RECTY};
        update();
    }
    public void init_object(){
        m_texture = new Bg.Texture();
        m_texture.set_texture (IMAGE_DIR + "font.bmp");
        m_sprite[0] = new Bg.Sprite(m_texture);
        m_sprite[1] = new Bg.Sprite(m_texture);
        m_sprite[2] = new Bg.Sprite(m_texture);
    }
    public void draw(ref Bg.Window win){
        win.draw(m_sprite[0]);
        win.draw(m_sprite[1]);
        if(!(m_sprite[2].rect.x == RECTX*4))
            win.draw(m_sprite[2]);
    }
    public void add_point(){
        m_score++;
        update();
    }
    public void over(){
        m_score = 0;
        update();
    }
    protected void set_card(int sprite, int ncard){
        m_sprite[sprite].rect = {card[ncard].x, card[ncard].y,RECTX, RECTY};
    }
    protected void update(){
        int score_tmp = m_score;
        int mod = 0;
        int i = 0;
        while(score_tmp >= 10){
            mod = score_tmp % 10;
            score_tmp = score_tmp / 10;
            set_card(i, mod);
            i++;
        }
        set_card(i, score_tmp);
    }
    private int m_score = 0;
    private static Bg.Texture m_texture;
    private Bg.Sprite m_sprite[3];
    private Card card[9];
}

struct Card{
    int x;
    int y;
}
