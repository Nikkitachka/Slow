//
//  SummaryViewController.swift
//  Slow
//
//  Created by Петр Ларочкин on 01.11.2021.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth


class SummaryViewController: UIViewController {
    // MARK: MyCode
    
    private var defaultCup = "defaultCup"
    private var checkDateFormater : DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "ddMMyyyy"
        return df
    }()
    
    private var currentDownloadDate = Date()
    private lazy var database = Database.database().reference()
    private var currentCountOfCups: Int = {
        var ans = 0
        return ans
    }()
    
    private var goalCountOfCups: Int = {
        var ans = 0
        return ans
    }()
    
    private var indicator : UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.translatesAutoresizingMaskIntoConstraints = false
        ind.backgroundColor = .clear
        return ind
    }()
    
    private lazy var headingView : UILabel = {
        let label = UILabel()
        label.text = "Обзор"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = .boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var waterProgressBar : UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .clear
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isUserInteractionEnabled = false
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.value = 0.5
        slider.backgroundColor = .white
        slider.tintColor = UIColor(red: 168/255, green: 245/255, blue: 242/255, alpha: 1)
        
        return slider
    }()
    
    private lazy var currentCupsLabel : UILabel = {
        let label = UILabel()
        label.text = "Выпито: \(currentCountOfCups)/\(goalCountOfCups)"
        label.textAlignment = .left
        label.backgroundColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var glassChecker: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect(),
                                          collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CupCollectionViewCell.self, forCellWithReuseIdentifier: "CupCollectionViewCell")
        collection.backgroundColor = .white
        return collection
        
    }()
    
    // MARK: CopyPasteCode
    // MARK: Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var headerView = CalendarPickerHeaderView { [weak self] in
        guard let self = self else { return }
        
        self.dismiss(animated: true)
    }
    
    private lazy var footerView = CalendarPickerFooterView(
        didTapLastMonthCompletionHandler: { [weak self] in
            guard let self = self else { return }
            
            self.baseDate = self.calendar.date(
                byAdding: .month,
                value: -1,
                to: self.baseDate
            ) ?? self.baseDate
        },
        didTapNextMonthCompletionHandler: { [weak self] in
            guard let self = self else { return }
            
            self.baseDate = self.calendar.date(
                byAdding: .month,
                value: 1,
                to: self.baseDate
            ) ?? self.baseDate
        })
    
    // MARK: Calendar Data Values
    
    private let selectedDate: Date
    private var baseDate: Date {
        didSet {
            days = generateDaysInMonth(for: baseDate)
            collectionView.reloadData()
            headerView.baseDate = baseDate
        }
    }
    
    private lazy var days = generateDaysInMonth(for: baseDate)
    
    private var numberOfWeeksInBaseDate: Int {
        calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }
    
    
    private let selectedDateChanged: ((Date) -> Void)
    private let calendar = Calendar(identifier: .gregorian)
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    
    // MARK: Initializers
    
    init(baseDate: Date = Date(), selectedDateChanged: @escaping ((Date) -> Void)) {
        self.selectedDate = baseDate
        self.baseDate = baseDate
        self.selectedDateChanged = selectedDateChanged
        //        self.currentCountOfCups = 3
        //        self.goalCountOfCups = 4
        super.init(nibName: nil, bundle: nil)
        
        
        
        
        
        
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        definesPresentationContext = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    func reloadDataByDate(_ actualDate: Date){
        indicator.isHidden = false
        indicator.startAnimating()
        
        let user = database.child(Auth.auth().currentUser!.uid)
        user.child("cups").observe(.value, with: {snapshot in
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "ddMMyyyy"
            let date = dateFormatterPrint.string(from: actualDate)
            if let value = snapshot.value as? Int {
                self.goalCountOfCups = value
                user.child("history").child(date).observe(.value, with: {anotherSnapshot in
                    if let anotherValue = anotherSnapshot.value as? Int {
                        self.currentCountOfCups = anotherValue
                        self.updateLabel()
                        self.updateProgressBar()
                        dateFormatterPrint.dateFormat = "dd.MM.yyyy"
                        let adds = dateFormatterPrint.string(from: actualDate) == dateFormatterPrint.string(from: self.baseDate) ? "" : dateFormatterPrint.string(from: actualDate)
                        self.currentCupsLabel.text = "Выпито: \(anotherValue)/\(self.goalCountOfCups) " + adds
                    } else {
                        self.currentCupsLabel.text = "Выпито: ?/\(self.goalCountOfCups)"
                        self.currentCountOfCups = 0
                        
                    }
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    self.glassChecker.reloadData()
                    
                    
                })
            }
        })
    }
    
    private func updateProgressBar(){
        self.waterProgressBar.setValue(Float(currentCountOfCups) / Float(goalCountOfCups), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        collectionView.backgroundColor = .systemGroupedBackground
        view.backgroundColor = .white
        currentDownloadDate = baseDate
        view.addSubview(collectionView)
        view.addSubview(headerView)
        view.addSubview(footerView)
        view.addSubview(headingView)
        view.addSubview(waterProgressBar)
        view.addSubview(currentCupsLabel)
        view.addSubview(glassChecker)
        indicator.isHidden = false
        headingView.addSubview(indicator)
        
        let indicator_constraints = [
            indicator.leftAnchor.constraint(equalTo: headingView.leftAnchor),
            indicator.topAnchor.constraint(equalTo: headingView.topAnchor),
            indicator.bottomAnchor.constraint(equalTo: headingView.bottomAnchor),
            indicator.widthAnchor.constraint(equalTo: indicator.heightAnchor)
        ]
        NSLayoutConstraint.activate(indicator_constraints)
        reloadDataByDate(Date())
        
        let glassChecker_constraints = [
            glassChecker.topAnchor.constraint(equalTo: currentCupsLabel.bottomAnchor),
            glassChecker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.defaultSideInsets),
            glassChecker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.defaultSideInsets),
            glassChecker.heightAnchor.constraint(equalToConstant: Constants.defaultCupCellSize * (1 + 2/8))
            
        ]
        NSLayoutConstraint.activate(glassChecker_constraints)
        let currentCupsLabel_constraints = [
            currentCupsLabel.topAnchor.constraint(equalTo: waterProgressBar.bottomAnchor),
            currentCupsLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.defaultSideInsets),
            currentCupsLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.defaultSideInsets),
            currentCupsLabel.heightAnchor.constraint(equalToConstant: Constants.heightOfCurrentCupsLabel)
        ]
        NSLayoutConstraint.activate(currentCupsLabel_constraints)
        let waterProgressBar_constraints = [
            waterProgressBar.topAnchor.constraint(equalTo: headingView.bottomAnchor),
            waterProgressBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            waterProgressBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            waterProgressBar.heightAnchor.constraint(equalToConstant: Constants.heightOfwaterProgressBar)
        ]
        NSLayoutConstraint.activate(waterProgressBar_constraints)
        let headingView_constraints = [
            headingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.heightOfHeadingView),
        ]
        NSLayoutConstraint.activate(headingView_constraints)
        
        
        
        let calendar_constraints = [
            headerView.leftAnchor.constraint(equalTo: collectionView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: collectionView.rightAnchor),
            headerView.topAnchor.constraint(equalTo: glassChecker.bottomAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 85),
            
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.defaultSideInsets),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.defaultSideInsets),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            footerView.leftAnchor.constraint(equalTo: collectionView.leftAnchor),
            footerView.rightAnchor.constraint(equalTo: collectionView.rightAnchor),
            footerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 60),
            //          на всякий случай
            footerView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        
        NSLayoutConstraint.activate(calendar_constraints)
        
        collectionView.register(
            CalendarDateCollectionViewCell.self,
            forCellWithReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        headerView.baseDate = baseDate
    }
    
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    func updateLabel () {
        currentCupsLabel.text = "Выпито: \(currentCountOfCups)/\(goalCountOfCups)"
    }
    override func viewWillAppear(_ animated: Bool) {
        database.child(Auth.auth().currentUser!.uid).child("defaultCup").observe(.value, with: {snapshot in
            debugPrint("hey")
            if let cup = snapshot.value as? String {
                if cup != self.defaultCup {
                    self.defaultCup = cup
                    self.glassChecker.reloadData()
                }
            }
        })
    }
    
}

// MARK: - Day Generation
private extension SummaryViewController {
    // 1
    func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
        // 2
        guard
            let numberOfDaysInMonth = calendar.range(
                of: .day,
                in: .month,
                for: baseDate)?.count,
            let firstDayOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
            // 3
            throw CalendarDataError.metadataGeneration
        }
        
        // 4
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        // 5
        return MonthMetadata(
            numberOfDays: numberOfDaysInMonth,
            firstDay: firstDayOfMonth,
            firstDayWeekday: firstDayWeekday)
    }
    
    
    // 1
    func generateDaysInMonth(for baseDate: Date) -> [Day] {
        // 2
        guard let metadata = try? monthMetadata(for: baseDate) else {
            preconditionFailure("An error occurred when generating the metadata for \(baseDate)")
        }
        
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        
        // 3
        var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow))
            .map { day in
                // 4
                let isWithinDisplayedMonth = day >= offsetInInitialRow
                // 5
                let dayOffset =
                isWithinDisplayedMonth ?
                day - offsetInInitialRow :
                -(offsetInInitialRow - day)
                
                // 6
                return generateDay(
                    offsetBy: dayOffset,
                    for: firstDayOfMonth,
                    isWithinDisplayedMonth: isWithinDisplayedMonth)
            }
        
        days += generateStartOfNextMonth(using: firstDayOfMonth)
        
        return days
    }
    
    // 7
    func generateDay(
        offsetBy dayOffset: Int,
        for baseDate: Date,
        isWithinDisplayedMonth: Bool
    ) -> Day {
        let date = calendar.date(
            byAdding: .day,
            value: dayOffset,
            to: baseDate)
        ?? baseDate
        
        return Day(
            date: date,
            number: dateFormatter.string(from: date),
            isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
            isWithinDisplayedMonth: isWithinDisplayedMonth,
            isDownloaded: checkDateFormater.string(from: date) == checkDateFormater.string(from: currentDownloadDate)
        )
    }
    
    // 1
    func generateStartOfNextMonth(
        using firstDayOfDisplayedMonth: Date
    ) -> [Day] {
        // 2
        guard
            let lastDayInMonth = calendar.date(
                byAdding: DateComponents(month: 1, day: -1),
                to: firstDayOfDisplayedMonth)
        else {
            return []
        }
        
        // 3
        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else {
            return []
        }
        
        // 4
        let days: [Day] = (1...additionalDays)
            .map {
                generateDay(
                    offsetBy: $0,
                    for: lastDayInMonth,
                    isWithinDisplayedMonth: false)
            }
        
        return days
    }
    
    enum CalendarDataError: Error {
        case metadataGeneration
    }
}

// MARK: - UICollectionViewDataSource
extension SummaryViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView == self.collectionView {
            return days.count
        } else {
            return currentCountOfCups + 1
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        if collectionView == self.glassChecker {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CupCollectionViewCell", for: indexPath) as! CupCollectionViewCell
            
            if indexPath[1] == 0 {
                cell.cellForAdd()
            } else {
                cell.image.image = UIImage(named: defaultCup)
                cell.defaultCell()
            }
            
            return cell
            
        } else {
            let day = days[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier,
                for: indexPath) as! CalendarDateCollectionViewCell
            // swiftlint:disable:previous force_cast
            //            before
            //            cell.day = day
            
            //            return cell
            //            after
            
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "ddMMyyyy"
            
            //            dateFormatterPrint.string(from: baseDate)
            //            dateFormatterPrint.string(from: currentDownloadDate)
            //            dateFormatterPrint.string(from: day.date)
            
            //            cell.numberLabel.textColor = .systemBlue
            //            if dateFormatterPrint.string(from: day.date) == dateFormatterPrint.string(from: baseDate) {
            //                cell.applySelectedStyle()
            ////                cell.numberLabel.textColor = .systemBlue
            //            }
            //            if dateFormatterPrint.string(from: day.date) != dateFormatterPrint.string(from: currentDownloadDate){
            //                cell.numberLabel.textColor = .black
            //            }
            cell.day = day
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SummaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if collectionView == self.glassChecker {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "ddMMyyyy"
            
            if dateFormatterPrint.string(from: baseDate) == dateFormatterPrint.string(from: currentDownloadDate) {
                if indexPath[1] == 0 {
                    self.currentCountOfCups += 1
                    let lastSection = collectionView.numberOfSections - 1
                    collectionView.insertItems(at: [IndexPath(row: self.currentCountOfCups, section: lastSection)])
                    let indexPath = IndexPath(row: 0, section: lastSection)
                    collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
                } else {
                    
                    collectionView.deleteItems(at: [IndexPath(item: indexPath.item, section: 0)])
                    self.currentCountOfCups -= 1
                }
                indicator.isHidden = false
                indicator.startAnimating()
                let user = database.child(Auth.auth().currentUser!.uid)
                let date = dateFormatterPrint.string(from: currentDownloadDate)
                user.child("history").child(date).setValue(currentCountOfCups, withCompletionBlock: {(err,_) in
                    if let _ = err {
                        debugPrint("ЧТо-то плохое в присваивании")
                    }else {
                        self.indicator.isHidden = true
                        self.indicator.stopAnimating()
                        
                    }
                })
                waterProgressBar.setValue(Float(currentCountOfCups) / Float(goalCountOfCups), animated: true)
                currentCupsLabel.text = "Выпито: \(currentCountOfCups)/\(goalCountOfCups)"
            }
            
        } else {
            
            if let defaultCell = (collectionView.visibleCells as! [CalendarDateCollectionViewCell]).first(where: {$0.numberLabel.textColor == .systemBlue })
            {
                if defaultCell.selectionBackgroundView.isHidden {
                    defaultCell.applyDefaultStyle(isWithinDisplayedMonth: true, textColor: .black)
                    
                }
                else {
                    defaultCell.numberLabel.textColor = .black
                }
                if let cell = collectionView.cellForItem(at: indexPath) as? CalendarDateCollectionViewCell {
                    if cell.selectionBackgroundView.isHidden  {
                        if (cell.numberLabel.textColor == .secondaryLabel){
                            defaultCell.numberLabel.textColor = .systemBlue
                            currentDownloadDate = cell.day!.date
                        }}}
            }
            if let cell = collectionView.cellForItem(at: indexPath) as? CalendarDateCollectionViewCell {
                if cell.selectionBackgroundView.isHidden  {
                    if (cell.numberLabel.textColor != .secondaryLabel){
                        cell.numberLabel.textColor = .systemBlue
                        currentDownloadDate = cell.day!.date
                        reloadDataByDate(cell.day!.date)
                    }
                } else {
                    if (cell.numberLabel.textColor != .secondaryLabel){
                        cell.numberLabel.textColor = .systemBlue
                        currentDownloadDate = cell.day!.date
                        reloadDataByDate(cell.day!.date)
                        
                    }
                }
            }
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == self.collectionView {
            let width = Int(collectionView.frame.width / 7)
            let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: Constants.defaultCupCellSize, height: Constants.defaultCupCellSize)
        }
        
    }
}

private extension SummaryViewController{
    struct Constants {
        static let heightOfHeadingView: CGFloat = 50
        static let heightOfwaterProgressBar: CGFloat = 5
        static let heightOfCurrentCupsLabel: CGFloat = 50
        static let heightOfGlassChecker: CGFloat = 90
        static let defaultSideInsets: CGFloat = 12
        static let defaultCornerRadius: CGFloat = 12
        static let defaultCupCellSize: CGFloat = 80
    }
}
