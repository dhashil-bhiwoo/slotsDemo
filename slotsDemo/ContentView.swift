//
//  ContentView.swift
//  slotsDemo
//
//  Created by Dhashil Bhiwoo on 27/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    // use @State when data is modified
    @State private var credits = 1000
    @State private var symbols = ["apple", "star", "cherry"]
    //moving to 9 cards
    //@State private var numbers = [0,2,1]
    //@State private var backgrounds = [Color.white,Color.white,Color.white]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    private var betAmount = 5
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red:200/255, green:143/255, blue:23/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red:228/255, green:195/255, blue:76/255))
                .rotationEffect(Angle(degrees: 45))
                .ignoresSafeArea(.all)
            
            VStack{
                //title
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("SwiftUI Slots")
                        .bold()
                        .foregroundColor(.white)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                .scaleEffect(2)
                Spacer()
                //credit counter
                Text("Credits:" + String(credits))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20.0)
                VStack{
                    HStack{
                        Spacer()
                        CardView(symbol: $symbols[numbers[0]],background: $backgrounds[0])
                        CardView(symbol: $symbols[numbers[1]],background: $backgrounds[1])
                        CardView(symbol: $symbols[numbers[2]],background: $backgrounds[2])
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        CardView(symbol: $symbols[numbers[3]],background: $backgrounds[3])
                        CardView(symbol: $symbols[numbers[4]],background: $backgrounds[4])
                        CardView(symbol: $symbols[numbers[5]],background: $backgrounds[5])
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        CardView(symbol: $symbols[numbers[6]],background: $backgrounds[6])
                        CardView(symbol: $symbols[numbers[7]],background: $backgrounds[7])
                        CardView(symbol: $symbols[numbers[8]],background: $backgrounds[8])
                        Spacer()
                    }
                }
                Spacer()
                //button SPIN
                HStack(spacing:40){
                    VStack{
                        Button(action: {
                            //code moved to processResults func
                            //process SINGLE spin
                            self.processResults()
                        }, label: {
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        })
                        Text("\(betAmount) Credits")
                            .padding(.top,10)
                            .font(.footnote)
                    }
                    VStack{
                        Button(action: {
                            //code moved to processResults func
                            //process MAX spin
                            self.processResults(true)
                        }, label: {
                            Text("Max Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        })
                        Text("\(betAmount * 5) Credits")
                            .padding(.top,10)
                            .font(.footnote)
                    }
                }
                
                
            }
        }
    }
    
    func processResults(_ isMax: Bool = false){
        //set backgrounds to white
        //map function instead of hard code
        self.backgrounds = self.backgrounds.map({_ in
            Color.white
        })
        
        //code to spin all cards
        if isMax{
            //spin all cards
            self.numbers = self.numbers.map({_ in
                Int.random(in: 0...self.symbols.count-1)
            })
        }else{
            //spin middle row
            self.numbers[3] = Int.random(in: 0...self.symbols.count-1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count-1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count-1)
        }
        
        
        //check winning
        processWin(isMax)
    }
    
    func processWin(_ isMax:Bool = false){
        
        var matches = 0
        
        if !isMax{
            //processing for single spin
            
            /*if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5] {
                //won
                //self.credits += self.betAmount * 10
                matches += 1
                
                //update backgrounds
                self.backgrounds[3] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[5] = Color.green
                //map function instead of hard code
                /*self.backgrounds = self.backgrounds.map{_ in
                 Color.green
                 }*/
            } /*else {
             // lost
             self.credits -= self.betAmount
             }*/*/
            
            if isMatch(3,4,5){ matches += 1 }
        }else{
            //processing for max spin
            
            //top row
            if isMatch(0, 1, 2){ matches += 1 }
            //middle row
            if isMatch(3, 4, 5){ matches += 1 }
            //bottom row
            if isMatch(6, 7, 8){ matches += 1 }
            //diagonal top left to bottom right
            if isMatch(0, 4, 8){ matches += 1 }
            //diagonal top right to bottom left
            if isMatch(2, 4, 6){ matches += 1 }
        }
        // check matches and distribute credits
        if matches > 0 {
            //atleast 1 match
            self.credits += matches * self.betAmount * 2
        } else if !isMax{
            //0 win, single spin
            self.credits -= self.betAmount
        }else{
            //0 wins, max spin
            self.credits -= self.betAmount * 5
        }
    }
    
    //function to check row match
    //accepts array index as param
    //returns bool
    func isMatch(_ index1:Int,_ index2:Int,_ index3:Int) -> Bool {
        
        if self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3] {
            
            //update backgrounds
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            
            return true
        }
        return false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
