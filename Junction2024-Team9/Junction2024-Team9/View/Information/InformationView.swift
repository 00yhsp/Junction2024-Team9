//
//  InformationView.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI

struct InformationView: View {
    @Binding var image: UIImage?
    @EnvironmentObject var locationHelper: LocationHelper
    @State var currentTimeStamp: String = ""
    @State var problem: ProblemCategory?
    @Environment(\.dismiss) var dismiss
    @Environment(HomeTriggerWrapper.self) var trigger
    let problems = ProblemCategory.allCases

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 320)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 320)

private struct ButtonGroupView: View {
    var body: some View {
        HStack(spacing: 20) {
            Button {
            } label: {
                Text("다시")
            }
             .frame(maxWidth: .infinity)
          
            Button {
            } label: {
                Text("확인")
                }
            .frame(maxWidth: .infinity)

            Spacer()

            HStack {
                Text("Category")
                    .font(.paperlogy(size: 16, weight: .regular))
                    .foregroundStyle(.white)
                Spacer()
                Menu {
                    ForEach(problems, id: \.self) { prob in
                        Button(prob.rawValue) {
                            problem = prob
                        }
                    }
                } label: {
                    switch problem {
                    case .pothole:
                        Text("Pothole")
                            .font(.paperlogy(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color(uiColor: UIColor(red: 0.94, green: 0.25, blue: 0.32, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    case .crack:
                        Text("Crack")
                            .font(.paperlogy(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color(uiColor: UIColor(red: 1, green: 0.75, blue: 0.09, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    case .trash:
                        Text("Trash")
                            .font(.paperlogy(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color(UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    case .banner:
                        Text("Banner")
                            .font(.paperlogy(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color(uiColor: UIColor(red: 0.68, green: 0.28, blue: 0, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    case .vehicle:
                        Text("Vehicle")
                            .font(.paperlogy(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color(uiColor: UIColor(red: 0.44, green: 0.24, blue: 1, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    case nil:
                        Text("Select")
                            .font(.paperlogy(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white, lineWidth: 1)

                            )
                    }
                }
            }
            .padding(.top)
            .padding(.horizontal)

            HStack {
                Text("Location")
                    .font(.paperlogy(size: 16, weight: .regular))
                    .foregroundStyle(.white)
                Spacer()
                Text(locationHelper.getCurrentAddress())
                    .font(.paperlogy(size: 14, weight: .regular))
                    .lineLimit(1)
            }
            .padding(.top)
            .padding(.horizontal)


            HStack {
                Text("Time")
                    .font(.paperlogy(size: 16, weight: .regular))
                    .foregroundStyle(.white)
                Spacer()
                Text(currentTimeStamp)
                    .font(.paperlogy(size: 14, weight: .regular))
            }
            .padding(.top)
            .padding(.horizontal)

            Spacer()

            HStack(spacing: 10) {
                Button {
                    dismiss()
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.blue, lineWidth: 1 )
                        .overlay {
                            Text("Retry")
                        }
                }
                .frame(height: 62)

                Button {
                    trigger.trigger = false
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.blue)
                        .overlay {
                            Text("Report")
                                .foregroundStyle(.white)
                        }
                }
                .frame(height: 62)

            }
            .opacity(0)
            .disabled(true)
            .padding()
            .padding(.bottom)
        }
        .onAppear {
            setCurrentTimestamp()
        }
    }

    func setCurrentTimestamp() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTimeString = dateFormatter.string(from: Date())
        currentTimeStamp = currentTimeString
    }
}

#Preview {
    InformationView(image: .constant(UIImage(named: "photo")))
        .environmentObject(LocationHelper())
        .environment(HomeTriggerWrapper())
}
