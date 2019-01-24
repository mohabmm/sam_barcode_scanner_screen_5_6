package mingsin.fzxing

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.view.KeyEvent
import com.google.zxing.ResultPoint
import com.google.zxing.client.android.BeepManager
import com.google.zxing.client.android.Intents
import com.journeyapps.barcodescanner.BarcodeCallback
import com.journeyapps.barcodescanner.BarcodeResult
import com.journeyapps.barcodescanner.DecoratedBarcodeView
import android.support.v7.app.AlertDialog
import android.widget.TextView
import android.content.DialogInterface

class CaptureActivity : Activity() {
    private var lastBarcode = "INVALID_STRING_STATE"
    private lateinit var scannerView: DecoratedBarcodeView
    private val list = arrayListOf<String>()
    private var handler: Handler? = null
    private var runnable: Runnable? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_capture)
        val isContinuous = intent.extras[keyIsContinuous] as Boolean
        val isBeep = intent.getBooleanExtra(Intents.Scan.BEEP_ENABLED, true)
        val interval = intent.extras[keyContinuousInterval] as? Int ?: 1000
        var lastTime = System.currentTimeMillis()
        val beepManager = BeepManager(this)
        scannerView = findViewById(R.id.scanner_view)
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
                        finish()
                    }
                }

                override fun possibleResultPoints(resultPoints: List<ResultPoint>) {
                }
            })
        }

        // handle "type manual barcode click"
        val typeBarcode: TextView = findViewById(R.id.tv_type_barcode) as TextView
        typeBarcode.setOnClickListener{
            finish()
            print("on click clicked");
        }

        startHandler()
    }

    private fun startHandler() {
        if (runnable == null) {
            runnable = object : Runnable {
                override fun run() {
                    showDialogForRestart()
                }
            }
        }
        if (handler == null) {
            handler = Handler()
        }
        handler?.postDelayed(runnable, 15000)
    }

    private fun showDialogForRestart() {
        val alertDialog = AlertDialog.Builder(this).create()
        alertDialog.setTitle("Restart scan")
        alertDialog.setMessage("Do you want to restart scan?")
        alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "OK",
                DialogInterface.OnClickListener {dialog, which -> {
                    dialog.dismiss()
                    startHandler()
                }});
        alertDialog.setButton(AlertDialog.BUTTON_POSITIVE, "RESTART",
                DialogInterface.OnClickListener {dialog, which -> {
                    startHandler()
                    dialog.dismiss()
                }})
        alertDialog.show()
    }

    fun closeHandler() {
        if (handler != null && runnable != null) {
            handler?.removeCallbacks(runnable)
            handler = null
            runnable = null
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

    override protected fun onDestroy() {
        super.onDestroy()
        closeHandler()
    }
}