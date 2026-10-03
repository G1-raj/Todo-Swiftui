//
//  TodoCard.swift
//  Todo
//
//  Created by Govine Rajput on 03/10/26.
//

import SwiftUI


struct TodoCard: View {

    var title: String
    var description: String
    var isCompleted: Bool

    var body: some View {

        HStack(alignment: .top, spacing: 16) {

            // Status indicator
            ZStack {
                Circle()
                    .fill(
                        isCompleted
                        ? Color.green.opacity(0.12)
                        : Color.blue.opacity(0.12)
                    )
                    .frame(width: 44, height: 44)

                Image(
                    systemName: isCompleted
                    ? "checkmark"
                    : "circle"
                )
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(
                    isCompleted
                    ? .green
                    : .blue
                )
            }

            // Todo content
            VStack(alignment: .leading, spacing: 7) {

                Text(title)
                    .font(.system(
                        size: 17,
                        weight: .semibold
                    ))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                Text(description)
                    .font(.system(
                        size: 14,
                        weight: .regular
                    ))
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                // Status
                HStack(spacing: 5) {

                    Circle()
                        .fill(
                            isCompleted
                            ? .green
                            : .orange
                        )
                        .frame(
                            width: 6,
                            height: 6
                        )

                    Text(
                        isCompleted
                        ? "Completed"
                        : "Not completed"
                    )
                    .font(.system(
                        size: 12,
                        weight: .medium
                    ))
                    .foregroundStyle(
                        isCompleted
                        ? .green
                        : .secondary
                    )
                }
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.system(
                    size: 12,
                    weight: .semibold
                ))
                .foregroundStyle(.tertiary)
                .padding(.top, 6)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    Color.gray.opacity(0.12),
                    lineWidth: 1
                )
        )
        .shadow(
            color: .black.opacity(0.06),
            radius: 8,
            x: 0,
            y: 3
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 5)
    }
}


#Preview {
    TodoCard(
        title: "Todo title", description: "This is description of the todo to check todo card", isCompleted: false
    )
}
