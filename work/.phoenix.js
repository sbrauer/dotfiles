var PADDING = 0;

Array.prototype.isEmpty = function() {
  return this.length === 0;
}

Array.prototype.circularLookup = function(index) {
  if (index < 0)
    return this[this.length + (index % this.length)];
  return this[index % this.length];
}

//////////////////////////////
// MousePosition extensions //
//////////////////////////////

MousePosition.centerOn = function(point, rect) {
  MousePosition.restore({
    x: point.x + (rect.width  / 2),
    y: point.y + (rect.height / 2)
  });
}

MousePosition.centerOnWindow = function(window) {
  var size = window.size(),
      topLeft = window.topLeft();

  MousePosition.centerOn(topLeft, size);
}

//////////////////////
// Window extension //
//////////////////////

var lastFrames = {};

Window.prototype.rememberFrame = function() {
  lastFrames[this] = this.frame();
}

Window.prototype.forgetFrame = function() {
  delete lastFrames[this];
}

Window.prototype.rollbackFullscreen = function() {
  this.setFrame(lastFrames[this]);
  this.forgetFrame();
}

Window.prototype.toFullscreen = function() {
  this.rememberFrame();
  this.toGrid(0, 0, 1, 1);
}

Window.prototype.toggleFullscreen = function() {
  if (lastFrames[this]) {
    this.rollbackFullscreen();
  } else {
    this.toFullscreen();
  }
  return this;
}

// This method can be used to push a window to a certain position and size on
// the screen by using four floats instead of pixel sizes.  Examples:
//
//     // Window position: top-left; width: 25%, height: 50%
//     someWindow.toGrid( 0, 0, 0.25, 0.5 );
//
//     // Window position: 30% top, 20% left; width: 50%, height: 35%
//     someWindow.toGrid( 0.3, 0.2, 0.5, 0.35 );
//
// The window will be automatically focused.  Returns the window instance.
Window.prototype.toGrid = function(x, y, width, height) {
  var screen = this.screen().frameWithoutDockOrMenu();

  this.setFrame({
    x:      Math.round( x *      screen.width )  + PADDING + screen.x,
    y:      Math.round( y *      screen.height ) + PADDING + screen.y,
    width:  Math.round( width *  screen.width )  - ( 2 * PADDING ),
    height: Math.round( height * screen.height ) - ( 2 * PADDING )
  });

  return this;
}

Window.prototype.moveToScreen = function(screen) {
  if (!screen) return;

  var frame = this.frame(),

      oldScreenRect = this.screen().frameWithoutDockOrMenu(),
      newScreenRect = screen.frameWithoutDockOrMenu(),

      xRatio = newScreenRect.width / oldScreenRect.width,
      yRatio = newScreenRect.height / oldScreenRect.height;

  this.setFrame({
    x: (Math.round(frame.x - oldScreenRect.x) * xRatio) + newScreenRect.x,
    y: (Math.round(frame.y - oldScreenRect.y) * yRatio) + newScreenRect.y,
    width: Math.round(frame.width * xRatio),
    height: Math.round(frame.height * yRatio)
  });

  return this;
}

Window.prototype.centerCursor = function() {
  MousePosition.centerOnWindow(this);
  return this;
}

Window.prototype.allScreens = function() {
  var currentScreen = this.screen(),
      allScreens = [currentScreen];

  for (var s = currentScreen.nextScreen(); s != this.screen(); s = s.nextScreen()) {
    allScreens.push(s);
  }

  allScreens = _(allScreens).sortBy(function(s) { return s.frameWithoutDockOrMenu().x; });

  return allScreens;
};

Window.prototype.rotateMonitors = function(offset) {
  var allScreens = this.allScreens(),
      currentScreen = this.screen(),
      currentScreenIndex = allScreens.indexOf(currentScreen),
      newScreen = allScreens.circularLookup(currentScreenIndex + offset);

  this.moveToScreen(newScreen).centerCursor();
}

Window.prototype.leftOneMonitor = function() {
  this.rotateMonitors(-1);
}

Window.prototype.rightOneMonitor = function() {
  this.rotateMonitors(1);
}

////////////////////
// App Extensions //
////////////////////

var appStateSnapshots = {};
var savedTitle = undefined;

App.allWithTitle = function(title) {
  return _(this.runningApps()).filter(function(app) {
    return app.title() === title;
  });
};

App.focusOrStart = function (title) {
  var apps = App.allWithTitle(title),
      restoreCursor = false,
      previouslyStartedAnotherApp = (savedTitle !== title),
      previouslyStartedThisApp = (savedTitle === title && appStateSnapshots[title]);

  if (previouslyStartedAnotherApp || previouslyStartedThisApp)
    appStateSnapshots[savedTitle] = MousePosition.capture();

  if (appStateSnapshots[title]) {
    restoreCursor = true;
    MousePosition.restore(appStateSnapshots[title]);
  }

  savedTitle = title;

  if (apps.isEmpty()) {
    api.alert("> Starting " + title + " ...");
    api.launch(title);
    return;
  }

  var activeWindows = _.chain(apps)
    .map(function(x) { return x.allWindows(); })
    .flatten()
    .reject(function(win) { return win.isWindowMinimized(); })
    .value();

  activeWindows.forEach(function(window) {
    window.focusWindow();
    if (!restoreCursor) window.centerCursor();
  });

  // Either has minimized windows, or no windows
  // (apps can be open, but have no windows)
  if (activeWindows.isEmpty()) api.launch(title);
};

App.prototype.findWindow = function(findBy) {
  return _.find(this.visibleWindows(), findBy);
};

App.prototype.findWindowMatchingTitle = function(title) {
  var regexp = new RegExp(title);

  return this.findWindow(function(win) {
    return regexp.test(win.title());
  });
};

App.prototype.findWindowNotMatchingTitle = function(title) {
  var regexp = new RegExp(title);

  return this.findWindow(function(win) {
    return !regexp.test(win.title());
  });
};

///////////////////////////
// Convenience functions //
///////////////////////////

var leftHalf = function() { Window.focusedWindow().toGrid(0, 0, 0.5, 1).centerCursor(); };
var rightHalf = function() { Window.focusedWindow().toGrid(0.5, 0, 0.5, 1).centerCursor(); };
var leftUpper = function() { Window.focusedWindow().toGrid(0, 0, 0.5, 0.5).centerCursor(); };
var rightUpper = function() { Window.focusedWindow().toGrid(0.5, 0, 0.5, 0.5).centerCursor(); };
var leftLower = function() { Window.focusedWindow().toGrid(0, 0.5, 0.5, 0.5).centerCursor(); };
var rightLower = function() { Window.focusedWindow().toGrid(0.5, 0.5, 0.5, 0.5).centerCursor(); };

var rightOneThird = function() { Window.focusedWindow().toGrid(0.666, 0, 0.333, 1).centerCursor(); };
var leftOneThird = function() { Window.focusedWindow().toGrid(0, 0, 0.333, 1).centerCursor(); };
var rightTwoThirds = function() { Window.focusedWindow().toGrid(0.333, 0, 0.666, 1).centerCursor(); };
var leftTwoThirds = function() { Window.focusedWindow().toGrid(0, 0, 0.666, 1).centerCursor(); };

var rightUpperOneThird = function() { Window.focusedWindow().toGrid(0.666, 0, 0.333, 0.5).centerCursor(); };
var leftUpperOneThird = function() { Window.focusedWindow().toGrid(0, 0, 0.333, 0.5).centerCursor(); };
var rightUpperTwoThirds = function() { Window.focusedWindow().toGrid(0.333, 0, 0.666, 0.5).centerCursor(); };
var leftUpperTwoThirds = function() { Window.focusedWindow().toGrid(0, 0, 0.666, 0.5).centerCursor(); };

var rightLowerOneThird = function() { Window.focusedWindow().toGrid(0.666, 0.5, 0.333, 0.5).centerCursor(); };
var leftLowerOneThird = function() { Window.focusedWindow().toGrid(0, 0.5, 0.333, 0.5).centerCursor(); };
var rightLowerTwoThirds = function() { Window.focusedWindow().toGrid(0.333, 0.5, 0.666, 0.5).centerCursor(); };
var leftLowerTwoThirds = function() { Window.focusedWindow().toGrid(0, 0.5, 0.666, 0.5).centerCursor(); };

var centerWindow = function() { Window.focusedWindow().toGrid(0.15, 0, 0.7, 1).centerCursor(); };

var toggleFullscreen = function() { Window.focusedWindow().toggleFullscreen().centerCursor(); };
var centerCursor = function() { Window.focusedWindow().centerCursor(); };

var rightOneMonitor = function() { Window.focusedWindow().rightOneMonitor(); };
var leftOneMonitor = function() { Window.focusedWindow().leftOneMonitor();  };

/////////////////
// Keybindings //
/////////////////

// Modifier combos
var MASH  = ['cmd', 'alt', 'ctrl'         ];
var SUPER = ['cmd', 'alt',         'shift'];
var HYPER = ['cmd',        'ctrl', 'shift'];
var META  = [       'alt', 'ctrl', 'shift'];
var SMASH = ['cmd', 'alt', 'ctrl', 'shift'];

api.bind('up', MASH, rightOneMonitor);
api.bind('down', MASH, leftOneMonitor);
// Alternatives:
api.bind('=', MASH, rightOneMonitor);
api.bind('-', MASH, leftOneMonitor);

api.bind('left', MASH, leftHalf);
api.bind('right', MASH, rightHalf);
// Alternatives:
api.bind('[', MASH, leftHalf);
api.bind(']', MASH, rightHalf);

api.bind('return', MASH, toggleFullscreen);
api.bind('.', MASH, centerCursor);

api.bind('1', MASH, leftUpper);
api.bind('2', MASH, leftLower);
api.bind('3', MASH, rightLower);
api.bind('4', MASH, rightUpper);
api.bind('5', MASH, leftOneThird);
api.bind('6', MASH, leftTwoThirds);
api.bind('7', MASH, rightTwoThirds);
api.bind('8', MASH, rightOneThird);
api.bind('0', MASH, centerWindow);

// Apps for work
api.bind('c', MASH, function() { App.focusOrStart('Calculator'); });
api.bind('f', MASH, function() { App.focusOrStart('Finder'); });
api.bind('f', SUPER, function() { App.focusOrStart('Firefox'); });
api.bind('g', MASH, function() { App.focusOrStart('Google Chrome'); });
//api.bind('h', MASH, function() { App.focusOrStart('HipChat'); });
api.bind('i', MASH, function() { App.focusOrStart('iTunes'); });
api.bind('k', MASH, function() { App.focusOrStart('Slack'); });
api.bind('m', MASH, function() { App.focusOrStart('Mailplane 3'); });
// api.bind('p', MASH, function() { App.focusOrStart('Propane'); });
api.bind('p', MASH, function() { App.focusOrStart('Password Gorilla'); });
// api.bind('r', MASH, function() { App.focusOrStart('Rdio'); });
api.bind('s', MASH, function() { App.focusOrStart('Sococo'); });
api.bind('s', SUPER, function() { App.focusOrStart('Safari'); });
api.bind('s', SMASH, function() { App.focusOrStart('Spotify'); });
api.bind('t', MASH, function() { App.focusOrStart('iTerm 2'); });
api.bind('v', MASH, function() { App.focusOrStart('VLC'); });

