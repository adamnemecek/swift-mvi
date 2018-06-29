import UIKit
import RxCocoa
import RxSwift

class PinyinEnglishViewController : PinyinListViewController<PinyinEnglishViewModel> {
    
    private lazy var pinyinEnglishTableView: PinyinEnglishTableView = {
        let tableView = PinyinEnglishTableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(pinyinEnglishTableView)
    }
    
    override func populate(pinyinList: Array<Pinyin>) {
        pinyinEnglishTableView.populate(pinyin: pinyinList)
    }
    
    override func provideViewModel() -> PinyinEnglishViewModel {
        return PinyinEnglishViewModel()
    }
    
    override func intents() -> Observable<PinyinListIntent> {
        return Observable.merge(
            super.intents(),
            pinyinEnglishTableView.rx.itemSelected
                .asObservable()
                .map { index in self.pinyinEnglishTableView.get(index: index.row) }
                .map { pinyin in PinyinListIntent.SelectItem(pinyin: pinyin) }
        )
    }
}
