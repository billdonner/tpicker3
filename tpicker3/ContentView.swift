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
            ContentView(allTopics: allTopics, schemes: schemes)
        }
    }
}

struct ContentView: View {
    let allTopics: [String]
    let schemes: [ColorScheme]
    @State private var showSheet = false
    @State private var selectedSchemeIndex = 3 // Initial scheme index set to Winter
    @State private var topics: [(id: UUID, name: String, schemeIndex: Int)] = []

    init(allTopics: [String], schemes: [ColorScheme]) {
        self.allTopics = allTopics
        self.schemes = schemes
        _topics = State(initialValue: TopicProvider.shared.getRandomTopics(7, from: allTopics).map { (UUID(), $0, 3) })
    }

    var body: some View {
        VStack {
            Button("Adjust Colors") {
                showSheet.toggle()
            }
            .fullScreenCover (isPresented: $showSheet) {
                TopicSelectorView(topics: $topics, selectedSchemeIndex: $selectedSchemeIndex, schemes: schemes)
            }
          Spacer(minLength: 100.0)
            ScrollView {
                ForEach(topics.indices, id: \.self) { index in
                    let topic = topics[index]
                    let colorInfo = schemes[selectedSchemeIndex].mappedColors()[index % schemes[selectedSchemeIndex].colors.count]
                    Text(topic.name)
                        .padding()
                        .background(colorInfo.0)
                        .foregroundColor(colorInfo.1)
                        .cornerRadius(8)
                        .padding(2)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(allTopics: allTopics, schemes: schemes)
    }
}

struct TopicSelectorView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var topics: [(id: UUID, name: String, schemeIndex: Int)]
 

  @Binding var selectedSchemeIndex: Int // Binding to reflect changes back to ContentView
  let schemes: [ColorScheme]

  var body: some View {

      VStack {
        Button("Done") {
            presentationMode.wrappedValue.dismiss()
        }
          Text("1 - Choose Color Scheme")
              .padding(.top)

          Picker("Color Schemes", selection: $selectedSchemeIndex) {
              ForEach(0..<schemes.count, id: \.self) { index in
                  Text(schemes[index].name)
              }
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding()
        
            Text("2 - Rearrange Topics and Colors")
          ScrollView {
              VStack {
                  // Ensure all 12 color slots are displayed, and topics are displayed in the same order as in ContentView
                  ForEach(0..<12, id: \.self) { index in
                      let colorInfo = schemes[selectedSchemeIndex].mappedColors()[index]
                      if index < topics.count {
                          let topic = topics[index]
                          HStack {
                              Text(topic.name)
                                  .padding()
                                  .background(colorInfo.0)
                                  .foregroundColor(colorInfo.1)
                                  .cornerRadius(8)
                                  .onDrag { NSItemProvider(object: NSString(string: topic.name)) }
                                  .onDrop(of: [UTType.text], delegate: TopicDropDelegate(topic: topic, topics: $topics, fromIndex: index))
                          }
                      } else {
                          HStack {
                              Text("Empty")
                                  .padding()
                                  .background(colorInfo.0)
                                  .foregroundColor(colorInfo.1)
                                  .cornerRadius(8)
                                  .onDrop(of: [UTType.text], delegate: TopicDropDelegate(topic: (id: UUID(), name: "Empty", schemeIndex: selectedSchemeIndex), topics: $topics, fromIndex: index))
                          }
                      }
                  }
              }
          }
          .padding()

 
      }
  }
}

struct TopicDropDelegate: DropDelegate {
  let topic: (id: UUID, name: String, schemeIndex: Int)
  @Binding var topics: [(id: UUID, name: String, schemeIndex: Int)]
  let fromIndex: Int

  func performDrop(info: DropInfo) -> Bool {
      guard let item = info.itemProviders(for: [UTType.text]).first else {
          return false
      }

      item.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { (data, error) in
          DispatchQueue.main.async {
              if let data = data as? Data, let text = String(data: data, encoding: .utf8) {
                  guard let fromIndex = topics.firstIndex(where: { $0.name == text }) else { return }
                  let fromTopic = topics.remove(at: fromIndex)
                  let toIndex = topics.firstIndex(where: { $0.id == topic.id }) ?? topics.endIndex
                  topics.insert((fromTopic.id, fromTopic.name, topic.schemeIndex), at: toIndex)
              }
          }
      }
      return true
  }
}

struct TopicSelectorView_Previews: PreviewProvider {
  static var previews: some View {
      TopicSelectorView(
          topics: .constant([
              (UUID(), "Topic 1", 0),
              (UUID(), "Topic 2", 1),
              (UUID(), "Topic 3", 2)
          ]),
          selectedSchemeIndex: .constant(3), // Initial scheme index set to Winter
          schemes: schemes
      )
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

/// Provider for generating random topics.
class TopicProvider {
  static let shared = TopicProvider()
  private init() {}

  /// Returns a specified number of random topics from a provided list.
  func getRandomTopics(_ count: Int, from topics: [String]) -> [String] {
      return Array(topics.shuffled().prefix(count))
  }
}
