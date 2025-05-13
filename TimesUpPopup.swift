
import SwiftUI

struct TimesUpPopup: View {
    var tryAgainAction: () -> Void
    var goHomeAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
           
            Text("Time’s up ☹️")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.lightpurple)
                .padding(.bottom, 50)

            
            Text("Deep breaths, You can try again whenever you’re ready")
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .foregroundColor(.lightpurple)
                .padding(.horizontal)
                .padding(.bottom, 60)

           
            HStack(spacing: 16) {
                Button(action: tryAgainAction) {
                    Text("Try again")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background(Color.button)
                        .clipShape(Capsule())
                        .cornerRadius(20)
                }

                Button(action: goHomeAction) {
                    Text("Home")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 36)
                        .background(Color.button)
                        .clipShape(Capsule())
                        .cornerRadius(20)
                }
            }
        }
        .frame(width: 325, height: 353)
        .background(Color.candypurple)
        .cornerRadius(30)
        .shadow(radius: 2)
    }
}

#Preview {
    TimesUpPopup(
        tryAgainAction: { print("Try again tapped") },
        goHomeAction: { print("Go home tapped") }
    )
}
