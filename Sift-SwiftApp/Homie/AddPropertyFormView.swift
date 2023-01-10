//
//  AddPropertyFormView.swift
//  Homie
//
//  Created by Edward Day on 03/11/2022.
//

import SwiftUI
import PhotosUI

struct AddPropertyFormView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var address1: String = ""
    @State private var bedrooms: String = ""
    @State private var postcode: String = ""
    @State private var price: String = ""
    @State private var photo: PhotosPickerItem? = nil
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    TextField("Address 1", text: $address1)
                    TextField("Postcode", text: $postcode)
                    TextField("Bedrooms", text: $bedrooms)
                    TextField("Price", text: $price)
                    PhotosPicker(
                            selection: $photo,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Text("Select a photo")
                            }
                    
                }
                
            }
            .navigationTitle("New Property")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Close")
                    } label: {
                        Text("Close")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Save")
                        dismiss()
                        
                    } label: {
                        Text("Save")
                    }

                }
            }
        }
        
    }
}

struct AddPropertyFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddPropertyFormView()
    }
}
