//
//  SessionResultsView.swift
//  F1TL
//
//  Created by Dhan on 23/05/26.
//
import SwiftUI

struct SessionResult: Identifiable {

    let id = UUID()

    let position: String
    let driver: String
    let team: String
    let time: String
}

struct SessionResultsView: View {

    let title: String
    let year: Int
    let round: Int
    let sessionType: String

    @State private var results:
    [SessionResult] = []

    var body: some View {

        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 20) {

                Text(title)
                    .font(.title.bold())
                    .foregroundColor(.white)

                ScrollView(
                    .vertical,
                    showsIndicators: false
                ) {

                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        HStack {

                            Text("Pos")
                                .frame(width: 40)

                            Text("Driver")
                                .frame(
                                    width: 100,
                                    alignment: .leading
                                )

                            Text("Time")
                                .frame(width: 110)
                        }
                        .foregroundColor(.gray)
                        .font(.caption.bold())

                        ForEach(results) { result in

                            HStack {

                                Text(result.position)
                                    .foregroundColor(.red)
                                    .frame(width: 40)

                                VStack(
                                    alignment: .leading
                                ) {

                                    Text(result.driver)
                                        .foregroundColor(.white)

                                    Text(result.team)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                                .frame(
                                    width: 100,
                                    alignment: .leading
                                )

                                Spacer()

                                Text(result.time)
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                            .padding()
                            .background(
                                Color.white.opacity(0.05)
                            )
                            .cornerRadius(14)
                        }

                        if results.isEmpty {

                            VStack(spacing: 10) {

                                Image(
                                    systemName:
                                    "chart.xyaxis.line"
                                )
                                .font(.largeTitle)
                                .foregroundColor(.gray)

                                Text("No data")
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 50)
                        }
                    }
                }
            }
            .padding()
            .task {

                results =
                await F1Service()
                    .fetchSessionResults(
                        year: year,
                        round: round,
                        session:
                        sessionType
                    )
            }
        }
    }
}
