//
//  StatusBadge.swift
//  Todo
//
//  Created by Govine Rajput on 03/10/26.
//

import SwiftUI

struct StatusBadge: View {
    
    let isCompleted: Bool
    
    var body: some View {
        HStack(spacing: 6) {
            Image( systemName: isCompleted ? "checkmark.circle.fill" : "circle" )
            Text( isCompleted ? "Completed" : "Pending" )
                .font(.system( size: 13, weight: .semibold ))
        }
        .foregroundStyle( isCompleted ? .green : .orange )
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background( (isCompleted ? Color.green : Color.orange).opacity(0.10), in: Capsule() )
    }
}

#Preview {
    StatusBadge(isCompleted: true)
}
