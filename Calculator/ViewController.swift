//
//  ViewController.swift
//  Calculator
//
//  Created by Gupta, Mrigank on 07/03/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - properties
    fileprivate let collectionViewCellIdentifier = "calcButtonIdentifier"
    fileprivate let gapBtwButton:CGFloat = 1.0
    fileprivate let row = 5
    fileprivate let column = 4
    fileprivate let totalButton = 19

    fileprivate var viewModel:CalculateViewModel?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = CalculateViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDelegate {
    //MARK: - UICollectionViewDelegate Methods
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let collectionViewCell = collectionView.cellForItem(at: indexPath)
        let keyValueLabel:UILabel? = collectionViewCell?.viewWithTag(1) as? UILabel
        if isOperatorCell(indexPath) {
            keyValueLabel?.textColor = UIColor.black
        }else{
            keyValueLabel?.textColor = UIColor.yellow
        }
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let collectionViewCell = collectionView.cellForItem(at: indexPath)
        let keyValueLabel:UILabel? = collectionViewCell?.viewWithTag(1) as? UILabel
        if isOperatorCell(indexPath) {
            keyValueLabel?.textColor = UIColor.darkGray
        }else{
            keyValueLabel?.textColor = UIColor.white
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let keyPressed = DisplayKeyPad(rawValue: indexPath.item)?.pressed() {
            viewModel?.execute(itemPressed: keyPressed)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    //MARK: - UICollectionViewDataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return totalButton
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath)

        let keyValueLabel:UILabel? = collectionViewCell.viewWithTag(1) as? UILabel
        keyValueLabel?.text = DisplayKeyPad(rawValue: indexPath.item)?.display()

        if isOperatorCell(indexPath) {
            collectionViewCell.backgroundColor = UIColor.yellow
            keyValueLabel?.textColor = UIColor.darkGray
        } else {
            collectionViewCell.backgroundColor = UIColor.darkGray
            keyValueLabel?.textColor = UIColor.white
        }
        return collectionViewCell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    //MARK: - UICollectionViewDelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Width: CGFloat = maxPossibleButtonSize()
        let Height: CGFloat = Width
        var buttonSize:CGSize = CGSize(width: Width, height: Height)

        if indexPath.item == totalButton-1 {
            buttonSize = CGSize(width: Width*2.0+gapBtwButton, height: Height)
        }
        return buttonSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let viewRect:CGRect = self.collectionView.frame
//        print("view rect for inset \(viewRect)")
        let buttonMaxSize = maxPossibleButtonSize()
        let totalWidth:CGFloat = buttonMaxSize*CGFloat(column) + CGFloat(column + 1)*gapBtwButton
        let totalHeight:CGFloat = buttonMaxSize*CGFloat(row) + CGFloat(row + 1)*gapBtwButton
        var horiInset = gapBtwButton
        if viewRect.size.width > totalWidth {
            horiInset = (viewRect.size.width - totalWidth)/CGFloat(2)+gapBtwButton
        }
        var vertInset = gapBtwButton
        if viewRect.size.height > totalHeight {
            vertInset = (viewRect.size.height - totalHeight)/CGFloat(2)+gapBtwButton
        }
//        print("vertical \(vertInset) horizontal \(horiInset)")
        return UIEdgeInsets(top: vertInset, left: horiInset, bottom: vertInset, right: horiInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return gapBtwButton
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return gapBtwButton
    }
}

private extension ViewController {
    //MARK: - Private Methods
    func maxPossibleButtonSize()->CGFloat {
        let viewRect:CGRect = self.collectionView.frame
//        print("view rect \(viewRect)")
        let buttonMaxWidth:CGFloat = (viewRect.size.width - CGFloat(column + 1) * gapBtwButton) / CGFloat(column)
        let buttonMaxHeight:CGFloat  = (viewRect.size.height - CGFloat(row + 1) * gapBtwButton) / CGFloat(row)

        var buttonMaxDimension:CGFloat = buttonMaxHeight
        if buttonMaxWidth < buttonMaxDimension {
            buttonMaxDimension = buttonMaxWidth
        }
        return buttonMaxDimension;
    }
    
    func isOperatorCell(_ indexPath:IndexPath) -> Bool {
        if indexPath.item <= column || (indexPath.item+1)%column == 1 {
            return true
        }
        return false
    }
}
