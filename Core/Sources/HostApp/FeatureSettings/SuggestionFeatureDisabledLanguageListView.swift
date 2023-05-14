import SuggestionModel
import SwiftUI

struct SuggestionFeatureDisabledLanguageListView: View {
    final class Settings: ObservableObject {
        @AppStorage(\.suggestionFeatureDisabledLanguageList)
        var suggestionFeatureDisabledLanguageList: [String]

        init(suggestionFeatureDisabledLanguageList: AppStorage<[String]>? = nil) {
            if let list = suggestionFeatureDisabledLanguageList {
                _suggestionFeatureDisabledLanguageList = list
            }
        }
    }

    var isOpen: Binding<Bool>
    @State var isAddingNewProject = false
    @StateObject var settings = Settings()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    self.isOpen.wrappedValue = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                        .padding()
                }
                .buttonStyle(.plain)
                Text("Enabled Projects")
                Spacer()
                Button(action: {
                    isAddingNewProject = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.secondary)
                        .padding()
                }
                .buttonStyle(.plain)
            }
            .background(Color(nsColor: .separatorColor))

            List {
                ForEach(
                    settings.suggestionFeatureDisabledLanguageList,
                    id: \.self
                ) { language in
                    HStack {
                        Text(language.capitalized)
                            .contextMenu {
                                Button("Remove") {
                                    settings.suggestionFeatureDisabledLanguageList.removeAll(
                                        where: { $0 == language }
                                    )
                                }
                            }
                        Spacer()

                        Button(action: {
                            settings.suggestionFeatureDisabledLanguageList.removeAll(
                                where: { $0 == language }
                            )
                        }) {
                            Image(systemName: "trash.fill")
                                .foregroundStyle(.secondary)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .removeBackground()
            .overlay {
                if settings.suggestionFeatureDisabledLanguageList.isEmpty {
                    Text("""
                    Empty
                    Disable the language of a file by right clicking the circular widget.
                    """)
                    .multilineTextAlignment(.center)
                }
            }
        }
        .focusable(false)
        .frame(width: 300, height: 400)
        .background(Color(nsColor: .windowBackgroundColor))
    }
}

struct SuggestionFeatureDisabledLanguageListView_Preview: PreviewProvider {
    static var previews: some View {
        SuggestionFeatureDisabledLanguageListView(
            isOpen: .constant(true),
            settings: .init(suggestionFeatureDisabledLanguageList: .init(wrappedValue: [
                "hello/2",
                "hello/3",
                "hello/4",
            ], "SuggestionFeatureDisabledLanguageListView_Preview"))
        )
    }
}

