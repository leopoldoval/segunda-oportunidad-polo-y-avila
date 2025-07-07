DESCRIPCIÓN BREVE DEL JUEGO Y SUS MECANICAS:

Es un juego de plataformas en 2D donde el jugador controla a un personaje que debe recolectar monedas, evitar peligros (como fuego o fantasmas), y llegar al final del nivel. El personaje tiene una animación de movimiento, recolección y colisión, y el entorno incluye plataformas, obstáculos y enemigos.

Mecánicas principales:

-Movimiento lateral (izquierda y derecha)

-Salto

-Recolección de monedas

-Detección de colisiones con enemigos

-Cambio de escenas al finalizar un nivel


DESCRIPCIÓN DE LOS RECURSOS USADOS A MANERA DE LISTA:

  - Personaje

![image](https://github.com/user-attachments/assets/6afb90ae-481a-4db6-90ce-60f74a5120a3)

  - background

![image](https://github.com/user-attachments/assets/7c9880a2-080a-4c3f-8d1e-0e924065beaf)

  - coin

![image](https://github.com/user-attachments/assets/0b42c306-61f5-42ed-bcda-0495a2f1413b)

  - song

  - ghost

![image](https://github.com/user-attachments/assets/a164ecc0-050a-4e37-a480-61efc6e84cae)

  - paralax

![image](https://github.com/user-attachments/assets/e80d4821-ac0b-4236-b1a5-a4db80c8d005)


DESCRIPCIÓN DE CADA ESCENA:

NIVEL 1:


![image](https://github.com/user-attachments/assets/89c0d30f-5ccb-445a-acce-c5a14f5be79d)


Personaje Jugable ("player")


  - Controlado por el script `player.gd`.
  - Puede moverse, saltar.
  - Tiene animaciones de caminar ('walk') e inactividad ('idle').
  - Usa físicas mediante `CharacterBody2D`.


Monedas


  - Ítems coleccionables que incrementan un contador en pantalla.
  - Ubicadas sobre plataformas o zonas visibles del nivel.
  - Se actualiza la interfaz mediante `actualizaInterfazMoneda()`.


Plataformas


![image](https://github.com/user-attachments/assets/576be7d1-02f9-4e26-8154-555606a78cdc)

  - Algunas son fijas, otras móviles.
  - Permiten al jugador desplazarse y superar obstáculos.


Escenario y Ambientación


  - Fondo de bosque frondoso y misterioso.
  - Estilo visual pixel-art.
  - Utiliza tilesets para formar el terreno.


Cálices


![image](https://github.com/user-attachments/assets/afddeb6b-8bcd-475b-b677-5a0f4beda055)

  - Figuras que cambian de nivel al ser tocadas por el jugador.
  - Ejemplo: `get_tree().change_scene_to_file('res://world_2.tscn')`.


Zonas de Reinicio


  - Áreas invisibles que reinician el nivel si el jugador cae o pierde.
  - Usan funciones como `_on_reset_area_body_entered()`.


Flujo del Nivel


  - El jugador comienza a la izquierda.
  - Supera obstáculos, recoge monedas y evita trampas.
  - Al llegar al cáliz, avanza al siguiente nivel.


NIVEL 2:

![image](https://github.com/user-attachments/assets/a4bf46a3-1cf0-492c-9b9f-a17c19c8eeba)


Personaje Jugable ("player")


  - Controlado por el mismo script `player.gd` que en el nivel anterior.
  - Mantiene las capacidades de moverse, saltar y detectar colisiones.
  - Usa físicas con gravedad y animaciones ('walk', 'idle').


Monedas


  - Repartidas en varios puntos del mapa, generalmente en zonas elevadas.
  - Incentivan la exploración y el uso correcto de las plataformas móviles.


Plataformas


  - Plataformas móviles (rojas con flechas) que permiten al jugador desplazarse sobre obstáculos.
  - Disposición vertical y horizontal que exige precisión y buen timing.


Escenario y Ambientación


  - Fondo oscuro, con suelos rocosos de estilo volcánico o cavernoso.
  - Agua en la parte inferior (no se indica si es peligrosa o decorativa).


Objetivo del Nivel


  - Superar obstáculos, recoger monedas y alcanzar el final del recorrido.
  - Probable uso del cáliz para regresar al primer nivel (`world.tscn`).


Flujo del Nivel


  - El jugador inicia a la izquierda del mapa.
  - Salta entre plataformas móviles mientras evita caer.
  - Recolecta monedas distribuidas estratégicamente.
  - Al final del recorrido, puede regresar al primer nivel mediante un cáliz.


DESCRIPCIÓN DE LOS CÓDIGOS EMPLEADOS PARA EL FUNCIONAMIENTO:

    extends CharacterBody2D
    class_name player
    
    # Velocidad horizontal del jugador
    var speed := 120
    
    # Dirección del movimiento horizontal (-1 izquierda, 1 derecha)
    var direccion := 0.0
    
    # Fuerza de salto
    var jump := 280
    
    # Gravedad que se aplica cuando está en el aire
    const gravity := 9
    
    # Referencia al nodo AnimationPlayer (para reproducir animaciones)
    @onready var anim := $AnimationPlayer
    
    # Referencia al sprite del jugador
    @onready var sprite := $Sprite2D
    
    # Referencia al contador de monedas en la interfaz del jugador
    @onready var monedaLabel := $playerGUI/HBoxContainer/monedaLabel
    
    
    # Se ejecuta al iniciar la escena
    func _ready():
    	# Guarda esta instancia como el jugador global
    	Global.player = self
    	# Agrega este nodo al grupo "player"
    	add_to_group("player")
    
    
    # Se ejecuta cada fotograma con física
    func _physics_process(delta):
    	# Captura la dirección según las teclas (izquierda/derecha)
    	direccion = Input.get_axis("ui_left", "ui_right")
    	velocity.x = direccion * speed  # Aplica la velocidad horizontal
    	
    	# Reproduce animación dependiendo del movimiento
    	if direccion != 0:
    		anim.play("walk")
    	else:
    		anim.play("idle")
    	
    	# Invierte el sprite si el personaje se mueve a la izquierda
    	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
    	
    	# Si está en el suelo y se presiona la tecla de salto
    	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
    		velocity.y -= jump  # Salta
    	
    	# Aplica gravedad si está en el aire
    	if !is_on_floor():
    		velocity.y += gravity
    	
    	# Mueve al jugador usando física de deslizamiento
    	move_and_slide()
    
    
    # Actualiza el número de monedas mostrado en la interfaz
    func actualizaInterfazMoneda():
    	monedaLabel.text = str(Global.moneda)
    
    
    # Cuando el jugador entra a un área de reinicio (como caer al vacío)
    func _on_reset_area_body_entered(body: Node2D) -> void:
    	get_tree().reload_current_scene()  # Recarga la escena actual
    
    
    # Cuando el jugador toca el cáliz (pasar al siguiente nivel)
    func _on_caliz_body_entered(body: Node2D) -> void:
    	get_tree().change_scene_to_file("res://world_2.tscn")  # Cambia al nivel 2
    
    
    # Otro área de reinicio (puede ser otro hueco o zona peligrosa)
    func _on_reset_area_2_body_entered(body: Node2D) -> void:
    	get_tree().reload_current_scene()  # Recarga la escena actual
    
    
    # Otro cáliz para volver al nivel anterior
    func _on_caliz_2_body_entered(body: Node2D) -> void:
    	get_tree().change_scene_to_file("res://world.tscn")  # Cambia al nivel 1


REDACTAR DE MANERA DETALLADA POR INTEGRANTE, LAS DIFICULTADES QUE SE TUVIERON AL USAR LAS HERRAMIENTAS COLAVORATIVAS:


Durante el desarrollo del videojuego, me enfrenté a diversas dificultades relacionadas con el uso de herramientas colaborativas. Realizar este trabajo en equipo fue complicado por este motivo. El diseño, la programación, la implementación de escenas, la interfaz gráfica, y las pruebas fueron un desafio para ambos. A continuación, describo los principales retos encontrados:

Godot Engine no tiene un sistema de colaboración en tiempo real como otras herramientas. Esto significa que la edición simultánea de escenas y scripts puede causar conflictos de archivos. Aunque esto no fue un problema directo al trabajar solo, representa una limitación importante en entornos colaborativos, y fue una barrera anticipada al momento de planear el proyecto con equipo.

Al asumir gran parte de estos los roles, enfrenté una sobrecarga de responsabilidades, lo que ralentizó algunas etapas del desarrollo, como la creación de niveles adicionales, pruebas de errores, y ajustes visuales. Esta situación también implicó menos tiempo para usar herramientas colaborativas más complejas, pues era prioritario enfocarme en las tareas esenciales del juego.

UNA BREVE CONCLUSIÓN DEL USO E IMPORTANCIA DE LAS HERRAMIENTAS COLABORATIVAS PARA EL PROGRAMADOR:


Las herramientas colaborativas son fundamentales en el desarrollo de software, especialmente en proyectos de videojuegos donde intervienen múltiples disciplinas como diseño, programación, arte y sonido. Permiten organizar tareas, compartir avances en tiempo real, evitar errores por duplicación y mantener la coherencia del proyecto. Aunque en este caso el trabajo fue individual, la experiencia evidenció que trabajar en equipo de forma eficiente requiere herramientas como control de versiones (GitHub), plataformas compartidas (como Miro), y una buena comunicación. Dominar estas herramientas no solo agiliza el proceso de desarrollo, sino que también prepara al programador para entornos profesionales donde el trabajo en equipo es esencial.


