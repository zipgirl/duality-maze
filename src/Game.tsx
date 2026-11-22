import { useCallback, useEffect, useRef, useState } from "react";
import { cyanWalls, goal, roseWalls, triggerPoints, WORLD_SIZE, type Rect } from "./mazes";

type Direction = "up" | "down" | "left" | "right";
type Point = { x: number; y: number };
const PLAYER_SIZE = 8;
const STEP = 5;
const MOVE_MS = 105;
const keyDirections: Record<string, Direction> = { ArrowUp: "up", ArrowDown: "down", ArrowLeft: "left", ArrowRight: "right" };
const vectors: Record<Direction, Point> = { up: {x:0,y:-STEP}, down:{x:0,y:STEP}, left:{x:-STEP,y:0}, right:{x:STEP,y:0} };
const intersects = (a: Rect, b: Rect) => a[0] < b[1] && a[1] > b[0] && a[2] < b[3] && a[3] > b[2];
const playerRect = (p: Point): Rect => [p.x,p.x+PLAYER_SIZE,p.y,p.y+PLAYER_SIZE];

export function Game() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const stateRef = useRef({ player: {x:20,y:20} as Point, world: 0, won: false, anim: null as null | {from:Point;to:Point;started:number}, activeTrigger: -1 });
  const heldRef = useRef<Set<Direction>>(new Set());
  const [won, setWon] = useState(false);
  const [world, setWorld] = useState(0);
  const [mobile, setMobile] = useState(false);
  const [restartPulse, setRestartPulse] = useState(0);

  const restart = useCallback(() => {
    stateRef.current = { player:{x:20,y:20}, world:0, won:false, anim:null, activeTrigger:-1 };
    heldRef.current.clear(); setWon(false); setWorld(0); setRestartPulse(v=>v+1);
  }, []);

  const move = useCallback((direction: Direction) => {
    const state = stateRef.current;
    if (state.won || state.anim) return;
    const delta = vectors[direction];
    const next = {x:state.player.x+delta.x,y:state.player.y+delta.y};
    if (next.x < 16 || next.y < 16 || next.x+PLAYER_SIZE > 496 || next.y+PLAYER_SIZE > 496) return;
    const walls = state.world === 0 ? roseWalls : cyanWalls;
    if (walls.some(w => intersects(playerRect(next),w))) return;
    state.anim = {from:state.player,to:next,started:performance.now()};
    state.player = next;
  }, []);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext("2d");
    if (!ctx) return;
    let frame = 0;
    const draw = (now: number) => {
      const state = stateRef.current;
      const progress = state.anim ? Math.min(1,(now-state.anim.started)/MOVE_MS) : 1;
      const eased = 1-Math.pow(1-progress,3);
      const p = state.anim ? {x:state.anim.from.x+(state.anim.to.x-state.anim.from.x)*eased,y:state.anim.from.y+(state.anim.to.y-state.anim.from.y)*eased} : state.player;
      if (state.anim && progress >= 1) state.anim = null;
      const isRose = state.world === 0;
      ctx.clearRect(0,0,WORLD_SIZE,WORLD_SIZE);
      ctx.fillStyle = isRose ? "#fff4f8" : "#080b12"; ctx.fillRect(0,0,512,512);
      ctx.fillStyle = isRose ? "#fa52a0" : "#8df9ff";
      for (const [x1,x2,y1,y2] of (isRose ? roseWalls : cyanWalls)) ctx.fillRect(x1,y1,x2-x1,y2-y1);
      // Goal tile remains visible in both worlds.
      ctx.save(); ctx.shadowColor="#75f0a4"; ctx.shadowBlur=18; ctx.fillStyle="#3dca82"; ctx.fillRect(goal[0],goal[2],goal[1]-goal[0],goal[3]-goal[2]); ctx.restore();
      // Small inset mark makes the destination legible over the wall geometry.
      ctx.fillStyle="#eafff2"; ctx.fillRect(244,228,8,8);
      triggerPoints.forEach(([x,y],i) => {
        const cx=x+16, cy=y+16; const active = state.activeTrigger===i;
        ctx.save(); ctx.translate(cx,cy); ctx.shadowColor="#ffd76a"; ctx.shadowBlur=active?4:12;
        ctx.fillStyle="#ffd76a"; ctx.beginPath(); ctx.moveTo(0,-10); ctx.lineTo(10,0); ctx.lineTo(0,10); ctx.lineTo(-10,0); ctx.closePath(); ctx.fill();
        ctx.fillStyle="#fff5d1"; ctx.fillRect(-2,-2,4,4); ctx.restore();
      });
      // Character: a compact, animated little diamond with a soft shadow.
      ctx.save(); ctx.translate(p.x+PLAYER_SIZE/2,p.y+PLAYER_SIZE/2); ctx.shadowColor=isRose?"#7a1748":"#8df9ff"; ctx.shadowBlur=12;
      ctx.fillStyle=isRose?"#21101b":"#f5ffff"; ctx.beginPath(); ctx.roundRect(-4,-4,8,8,2); ctx.fill(); ctx.restore();
      // Check trigger overlap after movement; latch until the player leaves its field.
      const triggerIndex = triggerPoints.findIndex(([x,y]) => p.x+PLAYER_SIZE/2 >= x+7 && p.x+PLAYER_SIZE/2 <= x+25 && p.y+PLAYER_SIZE/2 >= y+7 && p.y+PLAYER_SIZE/2 <= y+25);
      if (triggerIndex < 0) state.activeTrigger=-1;
      else if (state.activeTrigger !== triggerIndex && !state.anim) { state.activeTrigger=triggerIndex; state.world=1-state.world; setWorld(state.world); }
      if (!state.won && intersects(playerRect(p),goal)) { state.won=true; setWon(true); heldRef.current.clear(); }
      frame=requestAnimationFrame(draw);
    };
    frame=requestAnimationFrame(draw);
    return () => cancelAnimationFrame(frame);
  }, [restartPulse]);

  useEffect(() => {
    const down = (event: KeyboardEvent) => {
      const direction=keyDirections[event.key];
      if (!direction) return;
      event.preventDefault(); heldRef.current.add(direction); move(direction);
    };
    const up = (event: KeyboardEvent) => { const direction=keyDirections[event.key]; if(direction) heldRef.current.delete(direction); };
    window.addEventListener("keydown",down); window.addEventListener("keyup",up);
    const detect=()=>setMobile(window.matchMedia("(pointer: coarse)").matches || window.innerWidth<760);
    detect(); window.addEventListener("resize",detect);
    return()=>{window.removeEventListener("keydown",down);window.removeEventListener("keyup",up);window.removeEventListener("resize",detect);};
  }, [move]);

  useEffect(() => {
    const timer=window.setInterval(()=>{
      if (stateRef.current.anim || stateRef.current.won) return;
      const order:Direction[]=["up","down","left","right"];
      for (const direction of order) if (heldRef.current.has(direction)) { move(direction); break; }
    },125);
    return()=>window.clearInterval(timer);
  },[move]);

  const press=(direction:Direction)=>{heldRef.current.add(direction);move(direction);};
  const release=(direction:Direction)=>heldRef.current.delete(direction);
  return <main className="page-shell">
    <header className="topbar"><a className="wordmark" href="#" aria-label="Duality Maze home">DUALITY<span> / </span>MAZE</a><button className="restart-button" onClick={restart}><span aria-hidden="true">↻</span> Restart</button></header>
    <section className="game-layout">
      <div className="intro"><p className="eyebrow">TWO WORLDS · ONE WAY OUT</p><h1>Find your way<br/><em>through duality.</em></h1><p className="description">Cross between two mirrored realities. Every golden mark shifts the maze beneath your feet.</p><div className="world-key"><span className={world===0?"active rose":"rose"}></span><span>Rose world</span><span className={world===1?"active cyan":"cyan"}></span><span>Azure world</span></div></div>
      <div className="play-area"><div className={"board-frame "+(world===0?"rose-frame":"cyan-frame")}><canvas ref={canvasRef} width={512} height={512} aria-label="Duality Maze game board"/>{won&&<div className="victory-overlay"><div className="victory-card"><span className="victory-spark">✦</span><p className="eyebrow">THE WORLDS ARE YOURS</p><h2>You made it.</h2><p>Two realities. One impossible maze. You found the way through.</p><button onClick={restart}>Play again <span>↗</span></button></div></div>}</div><p className="board-caption"><span>{world===0?"01 — ROSE REALITY":"02 — AZURE REALITY"}</span><span>512 × 512 FIELD</span></p></div>
    </section>
    <footer className="controls-footer"><div className="desktop-hint"><span className="keycap">↑</span><span className="keycap">←</span><span className="keycap">↓</span><span className="keycap">→</span><span>Use arrow keys to move</span></div><div className="mobile-hint">Touch controls <span>·</span> Find the green exit</div><div className="credit">AN ARMv8 MAZE, REIMAGINED FOR THE WEB</div></footer>
    {mobile&&<div className="touch-pad" aria-label="Touch movement controls"><button className="up" onPointerDown={()=>press("up")} onPointerUp={()=>release("up")} onPointerLeave={()=>release("up")} onPointerCancel={()=>release("up")} aria-label="Move up">↑</button><button className="left" onPointerDown={()=>press("left")} onPointerUp={()=>release("left")} onPointerLeave={()=>release("left")} onPointerCancel={()=>release("left")} aria-label="Move left">←</button><button className="down" onPointerDown={()=>press("down")} onPointerUp={()=>release("down")} onPointerLeave={()=>release("down")} onPointerCancel={()=>release("down")} aria-label="Move down">↓</button><button className="right" onPointerDown={()=>press("right")} onPointerUp={()=>release("right")} onPointerLeave={()=>release("right")} onPointerCancel={()=>release("right")} aria-label="Move right">→</button></div>}
  </main>;
}
