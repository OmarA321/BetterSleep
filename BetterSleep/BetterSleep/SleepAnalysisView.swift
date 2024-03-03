import SwiftUI

struct SleepAnalysisView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "moon.zzz.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue) // Changed color to blue
                    .padding()
                
                Text("Dream Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                NavigationLink(destination: AddSingleDaySleepDataView()) {
                    Text("Record Dream")
                        .foregroundColor(.blue) // Changed color to blue
                        .padding()
                }
                
                NavigationLink(destination: ViewPersonalSleepHistoryView()) {
                    Text("Dream History")
                        .foregroundColor(.blue) // Changed color to blue
                        .padding()
                }
                
                NavigationLink(destination: ViewOverallSleepDataView()) {
                    Text("Overall Dream Stats")
                        .foregroundColor(.blue) // Changed color to blue
                        .padding()
                }
                
                NavigationLink(destination: ViewHealthcarePatientSleepHistoryView()) {
                    Text("Patient's Dream")
                        .foregroundColor(.blue) // Changed color to blue
                        .padding()
                }
                
                Spacer()
            }
            .navigationBarTitle("Dream Tracker")
        }
    }
}

struct AddSingleDaySleepDataView: View {
    @State private var hoursSlept: String = ""
    @State private var qualityRating: Int = 0
    
    var body: some View {
        VStack {
            Text("Record Dream")
                .font(.title)
                .padding()
            
            TextField("Dream Duration (hours)", text: $hoursSlept)
                .padding()
                .background(Color.blue) // Changed color to blue
                .cornerRadius(8)
                .padding()
            
            Stepper(value: $qualityRating, in: 0...10) {
                Text("Dream Rating: \(qualityRating)")
                    .padding()
            }
            
            Button(action: {
                // Save dream data
            }) {
                Text("Save")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue) // Changed color to blue
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct ViewPersonalSleepHistoryView: View {
    var body: some View {
        VStack {
            Text("Your Dream History")
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
                Text("Dream Duration: \(String(format: "%.1f", hoursSlept)) hours")
                Spacer()
                Text("Dream Rating: \(qualityRating)")
            }
            .padding(.vertical, 4)
        }
        .padding(.horizontal)
        .background(Color.blue) // Changed color to blue
        .cornerRadius(8)
        .padding(.vertical, 4)
    }
}

struct ViewOverallSleepDataView: View {
    var body: some View {
        VStack {
            Text("Overall Dream Stats")
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
            Text("Total Dreams Recorded: \(totalNights)")
                .padding(.bottom, 4)
            Text("Average Dream Duration: \(String(format: "%.1f", averageHoursSlept)) hours")
                .padding(.bottom, 4)
            Text("Average Dream Rating: \(averageQualityRating)")
        }
        .padding()
        .background(Color.blue) // Changed color to blue
        .cornerRadius(8)
        .padding()
    }
}

struct ViewHealthcarePatientSleepHistoryView: View {
    var body: some View {
        VStack {
            Text("Patient's Dream History")
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
