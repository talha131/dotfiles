-- multi monitor
hs.hotkey.bind(hyper, 'N', hs.grid.pushWindowNextScreen)
hs.hotkey.bind(hyper, 'P', hs.grid.pushWindowPrevScreen)

-- move windows
hs.hotkey.bind(hyper, 'H', hs.grid.pushWindowLeft)
hs.hotkey.bind(hyper, 'J', hs.grid.pushWindowDown)
hs.hotkey.bind(hyper, 'K', hs.grid.pushWindowUp)
hs.hotkey.bind(hyper, 'L', hs.grid.pushWindowRight)

-- resize windows
hs.hotkey.bind(hyper, 'Y', hs.grid.resizeWindowThinner)
hs.hotkey.bind(hyper, 'U', hs.grid.resizeWindowShorter)
hs.hotkey.bind(hyper, 'I', hs.grid.resizeWindowTaller)
hs.hotkey.bind(hyper, 'O', hs.grid.resizeWindowWider)

-- grid
hs.hotkey.bind(hyper, 'G', hs.grid.show)

-- Window Hints
hs.hotkey.bind(hyper, 'A', hs.hints.windowHints)

