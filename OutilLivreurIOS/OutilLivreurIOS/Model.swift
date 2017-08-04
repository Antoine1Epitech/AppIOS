//
//  File.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 05/07/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation
import CoreLocation

let _modelDelivery = ModelDelivery()
var DAMAGED = "DAMAGED"
var CHECKED = "CHECKED"
var FALSE = "FALSE"
var EMPTY = "EMPTY"
var _nameDeliver = "Jacque"

struct s_state {
    var nbFalse = 0
    var nbDamaged = 0
    var nbChecked = 0
    var nbEmpty = 0
}

struct s_garage: Equatable {
    var _nameOfGarage = String()
    var _zipCode = Int()
    var _adress = String()
    var _city = String()
    var _phoneNumberGarage = String()
    var _lastNameOwner = String()
    var _firstNameOwner = String()
    var _phoneNumberOwner = String()
    var _id = Int()
    var _numOrder = Int()
    var _lat = Float()
    var _lon = Float()
    var _status = Bool()
    
    init() {
        
    }
    
    init(nameOfGarage : String, zipCode : Int, adress : String, city : String, phoneNumberGarage : String, lastNameOwner : String, firstNameOwner : String, phoneNumberOwner : String, id :Int, order : Int) {
        self._nameOfGarage = nameOfGarage
        self._zipCode = zipCode
        self._adress = adress
        self._city = city
        self._phoneNumberGarage = phoneNumberGarage
        self._lastNameOwner = lastNameOwner
        self._firstNameOwner = firstNameOwner
        self._phoneNumberOwner = phoneNumberOwner
        self._id = id
        self._numOrder = order
                self._status = false
    }
    
    static func == (lhs: s_garage, rhs: s_garage) -> Bool {
        return lhs._nameOfGarage == rhs._nameOfGarage
    }
}

struct s_product{
    var _name = String()
    var _reference = String()
    var _checked = String()
    var _idGarage = Int()
    var _box = Int()
    
    init(name : String, reference : String, checked : String, id : Int) {
        self._name = name
        self._reference = reference
        self._checked = checked
        self._idGarage = id
        self._box = -1
    }
}

struct s_package{
    var _name = String()
    var _reference = String()
    var _checked = String()
    var _idGarage = Int()
    var _garage = s_garage()
    var _listProduct = [s_product]()
    var _deliver = String()
    var _box = -1
    var _delivered = Bool()
    init() {
        
    }
    
    init(name : String, reference : String, checked : String, id : Int, _garage : s_garage, listProduct : [s_product], deliver: String) {
        self._name = name
        self._reference = reference
        self._checked = checked
        self._idGarage = id
        self._garage = _garage
        self._listProduct = listProduct
        self._deliver = deliver
        self._delivered = false
    }
}

struct s_delivery {
    
    var _status = String()
    var _ref = String()
    var _date = String()
    var _listPackage = [s_package]()
    
    init() {
    
    }
    
    init(ref: String, status: String, listPackage : [s_package], date : String ) {
        _status = status
        _ref = ref
        _date = date
        _listPackage = listPackage
    }
    
}


class ModelDelivery {
    
    var _listDelivery = [s_delivery]()
    

    init() {
        var _listPackage = [s_package]()
        var list = [s_product]()
        list.append(s_product(name: "Article1", reference: "123456789", checked: EMPTY, id : 0))
        list.append(s_product(name: "Article2", reference: "223456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article3", reference: "323456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article4", reference: "423456789", checked: EMPTY, id : 2))
        _listPackage.append(s_package(name: "Lot 1", reference: "123456789", checked: EMPTY, id : 0, _garage: s_garage(nameOfGarage: "AUTO YOUNA PNEUS", zipCode: 75011, adress: "126 Rue Saint-Maur", city: "Paris", phoneNumberGarage: "01 43 57 58 60", lastNameOwner: "Jean", firstNameOwner: "Dupond", phoneNumberOwner: "06 45 56 78 89", id: 0, order: 0), listProduct : list, deliver : "Jean"))
        list = [s_product]()
        list.append(s_product(name: "Article1", reference: "123456789", checked: EMPTY, id : 0))
        list.append(s_product(name: "Article2", reference: "223456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article3", reference: "323456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article4", reference: "423456789", checked: EMPTY, id : 2))
        _listPackage.append(s_package(name: "Lot 2", reference: "223456789", checked: EMPTY, id : 1,_garage:s_garage(nameOfGarage: "GARAGE MONT LOUIS", zipCode: 75011, adress:  "17 Rue de Mont-Louis", city: "Paris", phoneNumberGarage: "01 43 79 08 08", lastNameOwner: "Jean-pierre", firstNameOwner: "Dupond", phoneNumberOwner: "06 78 89 45 56", id: 1, order: 1), listProduct : list, deliver : "Jacque"))
        list = [s_product]()
        list.append(s_product(name: "Article1", reference: "123456789", checked: EMPTY, id : 0))
        list.append(s_product(name: "Article2", reference: "223456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article3", reference: "323456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article4", reference: "423456789", checked: EMPTY, id : 2))
        _listPackage.append(s_package(name: "Lot 3", reference: "323456789", checked: EMPTY, id : 1,_garage:s_garage(nameOfGarage: "GARAGE MONT LOUIS", zipCode: 75011, adress:  "17 Rue de Mont-Louis", city: "Paris", phoneNumberGarage: "01 43 79 08 08", lastNameOwner: "Jean-pierre", firstNameOwner: "Dupond", phoneNumberOwner: "06 78 89 45 56", id: 1, order: 1), listProduct : list, deliver : "Jacque"))
        list = [s_product]()
        list.append(s_product(name: "Article1", reference: "123456789", checked: EMPTY, id : 0))
        list.append(s_product(name: "Article2", reference: "223456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article3", reference: "323456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article4", reference: "423456789", checked: EMPTY, id : 2))
        _listPackage.append(s_package(name: "Lot 4", reference: "423456789", checked: EMPTY, id : 2,_garage:s_garage(nameOfGarage: "GARAGE ST-ANTOINE", zipCode: 75011, adress: "295, Rue du Faubourg Saint-Antoine", city: "Paris", phoneNumberGarage: "01 43 73 51 78", lastNameOwner: "Jean-Michel", firstNameOwner: "Dupond", phoneNumberOwner: "06 12 23 45 65", id: 2, order: 2), listProduct : list, deliver : "Consigne"))
        
        
        var _listPackage2 = [s_package]()
        list = [s_product]()
        list.append(s_product(name: "Article1", reference: "123456789", checked: CHECKED, id : 0))
        list.append(s_product(name: "Article2", reference: "223456789", checked: CHECKED, id : 1))
        list.append(s_product(name: "Article3", reference: "323456789", checked: CHECKED, id : 1))
        list.append(s_product(name: "Article4", reference: "423456789", checked: CHECKED, id : 2))
        _listPackage2.append(s_package(name: "Lot 1", reference: "123456789", checked: CHECKED, id : 0, _garage: s_garage(nameOfGarage: "AUTO YOUNA PNEUS", zipCode: 75011, adress: "126 Rue Saint-Maur", city: "Paris", phoneNumberGarage: "01 43 57 58 60", lastNameOwner: "Jean", firstNameOwner: "Dupond", phoneNumberOwner: "06 45 56 78 89", id: 0, order: 0), listProduct : list, deliver : "Jean"))
        list = [s_product]()
        list.append(s_product(name: "Article1", reference: "123456789", checked: CHECKED, id : 0))
        list.append(s_product(name: "Article2", reference: "223456789", checked: CHECKED, id : 1))
        list.append(s_product(name: "Article3", reference: "323456789", checked: CHECKED, id : 1))
        list.append(s_product(name: "Article4", reference: "423456789", checked: CHECKED, id : 2))
        _listPackage2.append(s_package(name: "Lot 2", reference: "223456789", checked: CHECKED, id : 1,_garage:s_garage(nameOfGarage: "GARAGE MONT LOUIS", zipCode: 75011, adress:  "17 Rue de Mont-Louis", city: "Paris", phoneNumberGarage: "01 43 79 08 08", lastNameOwner: "Jean-pierre", firstNameOwner: "Dupond", phoneNumberOwner: "06 78 89 45 56", id: 1, order: 1), listProduct : list, deliver : "Jacque"))
        list = [s_product]()
        list.append(s_product(name: "Article1", reference: "123456789", checked: EMPTY, id : 0))
        list.append(s_product(name: "Article2", reference: "223456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article3", reference: "323456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article4", reference: "423456789", checked: EMPTY, id : 2))
        _listPackage2.append(s_package(name: "Lot 3", reference: "323456789", checked: CHECKED, id : 1,_garage:s_garage(nameOfGarage: "GARAGE MONT LOUIS", zipCode: 75011, adress:  "17 Rue de Mont-Louis", city: "Paris", phoneNumberGarage: "01 43 79 08 08", lastNameOwner: "Jean-pierre", firstNameOwner: "Dupond", phoneNumberOwner: "06 78 89 45 56", id: 1, order: 1), listProduct : list, deliver : "Jacque"))
        list = [s_product]()
        list.append(s_product(name: "Article1", reference: "123456789", checked: EMPTY, id : 0))
        list.append(s_product(name: "Article2", reference: "223456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article3", reference: "323456789", checked: EMPTY, id : 1))
        list.append(s_product(name: "Article4", reference: "423456789", checked: EMPTY, id : 2))
        _listPackage2.append(s_package(name: "Lot 4", reference: "423456789", checked: CHECKED, id : 2,_garage:s_garage(nameOfGarage: "GARAGE ST-ANTOINE", zipCode: 75011, adress: "295, Rue du Faubourg Saint-Antoine", city: "Paris", phoneNumberGarage: "01 43 73 51 78", lastNameOwner: "Jean-Michel", firstNameOwner: "Dupond", phoneNumberOwner: "06 12 23 45 65", id: 2, order: 2), listProduct : list, deliver : "Consigne"))
        self._listDelivery.append(s_delivery(ref: "45879565", status: "ARRIVE AU CENTRE", listPackage: _listPackage, date: "17/09/2017 - 7 h 00"))
        self._listDelivery.append(s_delivery(ref: "42679565", status: "EN COURS D'ACHEMINEMENT", listPackage: _listPackage, date: ""))
        self._listDelivery.append(s_delivery(ref: "45859525", status: "TERMINE", listPackage: _listPackage2, date: "02/08/2017 - 6 h 30"))
        
    }
    
    func setBoxAllArticle(refDelivery: String, refPackage:String, nbBox: Int) {
        for var i in (0..<_listDelivery.count) {
            if (_listDelivery[i]._ref == refDelivery) {
                for var x in (0..<_listDelivery[i]._listPackage.count) {
                    if _listDelivery[i]._listPackage[x]._reference == refPackage {
                            _listDelivery[i]._listPackage[x]._box = nbBox
                    }
                }
            }
        }
    }
    func setBoxArticle(refDelivery: String, refPackage:String, refProduct: String, nbBox: Int) {
        for var i in (0..<_listDelivery.count) {
            if (_listDelivery[i]._ref == refDelivery) {
                for var x in (0..<_listDelivery[i]._listPackage.count) {
                    if _listDelivery[i]._listPackage[x]._reference == refPackage {
                        for var y in (0..<_listDelivery[i]._listPackage[x]._listProduct.count) {
                            if (_listDelivery[i]._listPackage[x]._listProduct[y]._reference == refProduct) {
                                _listDelivery[i]._listPackage[x]._listProduct[y]._box = nbBox
                            }
                        }
                    }
                }
            }
        }
    }

    
    
    func getStatePackage(refDelivery: String) -> s_state {
        var tmp = s_state()
        for elem in _listDelivery {
            if (elem._ref == refDelivery) {
                for elem2 in elem._listPackage {
                    if (elem2._checked == DAMAGED){
                        tmp.nbDamaged += 1
                    }
                    else if (elem2._checked == CHECKED){
                        tmp.nbChecked += 1
                    }
                    else if (elem2._checked == EMPTY){
                        tmp.nbEmpty += 1
                    }
                    else if (elem2._checked == FALSE){
                        tmp.nbFalse += 1
                    }
                }
            }
        }
        return tmp
    }
    
    func getGarageFromDeliver(refDelivery: String) -> [s_garage] {
        var tmp = [s_garage]()
        for elem in _listDelivery {
            if (elem._ref == refDelivery) {
                for elem2 in elem._listPackage {
                    if (elem2._deliver == _nameDeliver) {
                        if (tmp.contains(elem2._garage) != true) {
                        tmp.append(elem2._garage)
                        }
                    }
                }
            }
        }
        return tmp
    }
    
    func getNbPackageForGarage(refDelivery: String, nameGarage: String) -> [s_package] {
        var tmp = [s_package]()
        for elem in _listDelivery {
            if (elem._ref == refDelivery) {
                for elem2 in elem._listPackage {
                    if (elem2._garage._nameOfGarage == nameGarage) {
                    tmp.append(elem2)
                        }
                    }
                }
        }
        return tmp
    }
    
    
    func getPackageFromDeliver(refDelivery: String) -> [s_package]
    {
        var tmp = [s_package]()
        for elem in _listDelivery {
            if (elem._ref == refDelivery) {
                for elem2 in elem._listPackage {
                    if (elem2._deliver == _nameDeliver) {
                        tmp.append(elem2)
                    }
                }
            }
        }
        return tmp

    }
    
    func getPackageConsigne(refDelivery: String) -> [s_package]
    {
        var tmp = [s_package]()
        for elem in _listDelivery {
            if (elem._ref == refDelivery) {
                for elem2 in elem._listPackage {
                    if (elem2._deliver == "Consigne") {
                    tmp.append(elem2)
                    }
                }
            }
        }
        return tmp
    }
    func addPackage(refDelivery: String, ref: String) {
        var tmp = [s_delivery]()
        var tmp2 = [s_package]()
        var list = [s_product]()

        for i in (0..<_listDelivery.count) {
            if (_listDelivery[i]._ref == refDelivery) {
                tmp2 = _listDelivery[i]._listPackage
                tmp2.append(s_package(name: "Lot 4", reference: ref, checked: FALSE, id : 1 ,_garage:s_garage(nameOfGarage: "", zipCode: 0, adress: "", city: "", phoneNumberGarage: "", lastNameOwner: "", firstNameOwner: "", phoneNumberOwner: "", id: 2, order: 2), listProduct : list , deliver : ""))
                
            }
            _listDelivery[i]._listPackage = tmp2
        }
    }
    
    func getPackageFromDelivery(ref: String) -> [s_package] {
        var tmp = [s_package]()
        for elem in _listDelivery {
            if (elem._ref == ref) {
            tmp = elem._listPackage
            }
        }
        return tmp
    }
    
    
    func setDeliver(refDelivery:String, refPackage: String, deliver: String) {
        for var i in (0..<_listDelivery.count) {
            if (_listDelivery[i]._ref == refDelivery) {
                for var x in (0..<_listDelivery[i]._listPackage.count) {
                    if _listDelivery[i]._listPackage[x]._reference == refPackage {
                        _listDelivery[i]._listPackage[x]._deliver = deliver
                    }
                }
            }
            
        }
    }
    
    func getProductFromRef(refDelivery:String, refPackage:String) -> [s_product] {
        var tmp =  [s_product]()
        for elem in _listDelivery {
            if (elem._ref == refDelivery) {
                for elem2 in elem._listPackage {
                    if(elem2._reference == refPackage){
                        tmp = elem2._listProduct
                    }
                }
                
            }
        }
        return tmp
    }
    
    func setPackageCheck(refDelivery:String, refPackage:String, checked : String)
    {
        for var i in (0..<_listDelivery.count) {
            if (_listDelivery[i]._ref == refDelivery) {
                for var x in (0..<_listDelivery[i]._listPackage.count) {
                    if _listDelivery[i]._listPackage[x]._reference == refPackage {
                        _listDelivery[i]._listPackage[x]._checked = checked
                    }
                }
            }
        }
    }
    
    func setPackageDelivered(refDelivery:String, refPackage:String)
    {
        for var i in (0..<_listDelivery.count) {
            if (_listDelivery[i]._ref == refDelivery) {
                for var x in (0..<_listDelivery[i]._listPackage.count) {
                    if _listDelivery[i]._listPackage[x]._reference == refPackage {
                        _listDelivery[i]._listPackage[x]._delivered = true
                    }
                }
            }
        }
    }

    
    func getStateProduct(refDelivery:String, refPackage:String, refProduct:String) -> String {
        var tmp =  String()
        for elem in _listDelivery {
            if (elem._ref == refDelivery) {
                for elem2 in elem._listPackage {
                    if(elem2._reference == refPackage){
                        for elem3 in elem2._listProduct {
                            if (elem3._reference == refProduct) {
                                tmp = elem3._checked
                            }
                        }
                    }
                    
                }
            }
        }
        return tmp
    }
    
    func getDeliveryForLivraison() -> [s_delivery] {
        var tmp = [s_delivery]()
        for elem in _listDelivery {
            if (elem._status == "EN ATTENTE DE LIVRAISON") {
                tmp.append(elem)
            }
        }
        return tmp
    }
    
    func changeStatuDelivery(refDelivery : String) {
        for i in (0..<_listDelivery.count) {
            if (_listDelivery[i]._ref == refDelivery) {
                _listDelivery[i]._status = "EN ATTENTE DE LIVRAISON"
            }
    }
    }
    
    func setStateProduct(refDelivery:String, refPackage:String, refProduct:String, state: String){

        for var i in (0..<_listDelivery.count) {
            if (_listDelivery[i]._ref == refDelivery) {
                for var x in (0..<_listDelivery[i]._listPackage.count) {
                    if _listDelivery[i]._listPackage[x]._reference == refPackage {
                        for var y in (0..<_listDelivery[i]._listPackage[x]._listProduct.count) {
                            if (_listDelivery[i]._listPackage[x]._listProduct[y]._reference == refProduct) {
                                _listDelivery[i]._listPackage[x]._listProduct[y]._checked = state
                            }
                        }
                    }
                }
            }
        }
    }
}

