import SwiftUI

struct SleepAnalysisView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "moon.stars.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.indigo) // Soft indigo color
                    .padding()
                
                Text("Sleep Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                NavigationLink(destination: AddSingleDaySleepDataView()) {
                    Text("Record Sleep")
                        .foregroundColor(.indigo) // Soft indigo color
                        .padding()
                }
                
                NavigationLink(destination: ViewPersonalSleepHistoryView()) {
                    Text("Sleep History")
                        .foregroundColor(.indigo) // Soft indigo color
                        .padding()
                }
                
                NavigationLink(destination: ViewOverallSleepDataView()) {
                    Text("Overall Sleep Stats")
                        .foregroundColor(.indigo) // Soft indigo color
                        .padding()
                }
                
                NavigationLink(destination: ViewHealthcarePatientSleepHistoryView()) {
                    Text("Patient's Sleep")
                        .foregroundColor(.indigo) // Soft indigo color
                        .padding()
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark background
        }
        .accentColor(.indigo) // Accent color for buttons and links
    }
}

struct AddSingleDaySleepDataView: View {
    @State private var hoursSlept: String = ""
    @State private var qualityRating: Int = 0
    
    var body: some View {
        VStack {
            Text("Record Sleep")
                .font(.title)
                .padding()
            
            TextField("Sleep Duration (hours)", text: $hoursSlept)
                .padding()
                .background(Color.indigo) // Soft indigo color
                .cornerRadius(8)
                .padding()
            
            Stepper(value: $qualityRating, in: 0...10) {
                Text("Sleep Rating: \(qualityRating)")
                    .padding()
            }
            
            Button(action: {
                // Save Sleep data
            }) {
                Text("Save")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.indigo) // Soft indigo color
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark background
    }
}

struct ViewPersonalSleepHistoryView: View {
    var body: some View {
        VStack {
            Text("Your Sleep History")
                .font(.title)
                .padding()
            
            SleepRecordView(date: "February 28, 2024", hoursSlept: 7, qualityRating: 8)
            SleepRecordView(date: "February 27, 2024", hoursSlept: 6.5, qualityRating: 7)
            SleepRecordView(date: "February 26, 2024", hoursSlept: 8, qualityRating: 9)
        }
    }
}

struct SleepRecordView: View {
    let date: String
    let hoursSlept: Double
    let qualityRating: Int
    
    var body: some View {
        VStack {
            Text(date)
                .font(.headline)
            
            HStack {
                Text("Sleep Duration: \(String(format: "%.1f", hoursSlept)) hours")
                Spacer()
                Text("Sleep Rating: \(qualityRating)")
            }
            .padding(.vertical, 4)
        }
        .padding(.horizontal)
        .background(Color.indigo) // Soft indigo color
        .cornerRadius(8)
        .padding(.vertical, 4)
    }
}

struct ViewOverallSleepDataView: View {
    var body: some View {
        VStack {
            Text("Overall Sleep Stats")
                .font(.title)
                .padding()
            
            SleepSummaryView(totalNights: 30, averageHoursSlept: 7.5, averageQualityRating: 8)
        }
    }
}

struct SleepSummaryView: View {
    let totalNights: Int
    let averageHoursSlept: Double
    let averageQualityRating: Int
    
    var body: some View {
        VStack {
            Text("Total Sleep Recorded: \(totalNights)")
                .padding(.bottom, 4)
            Text("Average Sleep Duration: \(String(format: "%.1f", averageHoursSlept)) hours")
                .padding(.bottom, 4)
            Text("Average Sleep Rating: \(averageQualityRating)")
        }
        .padding()
        .background(Color.indigo) // Soft indigo color
        .cornerRadius(8)
        .padding()
    }
}

struct ViewHealthcarePatientSleepHistoryView: View {
    var body: some View {
        VStack {
            Text("Patient's Sleep History")
                .font(.title)
                .padding()
            
            SleepRecordView(date: "February 28, 2024", hoursSlept: 6, qualityRating: 7)
            SleepRecordView(date: "February 27, 2024", hoursSlept: 5.5, qualityRating: 6)
            SleepRecordView(date: "February 26, 2024", hoursSlept: 7.5, qualityRating: 8)
        }
    }
}

struct SleepAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        SleepAnalysisView()
    }
}
