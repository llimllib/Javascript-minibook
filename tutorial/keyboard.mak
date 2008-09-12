<%namespace name="head" file="head.mak" />
${head.head(610)}
	<div id="explain">To add keyboard input to control our paddle, we need
  to do two things: find out when the left and right arrows have been
  pressed and move the paddle when they have.
  <p>In order to receive key events, we'll create one function called
  onKeyUp and another called onKeyDown, then use a bit of jQuery magic
  to bind them to the appropriate events.
  <p>Then, on our way through the draw function, we'll check to see if
  either arrow is pressed down, and move the paddle accordingly.
  <div id="codebox">
       <textarea id="code" rows=10 cols=50>rightDown = false;
leftDown = false;

function onKeyDown(evt) {
  if (evt.keyCode == 39) rightDown = true;
  else if (evt.keyCode == 37) leftDown = true;
}

function onKeyUp(evt) {
  if (evt.keyCode == 39) rightDown = false;
  else if (evt.keyCode == 37) leftDown = false;
}

$(document).keydown(onKeyDown);
$(document).keyup(onKeyUp);
       
function draw() {
  clear();
  circle(x, y, 10);

  if (rightDown) paddlex += 5;
  else if (leftDown) paddlex -= 5;
  rect(paddlex, HEIGHT-paddleh, paddlew, paddleh);
 
  if (x + dx > WIDTH || x + dx < 0)
	  dx = -dx;

  if (y + dy < 0)
	  dy = -dy;
  else if (y + dy > HEIGHT) {
    if (x > paddlex && x < paddlex + paddlew)
      dy = -dy;
    else
      clearInterval(intervalId);
  }
 
  x += dx;
  y += dy;
}

init();</textarea>
		</div>
		<input type="submit" value="run code" onclick="runCode()"/><br>
		<p>
        Now that we've got a working paddle, animation, and a bouncing ball,
        we've got something close to a game coming together.
		<p>On the next page, we'll move support for the keyboard into the
		library and add support for the mouse in a very similar manner.
	</div>

	   <textarea id="library" style="display: none">
var x = 150;
var y = 150;
var dx = 2;
var dy = 4;
var ctx;
var WIDTH = $("canvas").width()
var HEIGHT = $("canvas").height()
var paddlex = WIDTH / 2;
var paddleh = 10;
var paddlew = 75;
var intervalId = 0;

function circle(x,y,r) {
  ctx.beginPath();
  ctx.arc(x, y, r, 0, Math.PI*2, true);
  ctx.closePath();
  ctx.fill();
}

function rect(x,y,w,h) {
  ctx.beginPath();
  ctx.rect(x,y,w,h);
  ctx.closePath();
  ctx.fill();
}

function clear() {
  ctx.clearRect(0, 0, WIDTH, HEIGHT);
}

function init() {
  ctx = $('#canvas')[0].getContext("2d");
  intervalId = setInterval(draw, 10);
  return intervalId;
}
       </textarea>
${head.next('mouse.html')}