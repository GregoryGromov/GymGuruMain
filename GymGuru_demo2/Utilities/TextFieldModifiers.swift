import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .padding(.leading, 32)
        
            .background(
                
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color(.systemGray3))
                        .frame(width: 150, height: 40)
            )
    }
}

struct OvalTextFieldStyle2: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .padding(.leading, 119)
        
            .background(
                
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color(.systemGray3))
                        .frame(width: 320, height: 40)
                    
//                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(.systemGray2))
            )
    }
}
