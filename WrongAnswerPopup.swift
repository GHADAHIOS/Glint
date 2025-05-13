
import SwiftUI

struct WrongAnswerPopup: View {
    var tryAgainAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Wrong ❌")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.lightpurple)
                .padding(.bottom,50)

            Text("Oops! Make sure to capture an element in the specified color")
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .foregroundColor(.lightpurple)
                .padding(.horizontal)
                .padding(.bottom,60)

            Button(action: tryAgainAction) {
                Text("Try again")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 40)
                    .background(Color.button)
                    .clipShape(Capsule())
                    .cornerRadius(20)
            }
        }
        .frame(width: 325, height: 353)
        .background(Color.candypurple)
        .cornerRadius(30)
        .shadow(radius: 2)
    }
}

#Preview {
    WrongAnswerPopup {
        print("Try again tapped")
    }
}
