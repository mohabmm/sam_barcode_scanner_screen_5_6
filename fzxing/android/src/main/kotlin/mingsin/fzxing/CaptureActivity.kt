package mingsin.fzxing

import android.app.Activity
import android.app.AlertDialog
import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.util.Log
import android.view.KeyEvent
import android.widget.TextView
import com.google.zxing.ResultPoint
import com.google.zxing.client.android.BeepManager
import com.google.zxing.client.android.Intents
import com.journeyapps.barcodescanner.BarcodeCallback
import com.journeyapps.barcodescanner.BarcodeResult
import com.journeyapps.barcodescanner.DecoratedBarcodeView

class CaptureActivity : Activity() {
    private var lastBarcode = "INVALID_STRING_STATE"
    private lateinit var scannerView: DecoratedBarcodeView
    private lateinit var goBack: TextView
    private val list = arrayListOf<String>()
    private var runnable: Runnable? = null
    private var handler: Handler? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_capture)
        val isContinuous = intent.extras[keyIsContinuous] as Boolean
        val isBeep = intent.getBooleanExtra(Intents.Scan.BEEP_ENABLED, true)
        val interval = intent.extras[keyContinuousInterval] as? Int ?: 1000
        var lastTime = System.currentTimeMillis()
        val beepManager = BeepManager(this)
        scannerView = findViewById(R.id.scanner_view)
        goBack = findViewById(R.id.tv_type_barcode)
        goBack.setOnClickListener {
            stopHandler();
            finish()

        }
        actionBar.hide()
        scannerView.setStatusText("")
        list.clear()

        if (isContinuous) {
            scannerView.decodeContinuous(object : BarcodeCallback {
                override fun barcodeResult(result: BarcodeResult?) {
                    result?.text?.let {
                        val now = System.currentTimeMillis()
                        if (now - lastTime < interval && lastBarcode == it) {
                            return
                        }
                        if (isBeep) {
                            beepManager.playBeepSound()
                        }
                        lastBarcode = it
                        list.add(it)
                        lastTime = System.currentTimeMillis()
                    }
                }

                override fun possibleResultPoints(resultPoints: List<ResultPoint>) {
                }
            })
        } else {
            scannerView.decodeSingle(object : BarcodeCallback {
                override fun barcodeResult(result: BarcodeResult?) {
                    result?.text?.let {
                        if (isBeep) {
                            beepManager.playBeepSound()
                        }
                        list.add(it)
                        setResult()
                        stopHandler()
                        finish()
                    }
                }

                override fun possibleResultPoints(resultPoints: List<ResultPoint>) {
                }
            })
        }
    }

    private fun setResult() {
        val data = Intent()
        data.putExtra("result", list)
        setResult(RESULT_OK, data)
    }

    override fun onBackPressed() {

        setResult()
        super.onBackPressed()
    }

    override fun onResume() {
        super.onResume()
        scannerView.resume()
    }

    override fun onPause() {
        super.onPause()
        scannerView.pause()
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent): Boolean {
        return scannerView.onKeyDown(keyCode, event) || super.onKeyDown(keyCode, event)
    }

    override fun onDestroy() {
        stopHandler()
        super.onDestroy()
    }

    override fun onStart() {
        startHandler();
        super.onStart()
    }

    private fun startHandler() {
        if (runnable == null) {
            runnable = Runnable {
                Log.e("handler", "CAlled")
                showDialogForRestart()
            }
        }
        if (handler == null) {
            handler = Handler()
        }
        handler!!.postDelayed(runnable, 15000)

    }

    private fun showDialogForRestart() {
        val alertDialog = AlertDialog.Builder(this).create()
        alertDialog.setTitle("Restart scan")
        alertDialog.setMessage("Do you want to restart scan?")
        alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "OK",
                DialogInterface.OnClickListener { dialog, which ->
                    dialog.dismiss()
                    startHandler()
                })
        alertDialog.setButton(AlertDialog.BUTTON_POSITIVE, "RESTART",
                DialogInterface.OnClickListener { dialog, which ->
                    startHandler()
                    dialog.dismiss()
                })
        alertDialog.show()
    }

    internal fun stopHandler() {
        if (handler != null && runnable != null) {
            handler!!.removeCallbacks(runnable)
            handler = null
            runnable = null
        }
    }


}