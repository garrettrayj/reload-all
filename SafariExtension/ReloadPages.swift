import Foundation
import SafariServices

class ReloadPages {
    static let shared = ReloadPages()
    
    let queue = DispatchQueue(label: "ReloadAllPageQueue")
    
    var pages = Set<SFSafariPage>()
    
    func addPage(page: SFSafariPage) {
        queue.async() {
            let result = self.pages.insert(page)
            if result.inserted {
                NSLog("Page \(page.hash) registered for global reload")
            }
        }
    }
    
    func removePage(page: SFSafariPage) {
        queue.async() {
            self.pages.remove(page)
            NSLog("Cleaned up page \(page.hash)")
        }
    }
    
    func cleanupPages() {
        queue.sync() {
            for page in self.pages {
                page.getPropertiesWithCompletionHandler { (properties) in
                    if properties == nil {
                        self.removePage(page: page)
                    }
                }
            }
        }
    }
    
    func reloadPages() {
        for page in ReloadPages.shared.pages {
            page.getPropertiesWithCompletionHandler { (properties) in
                if properties != nil {
                    page.reload();
                    NSLog("Reloaded page \(page.hash)")
                } else {
                    ReloadPages.shared.pages.remove(page)
                    NSLog("Removed page \(page.hash)")
                }
            }
        }
    }
}
