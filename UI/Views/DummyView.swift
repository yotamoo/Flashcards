//
//  DummyView.swift
//  UI
//
//  Created by Yotam Ohayon on 18.10.21.
//

import SwiftUI
import Common

public struct DummyViewState: Identifiable {
    public let id: UUID
    public var title: String
    public var done: Bool

    public init(id: UUID = .init(),
                title: String = "",
                done: Bool = false) {
        self.id = id
        self.title = title
        self.done = done
    }

    public init(fromDummyModel dumyModel: DummyModel) {
        self.id = dumyModel.id
        self.title = dumyModel.title
        self.done = dumyModel.done
    }
}

public struct DummyView: View {
    private var models: Binding<[DummyModel]>

    public init(models: Binding<[DummyModel]>) {
        self.models = models
    }

    public var body: some View {
        List {
            ForEach(models.indices) { index in
                HStack {
                    TextField("Buy milk...", text: models.projectedValue[index].title)
                    Toggle(isOn: models.projectedValue[index].done, label: {
                        EmptyView()
                    }).labelsHidden()
                }
            }
        }
    }
}

extension Array where Element == DummyModel {
    static var empty: Self { [] }
    static var big: Self {
        [Int](1...100).map {
        DummyModel(title: $0 % 2 == 0 ? "Task \($0)" : "",
                   done: $0 % 2 == 0)
        }
    }
}

struct DummyView_Previews: PreviewProvider {
    struct DummyViewWrapper: View {
        @State var models: [DummyModel] = .big

        var body: some View {
            DummyView(models: $models)
        }
    }

    static var previews: some View {
        DummyViewWrapper()
    }
}
