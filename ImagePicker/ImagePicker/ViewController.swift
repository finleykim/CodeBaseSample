//
//  ViewController.swift
//  ImagePicker
//
//  Created by Finley on 2022/07/23.
//

import UIKit
import AVKit
import Photos
import LocalAuthentication

class ViewController: UIViewController {

    
    let image = UIImageView()
    let label = UILabel()
    let button = UIButton()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute(){
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(buttonTapped))
        
        label.text = "인식된 텍스트가 없습니다"
        label.textColor = .black
        
        button.setTitle("텍스트추출", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        
        imagePicker.delegate = self
        
        PHPhotoLibrary.requestAuthorization{ (state) in
            print(state)
        }
        
        AVCaptureDevice.requestAccess(for: .video){ (result) in
            print(result)
        }
        
    }
    
    @objc func buttonTapped(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editButton = UIAlertAction(title: "촬영하기", style: .default, handler: cameraButtonTapped(_:))
        let deleteButton = UIAlertAction(title: "이미지 불러오기", style: .destructive, handler: libraryButtonTapped(_:))
        
        actionSheet.addAction(editButton)
        actionSheet.addAction(deleteButton)
        
        self.present(actionSheet, animated: true){
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            actionSheet.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cameraButtonTapped(_ action: UIAlertAction){
        if CameraAuth(){
            self.imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        } else{
            AuthSettingOpen(AuthString: "카메라")
        }
    }
    
    @objc func libraryButtonTapped(_ action: UIAlertAction){
        if PhotoAuth(){
            self.imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        } else{
            AuthSettingOpen(AuthString: "앨버")
        }
    }
    
    private func layout(){
        
        [image,label,button].forEach{
            view.addSubview($0)
        }
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: image.centerYAnchor, constant: 150).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImage: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                   selectImage = editedImage
               } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                   selectImage = originalImage
               }
        
        picker.dismiss(animated: true)
        image.image = selectImage
    }
    
    func PhotoAuth() -> Bool {
            // 포토 라이브러리 접근 권한
            let authorizationStatus = PHPhotoLibrary.authorizationStatus()

            var isAuth = false

            switch authorizationStatus {
            case .authorized: return true // 사용자가 앱에 사진 라이브러리에 대한 액세스 권한을 명시 적으로 부여했습니다.
            case .denied: break // 사용자가 사진 라이브러리에 대한 앱 액세스를 명시 적으로 거부했습니다.
            case .limited: break // ?
            case .notDetermined: // 사진 라이브러리 액세스에는 명시적인 사용자 권한이 필요하지만 사용자가 아직 이러한 권한을 부여하거나 거부하지 않았습니다
                PHPhotoLibrary.requestAuthorization { (state) in
                    if state == .authorized {
                        isAuth = true
                    }
                }
                return isAuth
            case .restricted: break // 앱이 사진 라이브러리에 액세스 할 수있는 권한이 없으며 사용자는 이러한 권한을 부여 할 수 없습니다.
            default: break
            }
        
            return false;
        }

        func CameraAuth() -> Bool {
            return AVCaptureDevice.authorizationStatus(for: .video) == AVAuthorizationStatus.authorized
        }
    
    func AuthSettingOpen(AuthString: String) {
            if let AppName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
                let message = "\(AppName)이(가) \(AuthString) 접근 허용되어 있지않습니다. \r\n 설정화면으로 가시겠습니까?"
                let alert = UIAlertController(title: "설정", message: message, preferredStyle: .alert)

                let cancle = UIAlertAction(title: "취소", style: .default) { (UIAlertAction) in
                    print("\(String(describing: UIAlertAction.title)) 클릭")
                }
                
                let confirm = UIAlertAction(title: "확인", style: .default) { (UIAlertAction) in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                alert.addAction(cancle)
                alert.addAction(confirm)

                self.present(alert, animated: true, completion: nil)
            }
        }
}





