import SwiftUI

struct SleepAnalysisView: View {
    @Binding var antiBlueLightMode: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "bed.double.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 100)
                    .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
                    .padding()
                
                Text("Sleep History & Analysis")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                ZStack{
                    Text("Placeholder for Graphics")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
                .cornerRadius(20)
                .padding(.vertical, 20)
                .padding(.horizontal, 35)
                
                
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
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                        }
                        .padding(.top, 20)
                        
                        NavigationLink(destination: ViewPersonalSleepHistoryView()) {
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
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                        }
                        .padding(.top, 20)
                    }
                    
                    NavigationLink(destination: ViewOverallSleepDataView()) {
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
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(20)
                    }
                }
                .padding(.horizontal, 15)
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .accentColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
    }
}



struct AddSingleDaySleepDataView: View {
    @State private var selectedDate = Date()
    @State private var sleepTime = Date()
    @State private var wakeUpTime = Date()
    @State private var selectedSleepQuality = "Great"
    let sleepQualityOptions = ["Great", "Good", "Okay", "Poor", "Awful"]
    
    var body: some View {
        VStack {
            Text("Record Sleep")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
            
            DatePicker("Date:", selection: $selectedDate, displayedComponents: .date)
                .padding()
            
            DatePicker("Sleep Time:", selection: $sleepTime, displayedComponents: .hourAndMinute)
                .padding()
            
            DatePicker("Wake Up Time:", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                .padding()
            
            HStack {
                Text("Sleep Quality:")
                Spacer()
                Picker("", selection: $selectedSleepQuality) {
                    ForEach(sleepQualityOptions, id: \.self) {
                        Text($0)
                    }
                }
            }
            .padding()
            
            Button(action: {
                // Save action
            }) {
                Text("Save")
                    .padding(EdgeInsets(top: 20, leading: 100, bottom: 20, trailing: 100))
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
        }
    }
}


struct ViewPersonalSleepHistoryView: View {
    var body: some View {
        VStack {
            Text("Sleep History")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
                .padding()
            
            SleepRecordView(date: "February 28, 2024", hoursSlept: 7, qualityRating: "Okay")
            SleepRecordView(date: "February 27, 2024", hoursSlept: 6.5, qualityRating: "Poor")
            SleepRecordView(date: "February 26, 2024", hoursSlept: 8, qualityRating: "Great")
            
            Spacer()
        }
    }
}

struct SleepRecordView: View {
    let date: String
    let hoursSlept: Double
    let qualityRating: String
    
    var body: some View {
        VStack {
            HStack{
                Text(date)
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text("Sleep Duration: \(String(format: "%.1f", hoursSlept)) hours")
                Spacer()
                Text("Sleep Rating: \(qualityRating)")
            }
            .padding(.vertical, 4)
        }
        .padding(.horizontal)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(8)
    }
}

struct ViewOverallSleepDataView: View {
    var body: some View {
        VStack {
            Text("Overall Sleep Stats")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
            
            SleepSummaryView(totalNights: 30, averageHoursSlept: 7.5, averageQualityRating: "Great")
            
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

struct SleepSummaryView: View {
    let totalNights: Int
    let averageHoursSlept: Double
    let averageQualityRating: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Total Sleeps Recorded:")
                    .padding(.vertical, 20)
                    .fontWeight(.bold)
                Spacer()
                Text("\(totalNights)")
                    .padding(.vertical, 20)
            }
            HStack {
                Text("Average Sleep Duration:")
                    .fontWeight(.bold)
                    .padding(.vertical, 20)
                Spacer()
                Text("\(String(format: "%.1f", averageHoursSlept)) hours")
                    .padding(.vertical, 20)
            }
            HStack {
                Text("Average Sleep Rating:")
                    .fontWeight(.bold)
                    .padding(.vertical, 20)
                Spacer()
                Text("\(averageQualityRating)")
                    .padding(.vertical, 20)
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(8)
    }
}

