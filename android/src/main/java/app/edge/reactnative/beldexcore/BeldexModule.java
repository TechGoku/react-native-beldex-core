package app.edge.reactnative.beldexcore;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class BeldexModule extends ReactContextBaseJavaModule {
  private native String callBeldexJNI(String method, String arguments);

  static {
    System.loadLibrary("beldex-jni");
  }

  public BeldexModule(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  public String getName() {
    return "BeldexCore";
  }

  @ReactMethod
  public void callBeldex(String method, String arguments, Promise promise) {
    try {
      promise.resolve(callBeldexJNI(method, arguments));
    } catch (Exception e) {
      promise.reject("BeldexError", e);
    }
  }
}
