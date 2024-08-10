//
//  AnalyzeView.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI

struct AnalyzeView: View {
    @Binding var image: UIImage?
    @EnvironmentObject var locationHelper: LocationHelper
    
    @State var currentTimeStamp: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Spacer()
                if let image = image {
                    Image(uiImage: image )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 245, height: 245)
                }
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Category")
                    .font(.paperlogy(size: 16, weight: .regular))
                    .foregroundStyle(.white)
                
            }
            .padding(.top)
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("Location")
                    .font(.paperlogy(size: 16, weight: .regular))
                    .foregroundStyle(.white)
                Text(locationHelper.getCurrentAddress())
                    .font(.paperlogy(size: 14, weight: .regular))
                    .padding(.top)
            }
            .padding(.top)
            .padding(.horizontal)
            
            
            VStack(alignment: .leading) {
                Text("Time")
                    .font(.paperlogy(size: 16, weight: .regular))
                    .foregroundStyle(.white)
                Text(currentTimeStamp)
                    .font(.paperlogy(size: 14, weight: .regular))
                    .padding(.top)
            }
            .padding(.top)
            .padding(.horizontal)
            
            Spacer()
            
            HStack(spacing: 10) {
                Button {
                    print("Again")
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.blue, lineWidth: 1 )
                        .overlay {
                            Text("Again")
                        }
                }
                .frame(height: 62)
                
                Button {
                    print("Confirm")
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.blue)
                        .overlay {
                            Text("Confirm")
                                .foregroundStyle(.white)
                        }
                }
                .frame(height: 62)
                
            }
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

//#Preview {
//    AnalyzeView()
//        .EnvironmentObject(LocationHelper)
//}
