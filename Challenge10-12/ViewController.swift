//
//  ViewController.swift
//  Challenge10-12
//
//  Created by  Vladislav Bondarev on 18.02.2020.
//  Copyright © 2020 Vladislav Bondarev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var photolib = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        load()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePhoto))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photolib.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let path = getDocumentsDirectory().appendingPathComponent(photolib[indexPath.row].image)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        cell.textLabel?.text = photolib[indexPath.row].title
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
            let path = getDocumentsDirectory().appendingPathComponent(photolib[indexPath.row].image)
            vc.photo = UIImage(contentsOfFile: path.path)
            vc.titlePhoto = photolib[indexPath.row].title
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func takePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        //picker.sourceType = .camera
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        let photo = Photo(image: imageName, title: "New")
        photolib.append(photo)
        tableView.reloadData()
        //self.save()
        dismiss(animated: true)
        
        let ac = UIAlertController(title: "", message: "Enter name:", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        ac.addAction(UIAlertAction(title: "Rename", style: .default) { [unowned self] _ in
            let newName = ac.textFields![0]
            if newName.text! != "" {
                self.photolib.last?.title = newName.text!
                
            }
            self.save()
            self.tableView?.reloadData()
        })
        present(ac, animated: true)
        
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(photolib) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "Album")
        } else {
            print("Error save")
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "Album") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                photolib = try jsonDecoder.decode([Photo].self, from: savedData)
            } catch {
                print("Error load")
            }
        }
    }


}

