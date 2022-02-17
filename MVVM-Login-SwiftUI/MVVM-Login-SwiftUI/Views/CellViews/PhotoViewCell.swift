//
//  PhotoViewCell.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 17/02/22.
//

import SwiftUI

struct PhotoViewCell: View {
    @StateObject var photoViewModel: PhotoViewModel
   // @State private var image:UIImage = UIImage()
    private var data: Data {
        get {
            return photoViewModel.imageData ?? Data()
        }
    }
    var body: some View {
        
        HStack(alignment: .center) {
            Image(uiImage: UIImage(data: data) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height:100)
            
            Text(photoViewModel.title)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
        }
    }
}
    struct PhotoViewCell_Previews: PreviewProvider {
        
        static var previews: some View {
            let dummyPhoto = Photos(albumID: 1, id: 1, title: "Sachin Daingade", url: "https://static.scientificamerican.com/sciam/cache/file/4E0744CD-793A-4EF8-B550B54F7F2C4406_source.jpg?w=590&h=800&ACB6A419-81EB-4B9C-B846FD8EBFB16FBE", thumbnailURL: "https://static.scientificamerican.com/sciam/cache/file/4E0744CD-793A-4EF8-B550B54F7F2C4406_source.jpg?w=590&h=800&ACB6A419-81EB-4B9C-B846FD8EBFB16FBE")
            let photoViewModel = PhotoViewModel(withPhoto: dummyPhoto)
            PhotoViewCell(photoViewModel: photoViewModel)
                .padding([.leading,.trailing,.top,.bottom] ,10)
                .previewLayout(.sizeThatFits)
        }
    }
