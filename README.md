# Duality Maze

A browser adaptation of an ARMv8 bare-metal maze game originally built for Raspberry Pi 3.

The game begins immediately. Guide the player through two alternating worlds, using the golden triggers to switch between maze layouts, and reach the green exit.

## Play

- **Desktop / laptop:** use the arrow keys.
- **Mobile:** use the on-screen directional pad.
- **Restart:** use the Restart button at any time.

There is no timer, pause mode, or move counter.

## Portfolio

Featured on [zipgirl.github.io](https://zipgirl.github.io/projects/).

## Development

Requires Node.js 20 or newer.

```bash
npm install
npm run dev
``

Create a production build with `npm run build`.

## Deployment

The included GitHub Actions workflow deploys the app to GitHub Pages whenever changes are pushed to `main`. In the repository settings, set **Pages → Build and deployment → Source** to **GitHub Actions**.

Once enabled, the project will be available at:

`https://zipgirl.github.io/duality-maze/`

## Project structure

- `src/Game.tsx` — game state, movement, collisions, animation, controls, and victory state.
- `src/mazes.ts` — maze wall rectangles, trigger coordinates, and goal, transcribed from the original assembly.
- `src/style.css` — responsive presentation and mobile controls.
- `original/` — preserved Raspberry Pi ARMv8 assembly sources; the browser port does not execute these files.

The original project used a Makefile and linker script named `memmap`; those two files were not present among the source attachments available for this port, so they have not been reconstructed.
