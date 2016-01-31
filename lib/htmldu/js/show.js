function formatBlocks(blocks) {
    var unit = 'k'
    var num = blocks / 2;
    if (num > 512) {
        num /= 1024;
        unit = 'M'
    }
    if (num > 512) {
        num /= 1024
        unit = 'G'
    }
    return num.toFixed(1) + unit
}

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
    
    ctx.font = '16px sans-serif'
    ctx.fillStyle = dirtree.accurate ? 'rgb(0,0,0)' : 'rgb(192, 0, 0)'
    ctx.fillText(formatBlocks(dirtree.blocks) + "(" +  dirtree.name + ")", left + 1, top + 16, width)


    ctx.restore()
    var y = top
    var children = dirtree.children.sort(function (a, b) {
        return b.blocks - a.blocks
    })
    for (var i = 0; i < children.length; i++) {
        var child = children[i]
        var h = height * child.blocks / dirtree.blocks
        subdraw(ctx, child, left + width, width, y, h)
        y += h
    }
}

function draw(canvas, dirtree) {
    var ctx = canvas.getContext('2d')
    subdraw(ctx, dirtree, 10, 200, 10, 800)
}

var canvas = document.createElement('canvas')
canvas.setAttribute('width', '800')
canvas.setAttribute('height', '800')
document.body.insertBefore(canvas, null)
draw(canvas, dirtree)
