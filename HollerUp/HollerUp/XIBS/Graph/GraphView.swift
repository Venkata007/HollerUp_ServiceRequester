//
//  GraphView.swift
//  Graph
//
//  Created by Hexadots on 12/03/19.
//  Copyright © 2019 Hexadots. All rights reserved.
//

import UIKit

let QUATER_TITLE = "quaterTitle"
let AMOUNT = "amount"
let DURATION = "duration"
let MONTH = "month"
class GraphView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionViewGraph: UICollectionView!
    @IBOutlet weak var maxValue: UILabel!
    @IBOutlet weak var avgValue: UILabel!
    @IBOutlet weak var minValue: UILabel!
    @IBOutlet weak var durationTitleColorLbl: UILabel!
    @IBOutlet weak var earningsTitleColorLbl: UILabel!
    
    var dataSource = [AnyObject]()
    
    
    @IBInspectable var durationColor: UIColor = #colorLiteral(red: 0.04705882353, green: 0.7137254902, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.updateProperties()
        }
    }
    
    @IBInspectable var earningsColor: UIColor = #colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.431372549, alpha: 1) {
        didSet {
            self.updateProperties()
        }
    }
    
    @IBInspectable var dataReceived: [AnyObject] = [] {
        didSet {
            self.updateDataSource()
        }
    }
    
    @IBInspectable var maxValueOfEarnings: Int = 4000 {
        didSet {
            //self.updateProperties()
        }
    }
    
    @IBInspectable var maxValueOfDuration: Int = 800 {
        didSet {
            //self.updateProperties()
        }
    }
    
    func updateProperties(){
        self.durationTitleColorLbl.backgroundColor = durationColor
        self.earningsTitleColorLbl.backgroundColor = earningsColor
    }
    
    func updateDataSource(){
        self.dataSource = dataReceived
        self.updateValues()
        self.maxValue.text = "$" + "\(maxValueOfEarnings)" + "\n" + "(\(maxValueOfDuration)" + " Min)"
        self.avgValue.text = "$" + "\(maxValueOfEarnings/2)" + "\n" + "(\(maxValueOfDuration/2)" + " Min)"
    }
    
    func updateValues(){
        if self.dataSource.count > 0{
            let maxValueOfDuration = self.dataSource.max { (source1, source2) -> Bool in
                let source1Val = source1 as! [String:String]
                let source2Val = source2 as! [String:String]
                return source1Val[DURATION]!.toInt < source2Val[DURATION]!.toInt
                } as! [String:String]
            let maxValueOfEarnings = self.dataSource.max { (source1, source2) -> Bool in
                let source1Val = source1 as! [String:String]
                let source2Val = source2 as! [String:String]
                return source1Val[AMOUNT]!.toInt < source2Val[AMOUNT]!.toInt
                } as! [String:String]
            let maxValDur = maxValueOfDuration[DURATION]!.toInt
            let maxValEar = maxValueOfEarnings[AMOUNT]!.toInt
            self.maxValueOfDuration = maxValDur +  Int(Double(maxValDur) * 0.3)
            self.maxValueOfEarnings = maxValEar +  Int(Double(maxValEar) * 0.3)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("GraphView", owner: self, options: nil)
        addSubview(self.contentView)
        self.updateProperties()
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.durationTitleColorLbl.roundCorners(corners: .allCorners, radius: 2.0)
        self.earningsTitleColorLbl.roundCorners(corners: .allCorners, radius: 2.0)
        DispatchQueue.main.async {
            self.collectionViewGraph.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
            self.collectionViewGraph.updateConstraints()
            self.collectionViewGraph.delegate = self
            self.collectionViewGraph.dataSource = self
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
}

extension GraphView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
   internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let data = self.dataSource[indexPath.row] as! [String:AnyObject]
        let quaterTitle = data[QUATER_TITLE] as! String
        let duration = data[DURATION] as! String
        let month = data[MONTH] as! String
        let amount = data[AMOUNT] as! String
        let durationHeightCnst = self.updateConstraintsForGraph(duration, earnings: "", maxValue: maxValueOfDuration)
        let earningsHeightCnst = self.updateConstraintsForGraph("", earnings: amount, maxValue: maxValueOfEarnings)
        
        cell.quaterLabel.text = quaterTitle
        cell.earningsCountLbl.text = "$" + amount
        cell.durationLbl.text = duration + " Min"
        cell.monthLbl.text = month
        cell.durationGraphLblHeightConstant.constant = durationHeightCnst
        cell.earningsGraphLblHeightConstant.constant = earningsHeightCnst
        cell.viewInViewHeightConstant.constant = durationHeightCnst > earningsHeightCnst ? durationHeightCnst + 8 : earningsHeightCnst + 8
        cell.durationGraphLbl.backgroundColor = durationColor
        cell.earningsGraphLbl.backgroundColor = earningsColor
        return cell
    }
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(UIDevice.isPhone() ? 75.0 : collectionView.bounds.width/4)
        let height = self.collectionViewGraph.bounds.height 
        let sizeOfCell = CGSize(width: width, height: height)
        print(sizeOfCell)
        return sizeOfCell
    }
    internal func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    internal func updateConstraintsForGraph(_ duration:String, earnings:String, maxValue:Int) -> CGFloat {
        let valueOfConstarint = duration.length == 0 ? earnings : duration
        let collectionViewHeight = self.collectionViewGraph.bounds.height
        let durationRatio = CGFloat(Int(valueOfConstarint)!) / CGFloat(maxValue)
        let constraint = CGFloat(collectionViewHeight * durationRatio) - 35
        /* *
         we are substracting 35 because of Month lable height was 25 + line label height was 2 + and maxvalue horizontal spacing was 8 from main view, so cell height must reduce to 35.
         */
        return constraint
    }
}

extension String{
    public var length:Int{
        return self.count
    }
    public var toInt:Int{
        return Int(self) ?? 0
    }
}
