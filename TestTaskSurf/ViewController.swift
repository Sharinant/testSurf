//
//  ViewController.swift
//  TestTaskSurf
//
//  Created by Антон Шарин on 14.02.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func joinAction(_ sender: Any) {
        let alert = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    let viewModel = HomeViewModel()
    
    var collectionHeightConstraint : NSLayoutConstraint?
    var imageViewHeightConstraint : NSLayoutConstraint?
    var oldContentOffset = CGPointZero
    let topConstraintRange = (CGFloat(0)..<CGFloat(510))
    
    
    
    //    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //    layoutCollectionView()
        //    layoutImageView()
    }
    
    
    
    private func createCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 50
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
        collectionView.register(FirstCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FirstCollectionReusableView.identifier)
        collectionView.register(SecondCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SecondCollectionReusableView.identifier)
        
//        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        collectionView.collectionViewLayout = layout
//        collectionView.isPagingEnabled = true
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        
    }
    
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let supplementaryViews = [NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(170)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)]
        
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                let section = self.createFirstSection()
                section.boundarySupplementaryItems = supplementaryViews
                return section
                
            case 1:
                let section = self.createSecondSection()
                section.boundarySupplementaryItems = supplementaryViews
                
                return section
                
                
                
                
            default:
                return self.createFirstSection()
                
            }
        }
        
        return layout
    }
    
    
    func createFirstSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(70))
        
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    func createSecondSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(100))
        
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 10, trailing: 0)
        return section
    }
    
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as? ButtonCollectionViewCell else {return UICollectionViewCell()}
        cell.setup(with: viewModel.giveName(for: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FirstCollectionReusableView.identifier, for: indexPath) as? FirstCollectionReusableView else {return UICollectionReusableView()}
            view.setup()
            return view
        case 1:
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SecondCollectionReusableView.identifier, for: indexPath) as? SecondCollectionReusableView else {return UICollectionReusableView()}
            view.setup()
            return view
        default:
            return UICollectionReusableView()
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
       let delta =  scrollView.contentOffset.y - oldContentOffset.y

       //we compress the top view
        if delta > 0 && imageViewHeight.constant > topConstraintRange.lowerBound && scrollView.contentOffset.y > 0 {
            imageViewHeight.constant -= delta
           scrollView.contentOffset.y -= delta
       }

      // we expand the top view
        if delta < 0 && imageViewHeight.constant  < topConstraintRange.upperBound && scrollView.contentOffset.y < 0{
            imageViewHeight.constant -= delta 
           scrollView.contentOffset.y -= delta
       }

       oldContentOffset = scrollView.contentOffset
    }
    
}
