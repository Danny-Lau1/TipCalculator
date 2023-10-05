//
//  ContentView.swift
//  WeSplit
//
//  Created by Danny Lau on 10/2/23.
//

import SwiftUI

struct ContentView: View {
    // add default values
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused : Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // computed property
    var totalPerPerson: (one: Double, two: Double) {
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return (amountPerPerson, grandTotal)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    // using 'value' because it is a double
                    // use ? for unwrapping and ?? for nil coalescing
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People:", selection: $numberOfPeople){
                        ForEach(1..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink) // this makes selection number of people pop up in a new screen
                }
                Section{
                    
                    Picker("Tip Percent", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Enter Tip Amount") // header modifies the section
                }
                
                Section{
                    Text(totalPerPerson.1, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Grand Total")
                }
                
                Section{
                    Text(totalPerPerson.0, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount Per Person")
                }
            }
            .navigationTitle("WeSplit") // modifying the form
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer() // pushes the done button to the right
                    
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
