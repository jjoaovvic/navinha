# scripts/

Código **sem cena**: classes puras referenciadas por `class_name`, não por caminho.

Script que é o controlador de uma cena mora junto do `.tscn` dela
(`entities/player/player.gd` ao lado de `entities/player/player.tscn`),
seguindo a convenção da doc oficial do Godot: organizar por cena, não por
tipo de arquivo.

Aqui ficam só as coisas que **não têm cena**:

- `stats/` - `Resource`s de atributos (vida, armadura, velocidade, inércia)
  e seus modificadores, base do sistema de upgrades.
- autoloads / singletons de projeto
- classes base e utilitários compartilhados

Instâncias concretas (`.tres`) desses recursos ficam junto da entidade que as
usa (ex.: `entities/enemies/pursuer/pursuer_stats.tres`), porque são
exclusivas dela.
