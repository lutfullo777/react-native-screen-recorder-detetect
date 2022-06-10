import { useEffect } from 'react';
import { AppState, NativeModules, Platform } from 'react-native';

const { ScreenRecorderDetect } = NativeModules;


const ScreenDetect = (props) => {
    useEffect(() => {
        if (Platform.OS == "ios") {
            AppState.addEventListener("change", _handleAppStateChange);
            checkIfRecord();
            return () => {
                AppState.removeEventListener("change", _handleAppStateChange);
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
    }

    const _handleAppStateChange = async (nextAppState) => {
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
}


export {
    ScreenRecorderDetect,
}
export default ScreenDetect;
