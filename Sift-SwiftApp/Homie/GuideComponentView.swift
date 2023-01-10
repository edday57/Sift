//
//  GuideComponentView.swift
//  Homie
//
//  Created by Edward Day on 02/11/2022.
//

import SwiftUI



struct GuideComponentView: View {
    var icon: String
    var title: String
    var subtitle: String
    var description: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 20){
            Image(systemName: icon)
                .foregroundColor(Color("PrimaryBlue"))
                .font(.system(size: 40, weight: .regular))
                .padding(0)
            VStack(alignment: .leading, spacing: 4){
                HStack {
                    Text(title.uppercased())
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    Text(subtitle.uppercased())
                        .fontWeight(.heavy)
                        .foregroundColor(Color("PrimaryBlue"))
                }
                Divider().padding(.bottom, 4)
                Text(description)
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        //.padding(25)
    }
}

struct GuideComponentView_Previews: PreviewProvider {
    static var previews: some View {
        GuideComponentView(icon: "heart.circle", title: "Like", subtitle: "Swipe right", description: "Swipe right to express your interest in a property to a landlord.")
            .previewLayout(.fixed(width: 375, height: 120))
    }
}
