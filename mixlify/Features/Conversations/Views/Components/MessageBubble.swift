import SwiftUI

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

struct MessageBubbleView: View {
    let text: String
    let isCurrentUser: Bool
    
    private var backgroundColor: Color {
        #if os(iOS)
        return Color(.systemGray5)
        #elseif os(macOS)
        return Color(.controlBackgroundColor)
        #endif
    }
    
    var body: some View {
        HStack {
            if isCurrentUser { Spacer() }
            
            Text(text)
                .padding(12)
                .background(isCurrentUser ? Color.blue : backgroundColor)
                .foregroundColor(isCurrentUser ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            if !isCurrentUser { Spacer() }
        }
        .padding(.horizontal, 8)
    }
}