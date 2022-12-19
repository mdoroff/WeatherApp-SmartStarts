import Foundation
import Cleanse

class LaunchViewModelFactory: Identifiable {
    let id: UUID
    let seed: Launch
    let itemFactory: LaunchListItemVMFactory
    let detailFactory: LaunchDetailVMFactory
    
    init(assisted: Assisted<Launch>, itemFactory: LaunchListItemVMFactory, detailFactory: LaunchDetailVMFactory) {
        self.id = UUID()
        self.seed = assisted.get()
        self.itemFactory = itemFactory
        self.detailFactory = detailFactory
    }
    
    func buildLaunchListItemViewModel() -> LaunchListItemViewModel {
        return itemFactory.build(seed)
    }
    
    func buildLaunchDetailViewModel() -> LaunchDetailViewModel {
        return detailFactory.build(seed.id)
    }
}
