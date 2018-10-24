import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        page.getPropertiesWithCompletionHandler { (properties) in
            if let properties = properties {
                // Exclude system pages like new tab view
                if properties.url != nil {
                    ReloadPages.shared.addPage(page: page)
                }
            }
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        NSLog("Reloading all (\(ReloadPages.shared.pages.count)) pages")
        ReloadPages.shared.reloadPages();
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        ReloadPages.shared.cleanupPages()
        validationHandler(true, "")
    }
}
