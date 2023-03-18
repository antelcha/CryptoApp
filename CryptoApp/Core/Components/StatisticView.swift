//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 15.03.2023.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0 ) > 0 ? 0 : 180))
                    
                Text(stat.percentageChange?.asPercentageString() ?? "")
                    .font(.caption)
                    
                .bold()
            }.foregroundColor((stat.percentageChange ?? 0 ) > 0 ? .theme.green  : .theme.red)
                .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.state1)
    }
}
