import SwiftUI
import UniformTypeIdentifiers



@main
struct TopicColorApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}

/// The main content view with a button to navigate to TopicsChooserScreen.
struct ContentView: View {
    @State private var boardSize: Int = 3
    @State private var selectedTopics: [String] = []

    var body: some View {
 VStack {
            Text("Select Board Size")
                .font(.headline)
                .padding(.top)

            Picker("Board Size", selection: $boardSize) {
                ForEach(3..<7) { size in
                    Text("\(size)x\(size)").tag(size)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: boardSize) { old, newSize in
                selectedTopics = TopicProvider.shared.getRandomTopics(newSize - 1, from: mockTopics)
            }

            NavigationLink(destination: TopicsChooserScreen(allTopics: mockTopics, schemes: allSchemes, boardSize: boardSize, selectedTopics: $selectedTopics)) {
                Text("Choose Topics")
                    .padding()
//                    .background(Color.blue)
                   .foregroundColor(.blue)
//                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Main Screen")
        .onAppear {
            selectedTopics = TopicProvider.shared.getRandomTopics(boardSize - 1, from: mockTopics)
        }
    }
}
#Preview ("ContentView"){
  ContentView()
}


