//
//  CardView.swift
//  slotsDemo
//
//  Created by Dhashil Bhiwoo on 27/08/2021.
//

import SwiftUI

struct CardView: View {
    
    //accept 2 var values
    @Binding var symbol: String
    @Binding var background: Color
    
    var body: some View {
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(background.opacity(0.5))
            .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbol: Binding.constant("apple"),background: Binding.constant(Color.white))
    }
}
