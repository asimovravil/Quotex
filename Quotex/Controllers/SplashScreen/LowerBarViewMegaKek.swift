import UIKit
import SnapKit

protocol LowerBarMegaKekDelegate: AnyObject {
    func pop()
    func popToRoot()
}

final class LowerBarViewMegaKek: UIView {
    
    weak var delegate: LowerBarMegaKekDelegate?
    @objc func popImageViewTapped() { delegate?.pop() }
    @objc func rootImageViewTapped() { delegate?.popToRoot() }
    private let popImageView = UIImageView()
    private let rootImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAppearance()
    }
    
    private func setupAppearance() {
        backgroundColor = .black
        setupViews()
        setupValue()
    }
    
    private func setupViews() {
        addSubview(popImageView)
        addSubview(rootImageView)
    }
    
    private func setupValue() {
        popImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(popImageViewTapped)))
        popImageView.image = UIImage(named: "pop")
        popImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(32)
        }
        
        rootImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rootImageViewTapped)))
        rootImageView.image = UIImage(named: "root")
        rootImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.right.equalToSuperview().inset(32)
        }
    }
}
