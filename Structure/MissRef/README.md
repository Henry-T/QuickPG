MissRef测试

这个问题与lua的扩展性与内存管理有关。

Quick-x官网有如下片段 -- 如何避免丢失 C++ 对象的自定义属性
http://quick.cocoachina.com/wiki/doku.php?id=zh_cn:faq

传递到 Lua 中的 C++ 对象是用一个 Lua 值保存的，当这个值不再被任何 Lua 代码使用时就会被自动回收（即便这个时候 C++ 对象本身还在内存中）。
function HelloScene:ctor()
    local title = display.newSprite("Title.png")
    title:setTag(110)
    title.filename = "Title.png"
    self:addChild(title)
end

title是local的，一旦在再次使用前GC，lua部分也就是filename属性随之丢失。除非将title改为被外部引用。

这里有个问题，文档中说，lua被删除的部分叫做“peertable”。这个peertable究竟是什么？这个问题且不论，因为它是由解决方案的，我们先看下一个案例。


我遇到的是一个与之相似的另一问题。clone后自定义数据丢失。可以确定的是clone前模板的peertable肯定存在。那么问题就指向了CCNode::clone()，是否因为clone(另一个方案pushDefaultModel也有相同问题)是C++方法，因此也没有对peertable做拷贝？

