import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        ReloadPages.shared.pages.insert(page);
        NSLog("Page registered for global reload")
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        NSLog("Reloading all pages")
        for page in ReloadPages.shared.pages {
            page.reload();
        }
    }
}
