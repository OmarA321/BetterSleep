import SwiftUI

struct SmartAlarmView: View {
    @State private var isDynamicAlarmSelected = false
    @State private var isManualAlarmSelected = false
    @State private var isSetTimeToWakeUp = false
    @State private var isSetTimeToSleep = false
    @State private var selectedTimeToWakeUp = Date()
    @State private var selectedTimeToSleep = Date()
    
    
    var body: some View {
        VStack {
            Image(systemName: "alarm.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 100)
                .foregroundColor(.blue)
                .padding()
            
            Text("Smart Alarm")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Spacer()
            
            VStack {
                Text("Select alarm type:")
                
                HStack {
                    Button(action: {
                        isDynamicAlarmSelected = true
                        isManualAlarmSelected = false
                    }) {
                        Text("Dynamic Alarm")
                            .padding()
                            .background(isDynamicAlarmSelected ? Color.blue : Color.clear)
                            .foregroundColor(isDynamicAlarmSelected ? Color.white : Color.blue)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        isDynamicAlarmSelected = false
                        isManualAlarmSelected = true
                    }) {
                        Text("Manual Alarm")
                            .padding()
                            .background(isManualAlarmSelected ? Color.blue : Color.clear)
                            .foregroundColor(isManualAlarmSelected ? Color.white : Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
            
            if isDynamicAlarmSelected {
                DynamicAlarmView(selectedWakeUpTime: $selectedTimeToWakeUp)
            } else if isManualAlarmSelected {
                ManualAlarmView(selectedTimeToWakeUp: $selectedTimeToWakeUp)
            }
            
            Spacer()
        }
    }
}

struct DynamicAlarmView: View {
    @Binding var selectedWakeUpTime: Date
    @State private var optimalAlarmDate: Date?
    
    var body: some View {
        VStack {
            Text("Please Enter Wake Up Time:")
            DatePicker("Select wake up time", selection: $selectedWakeUpTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            
            Button("Set Dynamic Alarm") {
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
    }
}

struct ManualAlarmView: View {
    @Binding var selectedTimeToWakeUp: Date
    @State private var selectedTimeToSleep: Date = Date()
    @State private var isSelectingSleepTime = false
    
    @State private var recommendedWakeUpTimes: [Date] = []
    @State private var wakeUpTimeInput: Date = Date()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isSelectingSleepTime = false
                }) {
                    Text("Select Wake Up Time")
                        .padding()
                        .background(isSelectingSleepTime ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    isSelectingSleepTime = true
                }) {
                    Text("Select Sleep Time")
                        .padding()
                        .background(isSelectingSleepTime ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            if isSelectingSleepTime {
                Text("Select Sleep Time:")
                DatePicker("Select Sleep Time", selection: $selectedTimeToSleep, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
            } else {
                Text("Select Wake Up Time:")
                DatePicker("Select Wake Up Time", selection: $wakeUpTimeInput, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
            }
            
            Button("Calculate Optimal Wake Up Times") {
                calculateOptimalWakeUpTimes()
            }
            
            if !recommendedWakeUpTimes.isEmpty {
                Text("Recommended Wake Up Times:")
                ForEach(recommendedWakeUpTimes, id: \.self) { wakeUpTime in
                    Text(formatTime(wakeUpTime))
                }
            }
        }
        .padding()
    }
    
    private func calculateOptimalWakeUpTimes() {
        let calendar = Calendar.current
        let currentTime = Date()
        var sleepTime = selectedTimeToSleep
        
        if !isSelectingSleepTime {
            sleepTime = calendar.date(byAdding: .hour, value: -8, to: wakeUpTimeInput)!
        }
        
        // Clear previous recommended wake up times
        recommendedWakeUpTimes.removeAll()
        
        // Calculate the optimal wake up times
        var wakeUpTime = sleepTime
        while wakeUpTime <= selectedTimeToWakeUp {
            if wakeUpTime > currentTime {
                recommendedWakeUpTimes.append(wakeUpTime)
            }
            wakeUpTime = calendar.date(byAdding: .minute, value: 90, to: wakeUpTime)!
        }
        
        // Keep only the 5 nearest times before wake up time
        let sortedTimes = recommendedWakeUpTimes.sorted()
        if sortedTimes.count > 5 {
            recommendedWakeUpTimes = Array(sortedTimes.prefix(5))
        }
    }
    
    private func formatTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: time)
    }
}

struct SmartAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        SmartAlarmView()
    }
}

extension DateFormatter {
    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
