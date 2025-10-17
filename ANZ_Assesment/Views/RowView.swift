//
//  RowView.swift
//  ANZ_Assesment
//
//  Created by Sanjit Shaw on 16/10/25.
//

import SwiftUI

struct RowView: View {
    let user: User
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.profileImageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text(user.company)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RowView(user: User(
        id: 1,
        name: "John Doe",
        company: "Tech Corp",
        username: "johndoe",
        email: "john@example.com",
        address: "123 Main St",
        zip: "12345",
        state: "CA",
        country: "USA",
        phone: "+1 234 567 8900",
        profileImageUrl: "https://example.com/profile.jpg"
    ))
}
