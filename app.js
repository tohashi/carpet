(function(window, undefined) {

    var canvas = document.querySelector('canvas'),
        ctx = canvas.getContext('2d'),
        width = canvas.width = screen.width,
        height = canvas.height = screen.height,
        squareLength = Math.min(width, height),
        FPS = 60,
        MIN_LENGTH = 1,
        requestAnimationFrame;

    requestAnimationFrame = (function(){
        return window.requestAnimationFrame    ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame    ||
            window.oRequestAnimationFrame      ||
            window.msRequestAnimationFrame     ||
            function(callback, element){
                window.setTimeout(callback, 1000 / FPS);
            };
    })();

    ctx.rect(0, 0, squareLength, squareLength);
    ctx.fill();

    function hollow(lastLength, baseLength) {
        var length = Math.floor(lastLength/3),
            startX, startY;

        if (length < MIN_LENGTH) {
            return;
        }
        for (var i = 0; i < 3; i++) {
            for (var j = 0; j < 3; j++) {
                startX = length + (i * lastLength);
                startY = length + (j * lastLength);
                if ((i === 1 && j === 1) ||
                    (startX > baseLength || startY > baseLength)) {
                    continue;
                }
                ctx.clearRect(startX, startY, length, length);
            }
        }
        hollow(length, lastLength);
    }

    hollow(squareLength, squareLength);

})(window);
