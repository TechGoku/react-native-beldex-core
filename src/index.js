import { NativeModules } from 'react-native'

const native = NativeModules.BeldexCore

export function callBeldex(method, jsonArguments) {
  return native.callBeldex(method, jsonArguments)
}
