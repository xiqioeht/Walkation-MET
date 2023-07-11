//
//  NavigationViewController.swift
//  Walkation (iOS)
//
//  Created by Matt on 1/6/2023.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation
import SwiftUI
class NavigationViewController: UIViewController {

    var directionsLabel = UITextView()
    var searchBar = UISearchBar()
    var mapView = MKMapView()
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D!
    
    var steps = [MKRoute.Step]()
    
    var stepCounter = 0
    
    var timer: Timer? //導航timer
    var areaTimer: Timer? //檢測圍欄timer
    let myview = UIImageView()
    let myimage  = UIImageView()
    let mybutton = UIButton(type: .system)
    let mytextview = UITextView()
    var currentNavigationPark = ""
    var h1 = 0.0
    var h2 = 0.0
    var d1 = 0.0
    var d2 = 0.0
    
    //center point
    var k111 = 0.0
    var k11 = 0.0
    var k2 = 0.0
    var k22 = 0.0
    var k333 = 0.0
    var k33 = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        //本畫面的背景顏色
        view.backgroundColor = .white
        
      /*  //前端代碼
        directionsLabel.frame = CGRect(x: 10, y: 50, width: self.view.frame.width - 20, height: 100)
        directionsLabel.textColor = .black
        directionsLabel.backgroundColor = .clear
        directionsLabel.isEditable = false
        directionsLabel.text = "這裡會顯示導航實時位置......."
        self.view.addSubview(directionsLabel)
       */
    /*    searchBar.frame = CGRect(x: 0, y: 120, width: self.view.frame.width , height: 50)
        searchBar.backgroundColor = .clear
        searchBar.placeholder = "在此輸入目的地位置進行導航"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        self.view.addSubview(searchBar)
     */
        mapView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        mapView.delegate = self
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.297127512853546, longitude: 114.17800497630509), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.setRegion(region, animated: true)
        
        
        self.view.addSubview(mapView)
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: "customAnnotation")
        //位置權限
        locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
         //   locationManager.startUpdatingLocation()
        
      /*  locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation*/
       
        

        //圍欄地圖
        // 1. 將地圖中心設定為香港,調較數據
   /*   let initialLocation = CLLocation(latitude: 22.30312, longitude: 114.17169)
        let regionRadius: CLLocationDistance = 2000
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.mapType = .standard*/

        
    draw()
    bottomSelectViewUI()
        
   // doHh(key: "center")
    }
    
  



   
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    func bottomSelectViewUI(){
     
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)

       
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        scrollView.addSubview(stackView)

        // Add constraints for stack view
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            scrollView.heightAnchor.constraint(equalToConstant: 150),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
 
        // Add subviews to stack view
     //Group 279266
      
        
        for i in 0..<3 {
            let subview = UIView()
          
            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.widthAnchor.constraint(equalToConstant: 220).isActive = true
            subview.layer.cornerRadius = 20
            subview.backgroundColor = .clear
            subview.tag = i
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(locationAnimationTap))
            subview.addGestureRecognizer(tapGesture)

            let imageView = UIImageView(image: UIImage(named: "背景卡片")) // Replace "yourImageName" with the name of your image file
          //  let imageView = UIImageView()
          //  imageView.backgroundColor = .white
            imageView.translatesAutoresizingMaskIntoConstraints = false
            subview.addSubview(imageView)

            // Add constraints for image view
          NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: subview.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: subview.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: subview.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: subview.bottomAnchor)
            ])

            stackView.addArrangedSubview(subview)
        
            
            
            
            let myimage = UIImageView()
            myimage.frame = CGRect(x: 10, y: 10, width: 80, height: 120)
            if(i == 0){
                myimage.image = UIImage(named: "park1")
                subview.addSubview(myimage)
                
                
                let mylabel1 = UILabel()
                mylabel1.text = "West Kowloon Park"
                mylabel1.frame = CGRect(x: 90, y: 30, width: 130, height: 30)
                mylabel1.textColor = .black
              
                mylabel1.font = UIFont.systemFont(ofSize: 13)
                subview.addSubview(mylabel1)
                
                let mylabel2 = UITextView()
                mylabel2.text = "The Art Park is an urban oasis with a spacious lawn"
                mylabel2.isEditable = false
                mylabel2.isSelectable = false
                mylabel2.font = UIFont.systemFont(ofSize: 9)
                mylabel2.backgroundColor = .clear
                mylabel2.frame = CGRect(x: 90, y: 50, width: 110, height: 50)
                mylabel2.textAlignment = .left
                mylabel2.textColor = .black
                subview.addSubview(mylabel2)
                
                let image1 = UIImageView()
                image1.frame = CGRect(x: 85, y: 110, width: 45, height: 20)
                image1.image = UIImage(named: "Frame 279310")
                subview.addSubview(image1)
               
                let image2 = UIImageView()
                image2.frame = CGRect(x: 145, y: 110, width: 45, height: 20)
                image2.image = UIImage(named: "Group 279270")
                subview.addSubview(image2)
            }else if(i == 1){
                myimage.image = UIImage(named: "park2")
                subview.addSubview(myimage)
                
                
                let mylabel1 = UILabel()
                mylabel1.text = "Kowloon Park"
                mylabel1.frame = CGRect(x: 90, y: 30, width: 130, height: 30)
                mylabel1.textColor = .black
                mylabel1.font = UIFont.systemFont(ofSize: 13)
            
                subview.addSubview(mylabel1)
                
                let mylabel2 = UITextView()
                mylabel2.text = "Kowloon's ace park with a long history"
                mylabel2.isEditable = false
                mylabel2.font = UIFont.systemFont(ofSize: 9)
                mylabel2.isSelectable = false
                mylabel2.backgroundColor = .clear
                mylabel2.frame = CGRect(x: 90, y: 50, width: 130, height: 50)
                mylabel2.textAlignment = .left
                mylabel2.textColor = .black
                subview.addSubview(mylabel2)
                
                let image1 = UIImageView()
                image1.frame = CGRect(x: 85, y: 110, width: 45, height: 20)
                image1.image = UIImage(named: "Group 279268")
                subview.addSubview(image1)
               
                let image2 = UIImageView()
                image2.frame = CGRect(x: 145, y: 110, width: 45, height: 20)
                image2.image = UIImage(named: "Group 279270")
                subview.addSubview(image2)
            }else{
                myimage.image = UIImage(named: "park3")
                subview.addSubview(myimage)
                
                
                let mylabel1 = UILabel()
                mylabel1.text = "Waterfront Park"
                mylabel1.frame = CGRect(x: 90, y: 30, width: 130, height: 30)
                mylabel1.textColor = .black
               
                mylabel1.font = UIFont.systemFont(ofSize: 13)
                subview.addSubview(mylabel1)
                
                let mylabel2 = UITextView()
                mylabel2.text = "Water front promenade with views of the skyline"
                mylabel2.isEditable = false
                mylabel2.font = UIFont.systemFont(ofSize: 9)
                mylabel2.backgroundColor = .clear
                mylabel2.frame = CGRect(x: 90, y: 50, width: 110, height: 50)
                mylabel2.textAlignment = .left
                mylabel2.textColor = .black
                mylabel2.isSelectable = false
                subview.addSubview(mylabel2)
                
                let image1 = UIImageView()
                image1.frame = CGRect(x: 85, y: 110, width: 45, height: 20)
                image1.image = UIImage(named: "Frame 279310")
                subview.addSubview(image1)
               
                let image2 = UIImageView()
                image2.frame = CGRect(x: 145, y: 110, width: 45, height: 20)
                image2.image = UIImage(named: "Group 279270")
                subview.addSubview(image2)
            }
         
            
           
        }
  
       
        
       
    }
    
    
    @objc func buttonTapped(_ sender: UIButton) {
 //22.396692, 114.147604
        // 設置目標座標位置
           let targetCoordinate = CLLocationCoordinate2D(latitude: 22.30312, longitude: 114.17169)
           
           // 創建一個地圖視圖的中心點位置
           let center = CLLocationCoordinate2D(latitude: targetCoordinate.latitude, longitude: targetCoordinate.longitude)
           
           // 創建一個地圖視圖的縮放級別
           let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
           
           // 創建一個地圖視圖的顯示區域
           let region = MKCoordinateRegion(center: center, span: span)
           
           // 計算移動地圖的步數
           let steps = 500
           let stepLat = (targetCoordinate.latitude - mapView.region.center.latitude) / Double(steps)
           let stepLon = (targetCoordinate.longitude - mapView.region.center.longitude) / Double(steps)
           
           // 開始滾動地圖
           var currentStep = 0
           Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
               guard let self = self else {
                   timer.invalidate()
                   return
               }
               
               // 計算新的中心座標
               let newCenter = CLLocationCoordinate2D(latitude: self.mapView.region.center.latitude + stepLat, longitude: self.mapView.region.center.longitude + stepLon)
               
               // 創建新的顯示區域
               let newRegion = MKCoordinateRegion(center: newCenter, span: span)
               
               // 更新地圖視圖的顯示區域
               self.mapView.setRegion(newRegion, animated: false)
               
               // 判斷是否到達目標位置
               currentStep += 1
               if currentStep >= steps {
                   timer.invalidate()
               }
           }
      
       
    }
    
    
    
    func draw(){
        // 2. 建立自定義的annotation,自定義圖片1-7
        let annotation1 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30312, longitude: 114.17169),
                                           title: "Victoria Peak", subtitle: "The highest point on Hong Kong Island",
                                           imageName: "")
        
        let annotation2 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.29818, longitude: 114.17202),
                                           title: "Hong Kong Disneyland", subtitle: "A magical world of Disney characters and attractions",
                                           imageName: "")
        
        let annotation3 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.29809, longitude: 114.16976),
                                           title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                           imageName: "")
        
        let annotation4 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.29941, longitude: 114.16933),
                                           title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                           imageName: "")
        
       let annotation5 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30048, longitude: 114.16845),
                                           title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                           imageName: "")
        
        let annotation6 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30179, longitude: 114.16810),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "")
        
        let annotation7 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30289, longitude: 114.16816),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "")
        //計算中點，x,y
        let x  = findCenterCoordinate(for: [annotation1, annotation2, annotation3,annotation4,annotation5,annotation6,annotation7]).latitude
        let y = findCenterCoordinate(for: [annotation1, annotation2, annotation3,annotation4,annotation5,annotation6,annotation7]).longitude
        //上面1-7 圖標的中心點 -》 找到中點進行設置為了下面圍欄計算
        let annotation9 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude:x, longitude: y),
                                            title: "", subtitle: "",
                                            imageName: "选中 (2)")
        
       k2 = x
        k22 = y
        
      
        
       //九龍5世紀紀念公園
        let k1 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30580, longitude: 114.16703),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-9")
        
        let k2 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30469, longitude: 114.16771),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-5")
        let k3 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30371, longitude: 114.16795),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-5")
        let k4 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30381, longitude: 114.16818),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-5")
        
        let k5 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30490, longitude: 114.16800),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-5")
        let k6 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30487, longitude: 114.16911),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-5")
        let k7 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30539, longitude: 114.16919),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-5")
        
        
        //計算中點，x,y
        let x3  = findCenterCoordinate(for: [k1,k2,k3,k4,k5,k6,k7]).latitude
        let y3 = findCenterCoordinate(for: [k1,k2,k3,k4,k5,k6,k7]).longitude
        //上面1-7 圖標的中心點 -》 找到中點進行設置為了下面圍欄計算
        let center3 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude:x3, longitude: y3),
                                            title: "", subtitle: "",
                                            imageName: "未选中 (3)")
        k333 = x3
        k33 = y3

       

        // 2. 建立自定義的圍欄
       var a = drawLine(from: annotation1.coordinate, to: annotation9.coordinate, imageName: "")
        var b = drawLine(from: annotation2.coordinate, to: annotation9.coordinate, imageName: "")
        var c = drawLine(from: annotation3.coordinate, to: annotation9.coordinate, imageName: "")
        var d = drawLine(from: annotation4.coordinate, to: annotation9.coordinate, imageName: "")
        var e = drawLine(from: annotation5.coordinate, to: annotation9.coordinate, imageName: "")
        var f = drawLine(from: annotation6.coordinate, to: annotation9.coordinate, imageName: "")
        var g = drawLine(from: annotation7.coordinate, to: annotation9.coordinate, imageName: "")
        
        
        //2
        let three1 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.29592, longitude: 114.17566),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-5")
        let three2 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.29499, longitude: 114.17629),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-5")
        let three3 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.29870, longitude: 114.18026),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-5")
        let three4 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.29890, longitude: 114.17981),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "Theme=3D-5")
        
        //計算中點，x,y
        let x1  = findCenterCoordinate(for: [three1,three2,three3,three4]).latitude
        let y1 = findCenterCoordinate(for: [three1,three2,three3,three4]).longitude
        let center2 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude:x1, longitude: y1),
                                       title: "", subtitle: "",
                                       imageName: "未选中 (1)")
        k111 = x1
        k11 = y1
        
        
        // 3. 將annotation加到mapView上
     //   mapView.addAnnotations(
            //[a,b,c,d,e,f,g,k1,k2,k3,k4,k5,k6,k7,three1,three2,three3,three4])
       //     [annotation9,center3,center2])

        
        // 4. 繪製圍欄
        let fenceCoordinates = [annotation1.coordinate,annotation2.coordinate,annotation3.coordinate,annotation4.coordinate,annotation5.coordinate,annotation6.coordinate,annotation7.coordinate]
        let fence = polygon(for: fenceCoordinates)
        mapView.addOverlay(fence!)
        
        // 創建第二個圍欄
     /*   let fenceCoordinates2 = [CLLocationCoordinate2D(latitude: 22.3720, longitude: 113.9605),
                                 CLLocationCoordinate2D(latitude: 22.3720, longitude: 113.9615),
                                 CLLocationCoordinate2D(latitude: 22.3730, longitude: 113.9615),
                                 CLLocationCoordinate2D(latitude: 22.3730, longitude: 113.9605)]
        let fence2 = MKPolygon(coordinates: fenceCoordinates2, count: fenceCoordinates2.count)
        mapView.addOverlay(fence2)
        
       */
        
        
        let parks = [
            ["title": "Kowloon Park", "latitude": x, "longitude": y],
            ["title": "Waterfront Park", "latitude": x1, "longitude": y1],
            ["title": "West Kowloon Park", "latitude": x3, "longitude": y3]
            ]
            
        for park in parks {
            let annotation = MKPointAnnotation()
            annotation.title = park["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: park["latitude"] as! CLLocationDegrees, longitude: park["longitude"] as! CLLocationDegrees)
            mapView.addAnnotation(annotation)
        }
        
        let fenceCoordinates1 = [k1.coordinate,k2.coordinate,k3.coordinate,k4.coordinate,
                                 k5.coordinate,k6.coordinate,k7.coordinate
        ]
        let fence1 = polygon(for: fenceCoordinates1)
        mapView.addOverlay(fence1!)
        
        
        
        let fenceCoordinates2 = [three1.coordinate,three2.coordinate,three3.coordinate,three4.coordinate
        ]
        let fence2 = polygon(for: fenceCoordinates2)
        mapView.addOverlay(fence2!)
        
    
        
        
        //檢測用戶是否在此圍欄區域
        calculateInAreaRange(annotation1: annotation1, annotation2: annotation2, annotation3: annotation3, annotation4: annotation4, annotation5: annotation5, annotation6: annotation6, annotation7: annotation7)
    }
    
    
    
    
    
    
    
    
    // 7. 根據點的數量繪製多邊形和循環連線
   func polygon(for coordinates: [CLLocationCoordinate2D]) -> MKOverlay? {
       guard coordinates.count >= 2 else {
           return nil // 需要至少三個頂點
       }
       
       var polygon: MKOverlay
       
       let points = coordinates + [coordinates[0]] // 將第一個點添加到最後以形成閉合的形狀
       
       var polylinePoints = [CLLocationCoordinate2D]() // 用於創建 MKPolyline
       
       for i in 0..<points.count {
           polylinePoints.append(points[i])
           
           if i < points.count - 1 {
               // 將相鄰的兩個點添加到 MKPolyline 中
               let polyline = MKPolyline(coordinates: [points[i], points[i+1]], count: 2)
               mapView.addOverlay(polyline)
           }
       }
       
       switch coordinates.count {
       case let count where count >= 3 && count <= 10:
           polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
       default:
           polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
       }
       
       return polygon
   }
    
    func drawLine(from locationA: CLLocationCoordinate2D, to locationB: CLLocationCoordinate2D, imageName: String) -> CustomAnnotation {
        let centerCoordinate = findClosestLocation(from: locationA, to: locationB)
        
        let annotation = CustomAnnotation(coordinate: centerCoordinate, title: nil, subtitle: nil, imageName: imageName)
        
        return annotation
    }
    
    func findClosestLocation(from locationA: CLLocationCoordinate2D, to locationB: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let centerCoordinate = CLLocationCoordinate2D(latitude: (locationA.latitude + locationB.latitude)/2, longitude: (locationA.longitude + locationB.longitude)/2)
        let centerCoordinate1 = findFinalClosestLocation(from: locationA, to: centerCoordinate)
       
        return centerCoordinate1
    }
    
    func findFinalClosestLocation(from locationA: CLLocationCoordinate2D, to locationB: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
       
        let centerCoordinate = CLLocationCoordinate2D(latitude: (locationA.latitude + locationB.latitude)/2 , longitude: (locationA.longitude + locationB.longitude)/2 )
       
        return centerCoordinate
    }
    
    
    var annotationsRect = MKMapRect.null //區域位置範圍
    //計算區域範圍位置
    func calculateInAreaRange(annotation1:CustomAnnotation,
                              annotation2:CustomAnnotation,
                              annotation3:CustomAnnotation,
                              annotation4:CustomAnnotation,
                              annotation5:CustomAnnotation,
                              annotation6:CustomAnnotation,
                              annotation7:CustomAnnotation
    ){
        for annotation in [annotation1, annotation2, annotation3, annotation4, annotation5, annotation6, annotation7] {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            annotationsRect = annotationsRect.union(MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0))
        }

    }
 
    func findCenterCoordinate(for annotations: [CustomAnnotation]) -> CLLocationCoordinate2D {
        var x: Double = 0
        var y: Double = 0
        var z: Double = 0
        
        for annotation in annotations {
            let lat = annotation.coordinate.latitude * Double.pi / 180
            let lon = annotation.coordinate.longitude * Double.pi / 180
            
            x += cos(lat) * cos(lon)
            y += cos(lat) * sin(lon)
            z += sin(lat)
        }
        
        let count = Double(annotations.count)
        x /= count
        y /= count
        z /= count
        
        let lon = atan2(y, x)
        let hyp = sqrt(x * x + y * y)
        let lat = atan2(z, hyp)
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: lat * 180 / Double.pi, longitude: lon * 180 / Double.pi)
       
        return centerCoordinate
    }
  
    
    func hello(x:Double,y:Double){
        // 設置目標座標位置
           let targetCoordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
           
           // 創建一個地圖視圖的中心點位置
           let center = CLLocationCoordinate2D(latitude: targetCoordinate.latitude, longitude: targetCoordinate.longitude)
           
           // 創建一個地圖視圖的縮放級別
           let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
           
           // 創建一個地圖視圖的顯示區域
           let region = MKCoordinateRegion(center: center, span: span)
           
           // 計算移動地圖的步數
           let steps = 500
           let stepLat = (targetCoordinate.latitude - mapView.region.center.latitude) / Double(steps)
           let stepLon = (targetCoordinate.longitude - mapView.region.center.longitude) / Double(steps)
           
           // 開始滾動地圖
           var currentStep = 0
           Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
               guard let self = self else {
                   timer.invalidate()
                   return
               }
               
               // 計算新的中心座標
               let newCenter = CLLocationCoordinate2D(latitude: self.mapView.region.center.latitude + stepLat, longitude: self.mapView.region.center.longitude + stepLon)
               
               // 創建新的顯示區域
               let newRegion = MKCoordinateRegion(center: newCenter, span: span)
               
               // 更新地圖視圖的顯示區域
               self.mapView.setRegion(newRegion, animated: false)
               
               // 判斷是否到達目標位置
               currentStep += 1
               if currentStep >= steps {
                   timer.invalidate()
               }
           }
    }
    
    @objc func locationAnimationTap(_ gestureRecognizer: UITapGestureRecognizer) {
        print("Click animation destination tapped")
        print(gestureRecognizer.view?.tag)
        var a  = gestureRecognizer.view?.tag.description
        print("ff",String(a!))
    
        if(a == "0"){
            print("Now 111111")
           
        
      
            let latitude = 22.297127512853546
            let longitude = 114.17800497630509
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // 設置地圖縮放級別
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
        

        }else if(a == "1"){
            print("Now 22222")
            
            let latitude = 22.3005657212691
            let longitude = 114.16964429144443
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // 設置地圖縮放級別
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
        
            
           
        }else{
            print("Now 3333")
            
            let latitude = 22.304738572966176
            let longitude = 114.16816714307208
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // 設置地圖縮放級別
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            
        
        }
      
        
        
        
        
        
        
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let annotationView = gestureRecognizer.view as? CustomAnnotation else {
            return
        }

        let alertController = UIAlertController(title: "標記被點擊了", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
     
    func getDirections(to destination: MKMapItem) {
        //偵測顯示地圖地理位置
        let sourcePlacemark = MKPlacemark(coordinate: currentCoordinate)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = sourceMapItem
        directionsRequest.destination = destination
        directionsRequest.transportType = .automobile
        // Set the locale to Chinese
     

        
        let directions = MKDirections(request: directionsRequest)
        directions.calculate { [self] (response, _) in
            guard let response = response else { return }
            guard let primaryRoute = response.routes.first else { return }
            
            self.mapView.addOverlay(primaryRoute.polyline)
            
        self.locationManager.monitoredRegions.forEach({ self.locationManager.stopMonitoring(for: $0) })
            
            self.steps = primaryRoute.steps
            for i in 0 ..< primaryRoute.steps.count {
                let step = primaryRoute.steps[i]
                print(step.instructions)
                print(step.distance)
                let region = CLCircularRegion(center: step.polyline.coordinate,
                                              radius: 20,
                                              identifier: "\(i)")
                self.locationManager.startMonitoring(for: region)
                let circle = MKCircle(center: region.center, radius: region.radius)
                self.mapView.addOverlay(circle)
                
            }
            
         
            //顯示目前導航位置
            let initialMessage = " 在\(self.steps[0].distance) 米, \(self.steps[0].instructions) 然後在 \(self.steps[1].distance) 米, \(self.steps[1].instructions)."
            self.directionsLabel.text = initialMessage
            self.stepCounter += 1
        }
    }
    
    
   
    
    @objc func startNavigationTracking() {
       
        //用戶輸入好位置後反應。
        let localSearchRequest = MKLocalSearch.Request()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        let region = MKCoordinateRegion(center: currentCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        localSearchRequest.region = region
        let localSearch = MKLocalSearch(request: localSearchRequest)
        
       
        localSearch.start { (response, _) in
            guard let response = response else { return }
            guard let firstMapItem = response.mapItems.first else { return }
            self.getDirections(to: firstMapItem)
        }
        
       }
    
    @objc func startAreaTracking() {
        //檢測用戶是否在圍欄區域
        let currentLocation = CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.latitude)
        let currentLocationPoint = MKMapPoint(currentLocation.coordinate)
        let isInside = annotationsRect.contains(currentLocationPoint)

        if isInside {
            //觸發能量集滿event!!!!!
            print("目前位置在annotation的範圍內")
            
        } else {
            //不在這個區域位置，請忽略！！！！
            print("目前位置不在annotation的範圍內")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //取消所有timer設置
        timer?.invalidate()
        timer = nil
        areaTimer?.invalidate()
        areaTimer?.invalidate()
    }
    
    

}

extension NavigationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let currentLocation = locations.first else { return }
        guard let location = locations.last else { return }
        currentCoordinate = currentLocation.coordinate
        let currentLatitude = location.coordinate.latitude
        let currentLongitude = location.coordinate.longitude
        h1 = currentLatitude
        h2 = currentLongitude
        print("current location is ",currentLocation)
        mapView.userTrackingMode = .followWithHeading
        
   //     let currentLocation = CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.latitude)
      /**
       let currentLocationPoint = MKMapPoint(currentLocation.coordinate)
       let isInside = annotationsRect.contains(currentLocationPoint)

       if isInside {
           print("目前位置在annotation的範圍內")
       } else {
           print("目前位置不在annotation的範圍內")
       }
       */
        
    }
    
    func getdistance(x:Double,y:Double)-> Double{
        let sourceLocation = CLLocation(latitude: h1, longitude: h2) // 起始位置的经纬度
        let destinationLocation = CLLocation(latitude: x, longitude: y) // 目标位置的经纬度
        d1 = x
        d2 = y

        let distanceInMeters = sourceLocation.distance(from: destinationLocation) // 计算两个位置之间的距离（以米为单位）

        let distanceInKilometers = round(distanceInMeters / 1000) // 将距离转换为千米

        print("距离为 \(distanceInKilometers) 公里")
        
        
        return distanceInKilometers
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        stepCounter += 1
        if stepCounter < steps.count {
            let currentStep = steps[stepCounter]
            let message = "在 \(currentStep.distance) 米, \(currentStep.instructions)"
            directionsLabel.text = message

         
         
        } else {
            let message = "到達目的地"
            directionsLabel.text = message
            stepCounter = 0
            locationManager.monitoredRegions.forEach({ self.locationManager.stopMonitoring(for: $0) })
            
        }
       
    }
    
    
    
   
}

extension NavigationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        print("開始導航......")
        
        // Start the timer 用戶確認，開始導航timer
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(startNavigationTracking), userInfo: nil, repeats: true)
            timer?.fire()
        
        
        // Start the timer 檢測用戶是否在圍欄區域timer
        areaTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(startAreaTracking), userInfo: nil, repeats: true)
        areaTimer?.fire()
        

        
        
    }
    
    @objc func handleTap(annotation:MKAnnotation) {

        // Handle the tap gesture here
        print("Hello1",annotation.coordinate.latitude)
        print("Hello2",annotation.coordinate.longitude)
        var x = annotation.coordinate.latitude
        var y = annotation.coordinate.longitude

        if(x == 22.304738572966176 && y == 114.16816714307208){
            print("right")
         //   NavigationViewController.hello(key: "right")
            print("iiiiii1")
            getdistance(x: x, y: y)
        }else if(x == 22.3005657212691 && y == 114.16964429144443){
            print("center")
            print("iiiiii2")
            print("iiiiii2",annotation.coordinate.latitude)
            getdistance(x: x, y: y)
          //  NavigationViewController.hello(key: "center")
        }else if(x == 22.297127512853546 && y == 114.17800497630509){
            print("left")
            print("iiiiii3")
            getdistance(x: x, y: y)
          //  NavigationViewController.hello(key: "left")
        }
        
        
        
    }
 
    
 
}

extension NavigationViewController: MKMapViewDelegate {
    //地圖上風格
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemGreen
            renderer.fillColor = .systemGreen
            renderer.lineWidth = 5
            renderer.alpha = 1
            return renderer
        }
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.strokeColor = .red
            renderer.fillColor = .red
            renderer.alpha = 0.2
            return renderer
        }
        
        if let polygonOverlay = overlay as? MKPolygon {
            let polygonRenderer = MKPolygonRenderer(polygon: polygonOverlay)
            //164 236 47
            polygonRenderer.strokeColor = UIColor(red: 164/255, green: 236/255, blue: 47/255, alpha: 1.0) // 設定邊框為藍色
            polygonRenderer.lineWidth = 1.0
            polygonRenderer.fillColor = UIColor(red: 164/255, green: 236/255, blue: 47/255, alpha: 0.5) // 設定填充為半透明的紅色
            return polygonRenderer
        }
        return MKOverlayRenderer()
    }
    
    // 6. 自定義annotationView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      //  locationManager.startUpdatingLocation()
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "FindParksPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            // 設置圖示的交互性
            annotationView?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
            annotationView?.addGestureRecognizer(tapGesture)
        } else {
            annotationView?.annotation = annotation
        }
        var x = annotationView?.annotation!.coordinate.latitude
        var y = annotationView?.annotation!.coordinate.longitude
       
        if(x == 22.3005657212691 && y == 114.16964429144443){
            print("center111")
            annotationView?.image = UIImage(named: "选中 (2)")?.resizeImage(targetSize: CGSize(width: 120, height: 150))
            d1 = k2
            d2 = k22
        } else if(x == 22.297127512853546 && y == 114.17800497630509){
            print("right111")
            annotationView?.image = UIImage(named: "未选中 (3)")?.resizeImage(targetSize: CGSize(width: 80, height: 80))
            d1 = k333
            d2 = k33
        }
        
        else{
            annotationView?.image = UIImage(named: "未选中 (1)")?.resizeImage(targetSize: CGSize(width: 50, height: 80))
            d1 = k111
            d2 = k11
        }
        
        
        return annotationView
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        
        
        guard let annotationView = sender.view as? MKAnnotationView,
              let title = annotationView.annotation?.title,
              let coordinate = annotationView.annotation?.coordinate else { return }
        
        
        if title == "Kowloon Park" {
            print("點擊了標註：\(title!)，位置：\(coordinate.latitude), \(coordinate.longitude)")
           
            // 設置地圖中心點和縮放級別
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            // 使地圖滑動或縮放到目的地，並添加動畫效果
            mapView.setRegion(region, animated: true)
            
            // 移除地圖上的所有現有圓形圍欄
            for overlay in mapView.overlays {
                if overlay is MKCircle {
                    mapView.removeOverlay(overlay)
                }
            }
            
            for overlay1 in mapView.overlays {
                if overlay1 is MKPolyline {
                    mapView.removeOverlay(overlay1)
                }
                
                
                
            }
            drawInfoView(imageName: "Kowloon Park")
            
        }else{
            print("other")
            
            print("點擊了標註：\(title!)，位置：\(coordinate.latitude), \(coordinate.longitude)")
           
            // 設置地圖中心點和縮放級別
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            // 使地圖滑動或縮放到目的地，並添加動畫效果
            mapView.setRegion(region, animated: true)
            
            // 移除地圖上的所有現有圓形圍欄
            for overlay in mapView.overlays {
                if overlay is MKCircle {
                    mapView.removeOverlay(overlay)
                }
            }
            
            for overlay1 in mapView.overlays {
                if overlay1 is MKPolyline {
                    mapView.removeOverlay(overlay1)
                }
                
                
                
            }
            drawInfoView(imageName: "Kowloon Park")
            
        }
     
        
        
    }

    func drawInfoView(imageName: String) {
        locationManager.startUpdatingLocation()
        myview.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        // Create the blur effect
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        
        // Create the visual effect view with the blur effect
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = myview.bounds
        
        // Add the visual effect view to myview
        myview.addSubview(visualEffectView)
        
        // set up the rest of the UI elements
        myimage.frame = CGRect(x: (view.frame.size.width - 50) / 2, y: self.view.frame.height * 0.1, width: 50, height: 80)
        
        if imageName == "Kowloon Park" {
            myimage.image = UIImage(named: "park2")
            currentNavigationPark = "Kowloon Park"
        }
        
        else if imageName == "West Kowloon Park" {
            currentNavigationPark = "West Kowloon Park"
            myimage.image = UIImage(named: "park1")
        } else {
            currentNavigationPark = "Waterfront Park"
            myimage.image = UIImage(named: "park3")
        }
        
        mytextview.frame = CGRect(x: 20, y: self.view.frame.height * 0.2, width: self.view.frame.size.width - 40, height: 450)
        mytextview.isEditable = false
        mytextview.font = UIFont.systemFont(ofSize: 18)
        mytextview.backgroundColor = .clear
        mytextview.text = "Kowloon Park: Nestled in the bustling district of Tsim Sha Tsui, Kowloon Park is a haven of tranquility amid the urban chaos. Spanning over 33 acres, the park blends nature and culture seamlessly, boasting beautifully landscaped gardens, meandering pathways, and a large artificial lake. Visitors can explore its aviary, which houses a wide variety of exotic birds, or relax in the Chinese Garden, complete with traditional pavilions and a lotus pond. Kowloon Park is a popular destination for families, nature enthusiasts, and those seeking a peaceful escape."
        mytextview.textAlignment = .justified
      
        mybutton.frame = CGRect(x: 20, y: self.view.frame.height - 100, width: self.view.frame.size.width - 40, height: 60)
        mybutton.layer.cornerRadius = 18
        mybutton.backgroundColor = UIColor(red: 164/255, green: 236/255, blue: 47/255, alpha: 1.0)
        mybutton.setTitle("Start Walkation", for: .normal)
        mybutton.setTitleColor(.white, for: .normal)
        
        // Create the gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap1))
        
        // Add the gesture recognizer to the button
        mybutton.addGestureRecognizer(tapGesture)
        
        // add the subviews to the view hierarchy
        self.view.addSubview(myview)
        self.view.addSubview(myimage)
        self.view.addSubview(mytextview)
        self.view.addSubview(mybutton)
    
       
    }
   
    // Handle the tap gesture
    @objc func handleTap1(sender: UITapGestureRecognizer) {
        // Do something when the button is tapped
        print("開始路線規劃")
        //清楚這個
        myimage.removeFromSuperview()
        myview.removeFromSuperview()
        mybutton.removeFromSuperview()
        mytextview.removeFromSuperview()
              
        //清楚遊戲
        scrollView.removeFromSuperview()
        stackView.removeFromSuperview()
     
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)

        // Remove all overlays from the map view
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
        
        if(currentNavigationPark == "Kowloon Park"){
            print("center111 kowloon Park")
            drawKowloonPark()
            showPathlocation()
            showDistanceView()
        }else if(currentNavigationPark == "Waterfront Park"){
            
            
        }else{
            //West Kowloon Park
            
        }
    
        
    }
    
    func showDistanceView(){
        let myview = UIView()
        myview.backgroundColor = UIColor(red: 164/255, green: 236/255, blue: 47/255, alpha: 1.0)
        myview.frame = CGRect(x: 0, y: 100, width: 200, height: 50)
        myview.layer.cornerRadius = 30
        myview.center.x = view.center.x
        self.view.addSubview(myview)
        
    
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        label.text = "Distance \(getdistance(x:d1,y:d2)) KM"
        label.textColor = .white
        label.textAlignment = .center
        label.center = CGPoint(x: myview.bounds.width/2, y: myview.bounds.height/2)
        myview.addSubview(label)
      
     
   
        // Create the stack view
        let stackView = UIStackView(frame: CGRect(x: 0, y: view.bounds.height - 100, width: view.bounds.width, height: 50))
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually

        let margin:CGFloat = 50
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        stackView.isLayoutMarginsRelativeArrangement = true

       

        // Create the left button
       let leftButton = UIButton(type: .system)
        leftButton.setTitle("Open Game", for: .normal)
        leftButton.setTitleColor(UIColor.white, for: .normal) // 設置文字顏色
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        leftButton.addTarget(self, action: #selector(handleTap2), for: .touchUpInside)
        leftButton.backgroundColor = UIColor(red: 164/255, green: 236/255, blue: 47/255, alpha: 1.0)
        leftButton.layer.cornerRadius = 20 // 圓角半徑

        
        // Create the right button
        let rightButton = UIButton(type: .system)
        rightButton.setTitle("Open Breathe", for: .normal)
        rightButton.setTitleColor(UIColor.white, for: .normal) // 設置文字顏色
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        rightButton.addTarget(self, action: #selector(handleTap3), for: .touchUpInside)
        rightButton.backgroundColor = UIColor(red: 164/255, green: 236/255, blue: 47/255, alpha: 1.0)
        rightButton.layer.cornerRadius = 20 // 圓角半徑

        // Add the buttons to the stack view
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(rightButton)
 
      
        // Add the stack view to the view
        view.addSubview(stackView)
        view.bringSubviewToFront(stackView)
     
            
        
        //集滿能量形狀
        let energyview = UIView()
        energyview.frame = CGRect(x: 90, y: self.view.frame.size.height - 180, width: 150, height: 300)
    //    energyview.layer.cornerRadius = 30
        energyview.backgroundColor = .clear
        energyview.isUserInteractionEnabled = false
        self.view.addSubview(energyview)
        energyview.alpha = 1
  
        
        // Create an instance of EnergyCollection SwiftUI View.
        let energyCollection = EnergyCollection(selection: .constant(1)).frame(width: 150,height: 300)
              // Create an instance of UIHostingController and set the SwiftUI View as its root view.
              let hostingController = UIHostingController(rootView: energyCollection)
 
              // Add the UIHostingController's view as a subview of the ViewController's view.
              addChild(hostingController)
        energyview.addSubview(hostingController.view)
      
      //  hostingController.view.translatesAutoresizingMaskIntoConstraints = false
      /*
        NSLayoutConstraint.activate([
                  hostingController.view.leadingAnchor.constraint(equalTo: energyview.leadingAnchor),
                  hostingController.view.trailingAnchor.constraint(equalTo: energyview.trailingAnchor),
                  hostingController.view.topAnchor.constraint(equalTo: energyview.topAnchor),
                  hostingController.view.bottomAnchor.constraint(equalTo: energyview.bottomAnchor)
              ])
              hostingController.didMove(toParent: self)
        
        */
        
        
    }
      


    @objc func handleTap2(sender: UITapGestureRecognizer) {
        print("Go to Game View")
        
        let selectionBinding = Binding<Int?>(
            get: { 3 },
            set: { _ in }
        )
        
        let gameView = Game(selection: selectionBinding)
        let hostingController = UIHostingController(rootView: gameView)
        
        // 包裝SwiftUI視圖
        let navController = UINavigationController(rootViewController: hostingController)
        navController.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        
        // 設置返回按鈕
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        hostingController.navigationItem.leftBarButtonItem = backButton
        
        // 设置视图控制器为全屏
        navController.modalPresentationStyle = .fullScreen

        present(navController, animated: true, completion: nil)
    }

    // 返回方法
    @objc func handleBack() {
        dismiss(animated: true, completion: nil)
    }
   

    @objc func handleTap3(sender: UITapGestureRecognizer) {
        print("Go to Breathe View")
        print("Go to Breathe View")
  
        let selectionBinding = Binding<Int?>(
            get: { 3 },
            set: { _ in }
        )

        let breatheView = Breathe(selection: selectionBinding)
        let hostingController = UIHostingController(rootView: breatheView)

        // 包裝SwiftUI視圖
        let navController = UINavigationController(rootViewController: hostingController)
        navController.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never

        // 設置返回按鈕
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        hostingController.navigationItem.leftBarButtonItem = backButton

        // 设置视图控制器为全屏
        navController.modalPresentationStyle = .fullScreen

        present(navController, animated: true, completion: nil)
   
        
        
        
    }
    
    
 
    //164 236 47
    func showPathlocation(){
        print("center111",h1)
        print("center111",h2)
        print("center111",d1)
        print("center111",d2)
        let sourceLocation = CLLocationCoordinate2D(latitude: h1, longitude: h2)
        let destinationLocation = CLLocationCoordinate2D(latitude: d1, longitude: d2)

        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)

        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile

        let directions = MKDirections(request: directionRequest)
        directions.calculate { response, error in
            guard let route = response?.routes.first else {
                // handle error
                return
            }
            // add the route to the map
            self.mapView.addOverlay(route.polyline)
        }
    }
    
    
    func drawKowloonPark(){
       
        // 2. 建立自定義的annotation,自定義圖片1-7
        let annotation1 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30312, longitude: 114.17169),
                                           title: "Victoria Peak", subtitle: "The highest point on Hong Kong Island",
                                           imageName: "")
        
        let annotation2 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.29818, longitude: 114.17202),
                                           title: "Hong Kong Disneyland", subtitle: "A magical world of Disney characters and attractions",
                                           imageName: "")
        
        let annotation3 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.29809, longitude: 114.16976),
                                           title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                           imageName: "")
        
        let annotation4 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.29941, longitude: 114.16933),
                                           title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                           imageName: "")
        
       let annotation5 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30048, longitude: 114.16845),
                                           title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                           imageName: "")
        
        let annotation6 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30179, longitude: 114.16810),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "")
        
        let annotation7 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 22.30289, longitude: 114.16816),
                                            title: "Lamma Island", subtitle: "A peaceful island with scenic hiking trails and seafood restaurants",
                                            imageName: "")
        //計算中點，x,y
   
        let x  = findCenterCoordinate(for: [annotation1, annotation2, annotation3,annotation4,annotation5,annotation6,annotation7]).latitude
        let y = findCenterCoordinate(for: [annotation1, annotation2, annotation3,annotation4,annotation5,annotation6,annotation7]).longitude
        //上面1-7 圖標的中心點 -》 找到中點進行設置為了下面圍欄計算
        let annotation9 = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude:x, longitude: y),
                                            title: "", subtitle: "",
                                            imageName: "选中 (2)")
        
        let parks = [
            ["title": "Kowloon Park", "latitude": x, "longitude": y]
            ]
        
        
    for park in parks {
        let annotation = MKPointAnnotation()
        annotation.title = park["title"] as? String
        annotation.coordinate = CLLocationCoordinate2D(latitude: park["latitude"] as! CLLocationDegrees, longitude: park["longitude"] as! CLLocationDegrees)
        mapView.addAnnotation(annotation)
    }
           
        // 4. 繪製圍欄
        let fenceCoordinates = [annotation1.coordinate,annotation2.coordinate,annotation3.coordinate,annotation4.coordinate,annotation5.coordinate,annotation6.coordinate,annotation7.coordinate]
        let fence = polygon(for: fenceCoordinates)
        mapView.addOverlay(fence!)
        
        
    }
    
    func drawWaterfrontPark(){
       // dra
    }
    
    
    
    
    func disapearInfoView(){
        
    }
    
}

  
   
    



class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var imageName: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, imageName: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
    }
}


class CustomAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            guard let customAnnotation = annotation as? CustomAnnotation else { return }
            image = UIImage(named: customAnnotation.imageName ?? "")
            var x = annotation!.coordinate.latitude
            var y = annotation!.coordinate.longitude
            if(x == 22.3005657212691 && y == 114.16964429144443){
                print("center")
                frame.size = CGSize(width: 120, height: 160)
            }else{
                frame.size = CGSize(width: 50, height: 80)
            }
           
        
     
        }
    }
   
    
}
extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // 計算縮放比例
        let scale = min(widthRatio, heightRatio)
        
        // 計算新的圖像大小
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        // 建立繪圖上下文
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { (context) in
            // 繪製圖像
            self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        }
        
        return image
    }
}
