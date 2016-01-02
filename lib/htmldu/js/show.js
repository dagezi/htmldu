function subdraw(ctx, dirtree, left, width, top, height) {
    ctx.save()
    ctx.strokeRect(left, top, width, height)
    ctx.beginPath()
    ctx.moveTo(left, top)
    ctx.lineTo(left + width, top)
    ctx.lineTo(left + width, top + height)
    ctx.lineTo(left, top + height)
    ctx.closePath()
    ctx.clip()
    
    ctx.fillText(dirtree.name, left + 1, top + 16, width)
    ctx.fillText(dirtree.blocks, left + 1, top + 33, width)

    ctx.restore()
    var y = top
    for (var i = 0; i < dirtree.children.length; i++) {
        var child = dirtree.children[i]
        var h = height * child.blocks / dirtree.blocks
        subdraw(ctx, child, left + width, width * 0.75, y, h)
        y += h
    }
}

function draw(canvas, dirtree) {
    var ctx = canvas.getContext('2d')
    subdraw(ctx, dirtree, 10, 100, 10, 800)
}

var canvas = document.createElement('canvas')
canvas.setAttribute('width', '500')
canvas.setAttribute('height', '800')
document.body.insertBefore(canvas, null)
draw(canvas, dirtree)
