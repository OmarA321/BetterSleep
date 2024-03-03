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
            Spacer()
            
            Image(systemName: "alarm")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.orange)
            
            Text("Smart Alarm")
            
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
        .navigationTitle("Smart Alarm")
    }
}

struct DynamicAlarmView: View {
    @Binding var selectedWakeUpTime: Date
    @State private var optimalAlarmDate: Date?
    
    var body: some View {
        VStack {
            DatePicker("Select wake up time", selection: $selectedWakeUpTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            
            Button("Set Dynamic Alarm") {
                let selectedTime = Calendar.current.dateComponents([.hour, .minute], from: selectedWakeUpTime)
                guard let hour = selectedTime.hour, let minute = selectedTime.minute else {
                    // Handle invalid date
                    return
                }
                
                // Calculate the number of sleep cycles until the selected wake up time
                let currentTime = Date()
                let components = Calendar.current.dateComponents([.hour, .minute], from: currentTime)
                guard let currentHour = components.hour, let currentMinute = components.minute else {
                    // Handle invalid date
                    return
                }
                
                let currentTotalMinutes = currentHour * 60 + currentMinute
                let selectedTotalMinutes = hour * 60 + minute
                let minutesUntilWakeUp = selectedTotalMinutes - currentTotalMinutes
                
                // Calculate the optimal alarm time based on sleep cycles (assuming 90 minutes per cycle)
                let optimalAlarmMinutes = selectedTotalMinutes - (Int((Double(minutesUntilWakeUp) / 90.0).rounded(.awayFromZero)) * 90)
                
                // Convert the optimal alarm time back to a Date object
                let optimalAlarmHour = optimalAlarmMinutes / 60
                let optimalAlarmMinute = optimalAlarmMinutes % 60
                
                var alarmComponents = DateComponents()
                alarmComponents.hour = optimalAlarmHour
                alarmComponents.minute = optimalAlarmMinute
                
                if let optimalAlarmDate = Calendar.current.date(from: alarmComponents) {
                    // Set the alarm using optimalAlarmDate
                    self.optimalAlarmDate = optimalAlarmDate
                    print("Optimal Alarm Time: \(optimalAlarmDate)")
                    
                    // Here, you would typically use a notification or some other mechanism to set the alarm
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
            
            if let optimalAlarmDate = optimalAlarmDate {
                Text("Optimal Alarm Time: \(optimalAlarmDate, formatter: DateFormatter.timeOnly)")
                    .padding()
            }
        }
        .padding()
    }
}

struct ManualAlarmView: View {
    @Binding var selectedTimeToWakeUp: Date // Use binding here
    
    @State private var recommendedWakeUpTimes: [Date] = []
    @State private var wakeUpTimeInput: Date = Date()
    
    var body: some View {
        VStack {
            DatePicker("Select Wake Up Time", selection: $wakeUpTimeInput, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
            
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
        
        // Clear previous recommended wake up times
        recommendedWakeUpTimes.removeAll()
        
        // Calculate the optimal wake up times
        var wakeUpTime = currentTime
        while wakeUpTime <= wakeUpTimeInput {
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
