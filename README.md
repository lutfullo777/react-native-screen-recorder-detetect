# react-native-screen-recorder-detect

## Only Ios

## Getting started

`$ npm install react-native-screen-recorder-detect --save`

### Mostly automatic installation

`$ react-native link react-native-screen-recorder-detect`

## Usage
```javascript
import ScreenRecorderDetect from 'react-native-screen-recorder-detect';

<ScreenDetect
    Detect={(val) => {
        // val => YES|NO
        if (val == "YES") {
        setModalVisible(true);
        } else {
        setModalVisible(false);
        }
    }}
/>
```
