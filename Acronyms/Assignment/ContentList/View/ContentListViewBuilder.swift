//
//  ContentListViewBuilder.swift
//  Assignment
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import UIKit



/// This class gives the `ContentListViewController` object.
class ContentListViewBuilder {
     func contentListView() -> UIViewController {
        let viewController = ContentListViewController(viewModel: ContentListViewModel())
        return viewController
    }
}
