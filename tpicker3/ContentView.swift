import SwiftUI
import UniformTypeIdentifiers

// All available topics
let allTopics = [
    "Science", "Technology", "Engineering", "Mathematics",
    "History", "Geography", "Art", "Literature",
    "Music", "Philosophy", "Sports", "Nature",
    "Politics", "Economics", "Culture", "Health",
    "Education", "Language", "Religion", "Society",
    "Psychology", "Law", "Media", "Environment",
    "Space", "Travel", "Food", "Fashion",
    "Movies", "Games", "Animals", "Plants",
    "Computers", "Robotics", "AI", "Software",
    "Hardware", "Networking", "Data", "Security",
    "Biology", "Chemistry", "Physics", "Astronomy",
    "Geology", "Meteorology", "Oceanography", "Ecology"
]

// Define the color schemes
let schemes: [ColorScheme] = [
    ColorScheme(name: "Spring", colors: [
        ("Spring Green", "Dark Green", (144, 238, 144), (0, 100, 0)),
        ("Light Yellow", "Dark Yellow", (255, 255, 224), (255, 215, 0)),
        ("Light Pink", "Hot Pink", (255, 182, 193), (255, 105, 180)),
        ("Light Blue", "Dark Blue", (173, 216, 230), (0, 0, 139)),
        ("Peach", "Orange", (255, 218, 185), (255, 69, 0)),
        ("Lavender", "Blue Violet", (230, 230, 250), (138, 43, 226)),
        ("Mint", "Green", (189, 252, 201), (0, 128, 0)),
        ("Light Coral", "Crimson", (240, 128, 128), (220, 20, 60)),
        ("Lilac", "Dark Orchid", (200, 162, 200), (153, 50, 204)),
        ("Aqua", "Teal", (127, 255, 212), (0, 128, 128)),
        ("Lemon", "Dark Orange", (255, 250, 205), (255, 140, 0)),
        ("Sky Blue", "Royal Blue", (135, 206, 235), (0, 0, 205))
    ]),
    ColorScheme(name: "Summer", colors: [
        ("Sky Blue", "Midnight Blue", (135, 206, 235), (25, 25, 112)),
        ("Sand", "Saddle Brown", (194, 178, 128), (139, 69, 19)),
        ("Ocean", "Navy", (28, 107, 160), (0, 34, 64)),
        ("Sunset Orange", "Dark Red", (255, 140, 0), (139, 0, 0)),
        ("Seafoam", "Teal", (70, 240, 220), (0, 128, 128)),
        ("Palm Green", "Forest Green", (76, 187, 23), (0, 100, 0)),
        ("Coral", "Crimson", (255, 127, 80), (220, 20, 60)),
        ("Citrus", "Orange", (255, 235, 59), (255, 160, 0)),
        ("Lagoon", "Teal", (72, 209, 204), (0, 128, 128)),
        ("Shell", "Chocolate", (255, 239, 213), (210, 105, 30)),
        ("Coconut", "Saddle Brown", (255, 248, 220), (139, 69, 19)),
        ("Pineapple", "Dark Orange", (255, 223, 0), (255, 140, 0))
    ]),
    ColorScheme(name: "Autumn", colors: [
        ("Burnt Orange", "Dark Orange", (204, 85, 0), (255, 140, 0)),
        ("Golden Yellow", "Dark Goldenrod", (255, 223, 0), (184, 134, 11)),
        ("Crimson Red", "Dark Red", (220, 20, 60), (139, 0, 0)),
        ("Forest Green", "Dark Green", (34, 139, 34), (0, 100, 0)),
        ("Pumpkin", "Orange Red", (255, 117, 24), (255, 69, 0)),
        ("Chestnut", "Saddle Brown", (149, 69, 53), (139, 69, 19)),
        ("Harvest Gold", "Dark Goldenrod", (218, 165, 32), (184, 134, 11)),
        ("Amber", "Orange Red", (255, 191, 0), (255, 69, 0)),
        ("Maroon", "Dark Red", (128, 0, 0), (139, 0, 0)),
        ("Olive", "Dark Olive Green", (128, 128, 0), (85, 107, 47)),
        ("Russet", "Brown", (128, 70, 27), (165, 42, 42)),
        ("Moss Green", "Dark Olive Green", (173, 223, 173), (85, 107, 47))
    ]),
    ColorScheme(name: "Winter", colors: [
        ("Ice Blue", "Dark Blue", (176, 224, 230), (0, 0, 139)),
        ("Snow", "Dark Red", (255, 250, 250), (139, 0, 0)),
        ("Midnight Blue", "Alice Blue", (25, 25, 112), (240, 248, 255)),
        ("Frost", "Steel Blue", (240, 248, 255), (70, 130, 180)),
        ("Slate", "Dark Slate Gray", (112, 128, 144), (47, 79, 79)),
        ("Silver", "Dark Gray", (192, 192, 192), (169, 169, 169)),
        ("Pine", "Light Green", (0, 128, 128), (144, 238, 144)),
        ("Berry", "Light Pink", (139, 0, 0), (255, 182, 193)),
        ("Evergreen", "Light Green", (0, 100, 0), (144, 238, 144)),
        ("Charcoal", "White Smoke", (54, 69, 79), (245, 245, 245)),
        ("Storm", "Dark Gray", (119, 136, 153), (169, 169, 169)),
        ("Holly", "White", (0, 128, 0), (255, 255, 255))
    ])
]

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

    var body: some View {
        VStack {
            Text("Select Board Size")
                .font(.largeTitle)
                .padding(.top)

            Picker("Board Size", selection: $boardSize) {
                ForEach(3..<7) { size in
                    Text("\(size)x\(size)").tag(size)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            NavigationLink(destination: TopicsChooserScreen(allTopics: allTopics, schemes: schemes, boardSize: boardSize)) {
                Text("Open Topics Chooser")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Main Screen")
    }
}

/// The view for selecting and arranging topics.
struct TopicsChooserScreen: View {
    let allTopics: [String]
    let schemes: [ColorScheme]
    let boardSize: Int
    @State private var selectedTopics: [String] = []
    @State private var selectedSchemeIndex = 3 // Initial scheme index set to Winter
    @State private var rerollableIndices: Set<Int> = []

    init(allTopics: [String], schemes: [ColorScheme], boardSize: Int) {
        self.allTopics = allTopics
        self.schemes = schemes
        self.boardSize = boardSize

        let randomCount = boardSize - 2
        let initialTopics = TopicProvider.shared.getRandomTopics(randomCount, from: allTopics)
        _selectedTopics = State(initialValue: initialTopics)
      _rerollableIndices = State(initialValue: Set(0..<randomCount))
  }

  var body: some View {
      VStack(alignment: .leading) {
          Text("Topics Chooser")
              .font(.largeTitle)
              .bold()
              .padding(.top)
          
          Text("If you want to change the topics, that's okay but you will end your game. If you just want to change colors or ordering, you should use 'Arrange Topics'.")
              .font(.body)
              .padding(.bottom)

          HStack {
              NavigationLink(destination: TopicSelectorView(allTopics: allTopics, selectedTopics: $selectedTopics, selectedSchemeIndex: $selectedSchemeIndex, maxTopics: maxTopicsForBoardSize)) {
                  Text("Select Topics")
              }

              NavigationLink(destination: ArrangerView(topics: $selectedTopics, selectedSchemeIndex: $selectedSchemeIndex, schemes: schemes)) {
                  Text("Arrange Topics")
              }
              .disabled(selectedTopics.isEmpty)
          }
          .padding()

          ScrollView {
              let columns = [GridItem(), GridItem(), GridItem()]
              LazyVGrid(columns: columns, spacing: 10) {
                  ForEach(selectedTopics.indices, id: \.self) { index in
                      let topic = selectedTopics[index]
                      let colorInfo = schemes[selectedSchemeIndex].mappedColors()[index % schemes[selectedSchemeIndex].colors.count]
                      Text(topic)
                          .padding()
                          .background(colorInfo.0)
                          .foregroundColor(colorInfo.1)
                          .cornerRadius(8)
                          .padding(2)
                          .opacity(0.8)
                          .onTapGesture {
                              if rerollableIndices.contains(index) {
                                  rerollTopic(at: index)
                              }
                          }
                  }
              }
              .padding(.top)
          }
      }
      .padding()
      .navigationTitle("Topics Chooser")
      .navigationBarTitleDisplayMode(.large)
      .onChange(of: selectedTopics, perform: { newValue in
          TopicProvider.shared.saveTopics(newValue)
      })
  }

  private var maxTopicsForBoardSize: Int {
      switch boardSize {
      case 3: return 7
      case 4: return 8
      case 5: return 9
      case 6: return 10
      default: return 7
      }
  }

  private func rerollTopic(at index: Int) {
      var newTopic: String
      repeat {
          newTopic = allTopics.randomElement() ?? ""
      } while selectedTopics.contains(newTopic)
      
      selectedTopics[index] = newTopic
      rerollableIndices.remove(index)
  }
}

/// A view for selecting topics from the full list.
struct TopicSelectorView: View {
  let allTopics: [String]
  @Binding var selectedTopics: [String]
  @Binding var selectedSchemeIndex: Int
  let maxTopics: Int
  @State private var searchText = ""

  var body: some View {
      List {
          ForEach(filteredTopics, id: \.self) { topic in
              Button(action: {
                  if selectedTopics.contains(topic) {
                      selectedTopics.removeAll { $0 == topic }
                  } else if selectedTopics.count < maxTopics {
                      selectedTopics.append(topic)
                  }
              }) {
                  HStack {
                      Text(topic)
                      Spacer()
                      if selectedTopics.contains(topic) {
                          Image(systemName: "checkmark")
                      }
                  }
              }
          }
      }
      .navigationTitle("Select Topics")
      .searchable(text: $searchText, prompt: "Search Topics")
  }

  var filteredTopics: [String] {
      if searchText.isEmpty {
          return allTopics
      } else {
          return allTopics.filter { $0.localizedCaseInsensitiveContains(searchText) }
      }
  }
}

/// A view for arranging selected topics with a selected color scheme.
struct ArrangerView: View {
  @Environment(\.presentationMode) var presentationMode
  @Binding var topics: [String]
  @Binding var selectedSchemeIndex: Int // Binding to reflect changes back to TopicsChooserScreen
  let schemes: [ColorScheme]

  var body: some View {
      VStack {
          HStack {
              Text("Select a Color Scheme")
                  .font(.title2)
                  .padding(.top)

              Spacer()
          }
          .padding([.leading, .trailing, .top])

          Text("Drag and drop the topics to change their colors.")
              .padding(.bottom)

          Picker("Color Schemes", selection: $selectedSchemeIndex) {
              ForEach(0..<schemes.count, id: \.self) { index in
                  Text(schemes[index].name)
              }
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding()

          ScrollView {
              LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                  ForEach(0..<12, id: \.self) { index in
                      let colorInfo = schemes[selectedSchemeIndex].mappedColors()[index]
                      if index < topics.count {
                          let topic = topics[index]
                          Text(topic)
                              .padding()
                              .background(colorInfo.0)
                              .foregroundColor(colorInfo.1)
                              .cornerRadius(8)
                              .onDrag { NSItemProvider(object: NSString(string: topic)) }
                              .onDrop(of: [UTType.text], delegate: TopicDropDelegate(topic: (id: UUID(), name: topic, schemeIndex: selectedSchemeIndex), topics: $topics, fromIndex: index))
                      } else {
                          Text("Empty")
                              .padding()
                              .background(colorInfo.0)
                              .foregroundColor(colorInfo.1)
                              .cornerRadius(8)
                              .onDrop(of: [UTType.text], delegate: TopicDropDelegate(topic: (id: UUID(), name: "Empty", schemeIndex: selectedSchemeIndex), topics: $topics, fromIndex: index))
                      }
                  }
              }
              .padding()
          }
      }
      .navigationBarTitle("", displayMode: .inline)
  }
}

/// Drop delegate for handling drag and drop of topics.
struct TopicDropDelegate: DropDelegate {
  let topic: (id: UUID, name: String, schemeIndex: Int)
  @Binding var topics: [String]
  let fromIndex: Int

  func performDrop(info: DropInfo) -> Bool {
      guard let item = info.itemProviders(for: [UTType.text]).first else {
          return false
      }

      item.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { (data, error) in
          DispatchQueue.main.async {
              if let data = data as? Data, let text = String(data: data, encoding: .utf8) {
                  guard let fromIndex = topics.firstIndex(of: text) else { return }
                  let fromTopic = topics.remove(at: fromIndex)
                  let toIndex = topics.firstIndex(of: topic.name) ?? topics.endIndex
                  topics.insert(fromTopic, at: toIndex)
              }
          }
      }
      return true
  }
}

struct ArrangerView_Previews: PreviewProvider {
  static var previews: some View {
      NavigationView {
          ArrangerView(
              topics: .constant(["Science", "Technology", "Engineering"]),
              selectedSchemeIndex: .constant(3), // Initial scheme index set to Winter
              schemes: schemes
          )
      }
  }
}

/// Model for representing a color scheme.
struct ColorScheme {
  let name: String
  let colors: [(String, String, (Double, Double, Double), (Double, Double, Double))]

  /// Maps the colors to SwiftUI Color objects and calculates contrasting text colors.
  func mappedColors() -> [(Color, Color, UUID)] {
      return colors.map {
          let bgColor = Color(red: $0.2.0 / 255, green: $0.2.1 / 255, blue: $0.2.2 / 255)
          let textColor = self.contrastingTextColor(for: $0.2)
          return (bgColor, textColor, UUID())
      }
  }

  /// Determines the contrasting text color (black or white) for a given background color.
  private func contrastingTextColor(for rgb: (Double, Double, Double)) -> Color {
      let luminance = 0.299 * rgb.0 + 0.587 * rgb.1 + 0.114 * rgb.2
      return luminance > 186 ? .black : .white
  }
}

/// Provider for generating and saving topics.
class TopicProvider {
  static let shared = TopicProvider()
  private let topicsKey = "selectedTopics"
  private init() {}

  /// Returns a specified number of random topics from a provided list.
  func getRandomTopics(_ count: Int, from topics: [String]) -> [String] {
      return Array(topics.shuffled().prefix(count))
  }

  /// Loads topics from UserDefaults.
  func loadTopics() -> [String] {
      return UserDefaults.standard.stringArray(forKey: topicsKey) ?? []
  }

  /// Saves topics to UserDefaults.
  func saveTopics(_ topics: [String]) {
      UserDefaults.standard.setValue(topics, forKey: topicsKey)
  }
}

/*
Explanation:
1. ContentView:
 - Provides the main interface with a board size selector and a button to navigate to TopicsChooserScreen.

2. TopicsChooserScreen:
 - Provides the interface for selecting and arranging topics.
 - Automatically selects a specific number of random topics based on the board size.
 - Ensures at most three topics per line using a grid layout.
 - Allows rerolling of randomly picked topics once by tapping on them.
 - Includes explanatory text on how changing topics will end the game, and changing colors or ordering can be done via 'Arrange Topics'.
 - Persists selected topics using UserDefaults.

3. TopicSelectorView:
 - Displays the full list of topics and allows users to search and select topics.
 - Uses a list with a search bar.
 - Marks selected topics with a checkmark.
 - Limits the selection to a maximum number of topics based on the board size.

4. ArrangerView:
 - Allows the user to select a color scheme.
 - Displays topics in the same order as they are passed in, with colors changing based on the selected scheme.
 - Ensures all twelve color slots are displayed, even if there are fewer topics.
 - Supports drag-and-drop functionality to reorder topics.
 - Uses LazyVGrid for a 3x4 grid layout for the topic buttons.
 - Includes explanatory text on how to change the colors of the topics by drag and drop.

5. TopicDropDelegate:
 - Handles the drop operation to reorder topics within the list.

6. ColorScheme:
 - Represents a color scheme and maps colors to SwiftUI Color objects, calculating contrasting text colors.
 - Provides a method to get colors for specific topics based on their hash values.

7. TopicProvider:
 - Provides random topics from a list.
 - Manages the persistence of selected topics using UserDefaults.
*/
