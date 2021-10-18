package com.ehealthsystem.user


import android.Manifest
import android.app.Dialog
import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.telephony.TelephonyManager
import android.view.View
import android.view.Window
import android.widget.Button
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.eHealthSystem/goAnotherApp"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {

            }else if (call.method == "callUrl") {
                //val intent = Intent(this, WebViewActivity::class.java)
                //intent.putExtra("key", value)
                //startActivity(intent)
            } else if (call.method == "deviceId") {
                var value = getIMEIDeviceId(this@MainActivity)
                if (value != null)
                    result.success(value)
                else
                    result.success("Nothing getting")

            } else if (call.method == "iLab") {

                var isAppInstalled = appInstalledOrNot("ilabmini.in.ilab")
                if (isAinaPackageAvailable(this@MainActivity)) {
                    if (isAppInstalled) {
                        val string: String = call.arguments as String
                        val data: List<String> = string.split(",")
                        val LaunchIntent = packageManager
                                .getLaunchIntentForPackage("ilabmini.in.ilab")
                        LaunchIntent!!.action = Intent.ACTION_SEND
                        LaunchIntent.putExtra(Intent.EXTRA_TEXT, "1")
                        LaunchIntent.putExtra("apid", "8036d1868bd71fb6b500cb18eeec3936")
                        LaunchIntent.putExtra("puniqueid", data.get(0))
                        LaunchIntent.putExtra("name", data.get(1))
                        LaunchIntent.putExtra("mobile", data.get(2))
                        LaunchIntent.putExtra("gender", data.get(3))
                        LaunchIntent.putExtra("height", data.get(4))
                        LaunchIntent.putExtra("weight", data.get(5))
                        LaunchIntent.putExtra("age", data.get(6))
                        LaunchIntent.type = "text/plain"
                        //startActivity(LaunchIntent)

                        Toast.makeText(this@MainActiivty, "Height: "+data.get(4)+" Weight: "+data.get(5), Toast.LENGTH_SHORT).show()

                    } else {
                        val string: String = call.arguments as String
                        val data: List<String> = string.split(",")
                        Toast.makeText(this@MainActiivty, "Height: "+data.get(4)+" Weight: "+data.get(5), Toast.LENGTH_SHORT).show()
                        redirectToPlayStore()

                        // Do whatever we want to do if application not installed
                        // For example, Redirect to play store

                        // Log.i("Application is not currently installed.");
                    }
                } else {
                    val string: String = call.arguments as String
                    val data: List<String> = string.split(",")
                    Toast.makeText(this@MainActiivty, "Height: "+data.get(4)+" Weight: "+data.get(5), Toast.LENGTH_SHORT).show()

//                    var dialog = Dialog(this@MainActivity)
//                    dialog.requestWindowFeature(Window.FEATURE_NO_TITLE) //before
//                    dialog.setContentView(R.layout.noapkdialog)
//                    val downloadbtn: Button = dialog.findViewById(R.id.downloadbtn) as Button
//                    /*downloadbtn.setOnClickListener(object : View.OnClickListener() {
//                        fun onClick(view: View?) {
//                            redirectToPlayStore()
//                            //   Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=com.janacare.aina.production"));
//                            // startActivity(intent);
//                        }
//                    })*/
//                    downloadbtn.setOnClickListener(object : View.OnClickListener {
//                        override fun onClick(view: View?) {
//                            // Do some work here
//                            redirectToPlayStore()
//                        }
//
//                    })
//                    val cancelbtn: Button = dialog.findViewById(R.id.cancelbtn) as Button
//                    cancelbtn.setOnClickListener(object : View.OnClickListener {
//                        override fun onClick(view: View?) {
//                            dialog.dismiss()
//                        }
//                    })
//                    dialog.show()
                }

            } else {
                result.notImplemented()
            }
        }
    }


    fun redirectToPlayStore() {
        val url = "https://drive.google.com/file/d/1iB4IUeT4vOV9lCRiEwilbHLYA-DBlgJ2/view?usp=sharing"
        // String url="https://drive.google.com/file/d/1cDKAENDCdOOzyk9jwOtHjRs8gE3PVxW8/view?usp=sharing";
        val i = Intent(Intent.ACTION_VIEW)
        i.data = Uri.parse(url)
        startActivity(i)
    }

    private fun appInstalledOrNot(uri: String): Boolean {
        val pm: PackageManager = packageManager
        try {
            pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES)
            return true
        } catch (e: PackageManager.NameNotFoundException) {
        }
        return false
    }

    fun isAinaPackageAvailable(context: Context): Boolean {
        val packages: List<ApplicationInfo>
        val pm: PackageManager
        pm = context.getPackageManager()
        packages = pm.getInstalledApplications(0)
        for (packageInfo in packages) {
            if (packageInfo.packageName.contains("ilabmini.in.ilab")) {
                return true
            }
        }
        return false
    }

    fun getIMEIDeviceId(context: Context): String? {
        var deviceId: String
        deviceId = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
        } else {
            val mTelephony = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if (context.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) !=
                        PackageManager.PERMISSION_GRANTED) {
                    return ""
                }
            }
            //assert mTelephony != null;
            if (mTelephony.deviceId != null) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    mTelephony.imei
                } else {
                    mTelephony.deviceId
                }
            } else {
                Settings.Secure.getString(context.contentResolver,
                        Settings.Secure.ANDROID_ID)
            }
        }
        if (deviceId == "" || deviceId==null) {
            val android_id = Settings.Secure.getString(applicationContext.contentResolver, Settings.Secure.ANDROID_ID)
            deviceId = android_id
        }
        return deviceId
    }
}
