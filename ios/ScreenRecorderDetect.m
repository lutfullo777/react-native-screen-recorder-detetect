// ScreenRecorderDetect.m

#import "ScreenRecorderDetect.h"
#import "React/RCTLog.h"

float const kScreenRecordingDetectorTimerInterval = 1.0;
NSString *kScreenRecordingDetectorRecordingStatusChangedNotification = @"kScreenRecordingDetectorRecordingStatusChangedNotification";

@interface ScreenRecordingDetector()

@property BOOL lastRecordingState;
@property NSTimer *timer;

@end

@implementation ScreenRecordingDetector

+ (instancetype)sharedInstance {
  static ScreenRecordingDetector *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}
- (id)init {
  if (self = [super init]) {
    // do some init stuff here..
    self.lastRecordingState = NO; // initially the recording state is 'NO'. This is the default state.
    self.timer = NULL;
  }
  return self;
}
- (BOOL)isRecording {
  for (UIScreen *screen in UIScreen.screens) {
    if ([screen respondsToSelector:@selector(isCaptured)]) {
      // iOS 11+ has isCaptured method.
      if ([screen performSelector:@selector(isCaptured)]) {
        return YES; // screen capture is active
      } else if (screen.mirroredScreen) {
        return YES; // mirroring is active
      }
    } else {
      // iOS version below 11.0
      if (screen.mirroredScreen)
        return YES;
    }
  }
  return NO;
}
+ (void)triggerDetectorTimer {
  
  ScreenRecordingDetector *detector = [ScreenRecordingDetector sharedInstance];
  if (detector.timer) {
    [self stopDetectorTimer];
  }
  detector.timer = [NSTimer scheduledTimerWithTimeInterval:kScreenRecordingDetectorTimerInterval
                                                    target:detector
                                                  selector:@selector(checkCurrentRecordingStatus:)
                                                  userInfo:nil
                                                   repeats:YES];
}
- (void)checkCurrentRecordingStatus:(NSTimer *)timer {
  BOOL isRecording = [self isRecording];
  if (isRecording != self.lastRecordingState) {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName: kScreenRecordingDetectorRecordingStatusChangedNotification object:nil];
  }
  self.lastRecordingState = isRecording;
}
+ (void)stopDetectorTimer {
  ScreenRecordingDetector *detector = [ScreenRecordingDetector sharedInstance];
  if (detector.timer) {
    [detector.timer invalidate];
    detector.timer = NULL;
  }
}
@end

@implementation ScreenRecorderDetect

RCT_EXPORT_MODULE();
// We can send back a promise to our JavaScript environment :)
RCT_REMAP_METHOD(get,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  NSString* recordOK = @"YES";
  NSString* pasDerecordOK = @"NO";
  
  if ([[ScreenRecordingDetector sharedInstance] isRecording]) {
    resolve(recordOK);
  } else {
    resolve(pasDerecordOK);
  }
  
}

ScreenRecordingDetector *screenRecordingDetector(void);

@end