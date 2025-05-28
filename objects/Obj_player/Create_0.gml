// Define os estados do jogador
enum PlayerStates {
    idle,
    run,
    atk
}

// Estado inicial
state = PlayerStates.idle;

// Velocidade de movimento
velc = 4;

// Tempo para iniciar o jogo
global.jogo_iniciado = false;
global.tempo_inicio_jogo = 0;

// Velocidade inicial
velh = 0;
velv = 0;

// Animação
image_speed = 0.3;