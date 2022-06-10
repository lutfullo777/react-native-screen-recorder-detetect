"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = exports.ScreenRecorderDetect = void 0;

var _react = require("react");

var _reactNative = require("react-native");

const {
  ScreenRecorderDetect
} = _reactNative.NativeModules;
exports.ScreenRecorderDetect = ScreenRecorderDetect;

const ScreenDetect = props => {
  (0, _react.useEffect)(() => {
    if (_reactNative.Platform.OS == "ios") {
      _reactNative.AppState.addEventListener("change", _handleAppStateChange);

      checkIfRecord();
      return () => {
        _reactNative.AppState.removeEventListener("change", _handleAppStateChange);
      };
    }
  }, [props]);

  const checkIfRecord = () => {
    try {
      ScreenRecorderDetect.get().then(isRecord => {
        console.log('isRecord', isRecord);

        if (isRecord && isRecord == "YES") {
          if (props.Detect) {
            props.Detect(isRecord);
          }
        } else {
          props.Detect(isRecord);
        }
      });
    } catch (e) {
      console.error(e);
    }
  };

  const _handleAppStateChange = async nextAppState => {
    let interve = setInterval(() => {
      checkIfRecord();
    }, 1000);
    setTimeout(() => {
      if (interve != null) {
        clearInterval(interve);
      }
    }, 5000);
  };

  return null;
};

var _default = ScreenDetect;
exports.default = _default;
//# sourceMappingURL=index.js.map