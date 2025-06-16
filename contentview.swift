// ContentView.swift
import SwiftUI

struct ContentView: View {
    // @State property to hold the fetched holidays.
    // It will trigger a UI refresh when its value changes.
    @State private var holidays: [Holiday] = []
    
    // @State property to show/hide an error alert
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""

    // Instance of our HolidayService to make API calls.
    private let holidayService = HolidayService()
    
    // The year for which to fetch holidays
    let yearToFetch = 2025 // You can make this dynamic if needed

    var body: some View {
        NavigationView {
            List(holidays) { holiday in
                VStack(alignment: .leading) {
                    Text(holiday.localName)
                        .font(.headline)
                    Text(holiday.date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Indian Holidays \(yearToFetch)")
            // .onAppear is called when the view first appears on screen.
            .onAppear {
                // Use a Task to call the async fetchIndianHolidays function.
                // This prevents blocking the UI while fetching data.
                Task {
                    do {
                        let fetchedHolidays = try await holidayService.fetchIndianHolidays(year: yearToFetch)
                        // Update the @State property on the main thread.
                        // SwiftUI automatically ensures UI updates are on the main thread for @State.
                        holidays = fetchedHolidays
                    } catch {
                        // Handle errors during API call or decoding
                        print("Error fetching holidays: \(error.localizedDescription)")
                        errorMessage = error.localizedDescription
                        showingErrorAlert = true
                    }
                }
            }
            .alert("Error", isPresented: $showingErrorAlert) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
}

// MARK: - Preview Provider
// Used by Xcode to show a preview of your UI.
#Preview {
    ContentView()
}
