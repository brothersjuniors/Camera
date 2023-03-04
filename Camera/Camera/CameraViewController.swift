
import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet var label : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Tap the [Start] to take a picture"
    }
    // カメラの撮影開始
    @IBAction func startCamera(_ sender : Any) {
        let sourceType:UIImagePickerController.SourceType =
        UIImagePickerController.SourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
        else{
            label.text = "error"
        }
    }
    //　撮影が完了した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedImage = info[.originalImage]
            as? UIImage {
            
            imageV.contentMode = .scaleAspectFit
            imageV.image = pickedImage
        }
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        label.text = "Tap the [Save] to save a picture"
    }
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        label.text = "Canceled"
    }
    // 写真を保存
    @IBAction func savePicture(_ sender : Any) {
        let image:UIImage! = imageV.image
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(
                image,
                self,
                #selector(CameraViewController.image(_:didFinishSavingWithError:contextInfo:)),
                nil)
        }
        else{
            label.text = "image Failed!"
        }
    }
    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError!,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
            label.text = "Save Failed!"
        }
        else{
            label.text = "Save Succeeded"
        }
    }
    // アルバムを表示
    @IBAction func showAlbum(_ sender : Any) {
        let sourceType:UIImagePickerController.SourceType =
        UIImagePickerController.SourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            label.text = "Tap the [Start] to save a picture"
        }
        else{
            label.text = "error"
        }
    }
}
