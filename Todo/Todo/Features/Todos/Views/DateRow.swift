//
//  DateRow.swift
//  Todo
//
//  Created by Govine Rajput on 03/10/26.
//

import SwiftUI

struct DateRow: View {
    
    let icon: String
    let title: String
    let date: Date
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 17))
                .foregroundStyle(.secondary)
                .frame( width: 28, height: 28 )
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system( size: 12, weight: .medium ))
                    .foregroundStyle(.secondary)
                
                Text( date.formatted( date: .abbreviated, time: .shortened ) ) .font(.system( size: 14, weight: .medium ))
            }
            
            Spacer()
        }
        .padding(.vertical, 14)
    }
}

//#Preview {
//    DateRow(
//
//    )
//}
