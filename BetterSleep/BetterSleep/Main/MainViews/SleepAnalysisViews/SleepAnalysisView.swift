import SwiftUI

struct SleepAnalysisView: View {
    @StateObject var viewModel = SleepAnalysisViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "bed.double.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 100)
                    .foregroundColor(Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
                    .padding()
                
                Text("Sleep History & Analysis")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                
                VStack {
                    HStack {
                        NavigationLink(destination: AddSingleDaySleepDataView()) {
                            VStack {
                                Text("Record Sleep")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.top, 10)
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.top, 5)
                                    .padding(.bottom, 10)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.4234874403, blue: 0.1089703062, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                        }
                        .padding(.top, 20)
                        
                        NavigationLink(destination: PersonalSleepHistoryView()) {
                            VStack {
                                Text("Sleep History")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.top, 10)
                                Image(systemName: "list.triangle")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.top, 5)
                                    .padding(.bottom, 10)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.4234874403, blue: 0.1089703062, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                        }
                        .padding(.top, 20)
                    }
                    
                    NavigationLink(destination: OverallSleepDataView(antiBlueLightMode: $viewModel.preferences.antiBlueLightMode)) {
                        VStack {
                            Text("Overall Sleep Stats")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(.top, 10)
                            Image(systemName: "star.bubble.fill")
                                .resizable()
                                .scaledToFit()
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.4234874403, blue: 0.1089703062, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(20)
                    }
                }
                .padding(.horizontal, 15)
                
                Spacer()
            }
            .onAppear(){
                Task {
                    await viewModel.fetchUser()
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
        }
        .accentColor(Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
    }
}









