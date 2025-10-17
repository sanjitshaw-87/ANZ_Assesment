import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top, spacing: 16) {
                        AsyncImage(url: URL(string: user.profileImageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                                .accessibilityIdentifier("profileImageLoader")
                        }
                        .frame(width: geometry.size.width * 0.35, height: 150)
                        .clipped()
                        .accessibilityIdentifier("profileImage")
                        .padding(.horizontal)
                        
                        Text(user.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .accessibilityIdentifier("userName")
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(user.company)
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("userCompany")
                        
                        ContactInfoRow(icon: "envelope", text: user.email)
                            .accessibilityIdentifier("emailRow")
                        ContactInfoRow(icon: "phone", text: user.phone)
                            .accessibilityIdentifier("phoneRow")
                        ContactInfoRow(icon: "house", text: "\(user.address), \(user.state)")
                            .accessibilityIdentifier("addressRow")
                        ContactInfoRow(icon: "globe", text: "\(user.country) - \(user.zip)")
                            .accessibilityIdentifier("countryRow")
                    }
                    .padding(10)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContactInfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(text)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(user: User(
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
}
