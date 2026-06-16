// Build a desktop wallpaper whose top edge is solid black, so the menu bar reads
// as black (camouflaging the notch / giving a clean black bar). Pure AppKit, no
// dependencies. Crops SRC to the main display's aspect ratio (centred) and paints
// a black bar sized to the menu bar across the top.
//
// Env: SRC (input image), DST (output jpg), MENU_BAR_POINTS (optional override of
// the auto-detected menu-bar height, in points).
//
// Run: SRC=in.jpg DST=out.jpg osascript -l JavaScript generate-wallpaper.js
ObjC.import('AppKit');

var env = $.NSProcessInfo.processInfo.environment;
var src = ObjC.unwrap(env.objectForKey('SRC'));
var dst = ObjC.unwrap(env.objectForKey('DST'));

var screen = $.NSScreen.mainScreen;
if (screen.isNil()) throw new Error('no main display (need a logged-in GUI session)');
var screenW = screen.frame.size.width;
var screenH = screen.frame.size.height;

// Menu-bar height in points: the gap the visibleFrame leaves at the top of the
// frame. Works on notched and non-notched displays. Overridable via env.
var override = parseFloat(ObjC.unwrap(env.objectForKey('MENU_BAR_POINTS')));
var vf = screen.visibleFrame;
var menuBarPoints = (override > 0) ? override
  : (screen.frame.origin.y + screenH) - (vf.origin.y + vf.size.height);

var srcImg = $.NSImage.alloc.initWithContentsOfFile(src);
if (srcImg.isNil()) throw new Error('cannot read ' + src);
var rep0 = srcImg.representations.objectAtIndex(0);
var srcW = rep0.pixelsWide;
var srcH = rep0.pixelsHigh;
srcImg.setSize($.NSMakeSize(srcW, srcH)); // ignore embedded DPI; work in pixels

// Crop the source to the display's aspect ratio (centred), trimming only the
// over-long dimension — no scaling or distortion. This is the one crop the user
// allows: just enough to match the screen's aspect.
var targetAspect = screenW / screenH;
var cropW = srcW;
var cropH = srcH;
if (srcW / srcH > targetAspect) {
  cropW = Math.round(srcH * targetAspect); // source wider than display -> trim width
} else {
  cropH = Math.round(srcW / targetAspect); // source taller than display -> trim height
}
var fromX = Math.round((srcW - cropW) / 2);
var fromY = Math.round((srcH - cropH) / 2);
var bar = Math.max(1, Math.round(cropH * menuBarPoints / screenH));

var out = $.NSBitmapImageRep.alloc
  .initWithBitmapDataPlanesPixelsWidePixelsHighBitsPerSampleSamplesPerPixelHasAlphaIsPlanarColorSpaceNameBytesPerRowBitsPerPixel(
    $(), cropW, cropH, 8, 4, true, false, $.NSDeviceRGBColorSpace, 0, 0);
out.setSize($.NSMakeSize(cropW, cropH));

$.NSGraphicsContext.saveGraphicsState;
$.NSGraphicsContext.setCurrentContext(
  $.NSGraphicsContext.graphicsContextWithBitmapImageRep(out));

// Cocoa origin is bottom-left. Draw the centred band, then the top bar.
srcImg.drawInRectFromRectOperationFraction(
  $.NSMakeRect(0, 0, cropW, cropH),
  $.NSMakeRect(fromX, fromY, cropW, cropH),
  $.NSCompositingOperationCopy, 1.0);
$.NSColor.blackColor.set;
$.NSBezierPath.fillRect($.NSMakeRect(0, cropH - bar, cropW, bar));

$.NSGraphicsContext.restoreGraphicsState;

var props = $.NSDictionary.dictionaryWithObjectForKey(
  $.NSNumber.numberWithDouble(0.92), $.NSImageCompressionFactor);
var jpeg = out.representationUsingTypeProperties($.NSBitmapImageFileTypeJPEG, props);
if (!jpeg.writeToFileAtomically(dst, true)) throw new Error('cannot write ' + dst);
"OK: " + cropW + "x" + cropH + " bar=" + bar + " (screen " + screenW + "x" + screenH + ")";
