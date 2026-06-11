//
//  F1Service.swift
//  F1TL
//

import Foundation

// MARK: - Race Calendar Models

struct Race: Codable, Identifiable {

    let id = UUID()

    let round: String
    let raceName: String
    let date: String
    let time: String?

    let FirstPractice: Session?
    let SecondPractice: Session?
    let ThirdPractice: Session?
    let Qualifying: Session?
    let Sprint: Session?

    let Circuit: CircuitInfo

    enum CodingKeys: String, CodingKey {
        case round
        case raceName
        case date
        case time
        case Circuit
        case FirstPractice
        case SecondPractice
        case ThirdPractice
        case Qualifying
        case Sprint
    }
}

struct CircuitInfo: Codable {
    let circuitName: String
}

struct Session: Codable {

    let date: String
    let time: String?
}

struct RaceResponse: Codable {
    let MRData: MRData
}

struct MRData: Codable {
    let RaceTable: RaceTable
}

struct RaceTable: Codable {
    let Races: [Race]
}

// MARK: - Race Result Model

struct RaceResult: Identifiable {

    let id = UUID()

    let position: String
    let driver: String
    let constructor: String
    let points: String
}

// MARK: - Driver Standing Model

struct DriverStanding: Identifiable {

    let id = UUID()

    let position: String
    let driver: String
    let points: String
}

// MARK: - Qualifying Model

struct QualifyingResult: Identifiable {

    let id = UUID()

    let position: String
    let driver: String
    let q1: String
    let q2: String
    let q3: String
}

// MARK: - Session Result Model

// MARK: - F1 API Service

class F1Service {

    // MARK: Fetch Season

    func fetchSeason(
        year: Int
    ) async -> [Race] {

        guard let url = URL(
            string:
            "https://api.jolpi.ca/ergast/f1/\(year)/races/"
        ) else {
            return []
        }

        do {

            let (data, _) =
            try await URLSession.shared.data(from: url)

            let decoded =
            try JSONDecoder().decode(
                RaceResponse.self,
                from: data
            )

            return decoded
                .MRData
                .RaceTable
                .Races

        } catch {

            print("API Error:", error)
            return []
        }
    }

    func fetchSessionResults(
        year: Int,
        round: Int,
        session: String
    ) async -> [SessionResult] {

        guard let url = URL(
            string:
                session == "sprint"
                ? "https://api.jolpi.ca/ergast/f1/\(year)/\(round)/sprint.json"
                : "https://api.jolpi.ca/ergast/f1/\(year)/\(round)/results.json"
        ) else {
            return []
        }

        do {

            let (data, _) =
            try await URLSession.shared.data(from: url)

            guard
                let json =
                try JSONSerialization.jsonObject(
                    with: data
                ) as? [String: Any],

                let mrData =
                json["MRData"] as? [String: Any],

                let raceTable =
                mrData["RaceTable"]
                as? [String: Any],

                let races =
                raceTable["Races"]
                as? [[String: Any]],

                let firstRace =
                races.first

            else {
                return []
            }

            let key =
            session == "sprint"
            ? "SprintResults"
            : "Results"

            guard let results =
            firstRace[key]
            as? [[String: Any]]

            else {
                return []
            }

            return results.map { result in

                let driver =
                (result["Driver"]
                    as? [String: Any])?[
                        "familyName"
                    ] as? String ?? "Unknown"

                let team =
                (result["Constructor"]
                    as? [String: Any])?[
                        "name"
                    ] as? String ?? "Unknown"

                let gap =
                (result["Time"]
                    as? [String: Any])?[
                        "time"
                    ] as? String
                ?? result["status"]
                as? String
                ?? "--"

                return SessionResult(

                    position:
                    result["position"]
                    as? String ?? "-",

                    driver: driver,

                    team: team,

                    time: gap
                )
            }

        } catch {

            print(
                "Session Results Error:",
                error
            )

            return []
        }
    }

    // MARK: Fetch Race Results

    func fetchRaceResults(
        year: Int,
        round: Int
    ) async -> [RaceResult] {

        guard let url = URL(
            string:
                "https://api.jolpi.ca/ergast/f1/\(year)/\(round)/results.json"
        ) else {
            return []
        }

        do {

            let (data, _) =
            try await URLSession.shared.data(from: url)

            guard
                let json =
                try JSONSerialization.jsonObject(
                    with: data
                ) as? [String: Any],

                let mrData =
                json["MRData"] as? [String: Any],

                let raceTable =
                mrData["RaceTable"] as? [String: Any],

                let races =
                raceTable["Races"] as? [[String: Any]],

                let firstRace = races.first,

                let results =
                firstRace["Results"] as? [[String: Any]]

            else {
                return []
            }

            return results.map { result in

                let driver =
                (result["Driver"]
                    as? [String: Any])?["familyName"]
                as? String ?? "Unknown"

                let constructor =
                (result["Constructor"]
                    as? [String: Any])?["name"]
                as? String ?? "Unknown"

                return RaceResult(
                    position:
                        result["position"]
                        as? String ?? "-",

                    driver: driver,

                    constructor: constructor,

                    points:
                        result["points"]
                        as? String ?? "0"
                )
            }

        } catch {

            print("Results API Error:", error)
            return []
        }
    }

    // MARK: Fetch Driver Standings

    func fetchDriverStandings(
        year: Int,
        round: Int
    ) async -> [DriverStanding] {

        guard let url = URL(
            string:
            "https://api.jolpi.ca/ergast/f1/\(year)/\(round)/driverstandings.json"
        ) else {
            return []
        }

        do {

            let (data, _) =
            try await URLSession.shared.data(from: url)

            guard
                let json =
                try JSONSerialization.jsonObject(
                    with: data
                ) as? [String: Any],

                let mrData =
                json["MRData"] as? [String: Any],

                let standingsTable =
                mrData["StandingsTable"]
                as? [String: Any],

                let standingsLists =
                standingsTable["StandingsLists"]
                as? [[String: Any]],

                let standings =
                standingsLists.first?["DriverStandings"]
                as? [[String: Any]]

            else {
                return []
            }

            return standings.map { standing in

                let driver =
                (standing["Driver"]
                    as? [String: Any])?["familyName"]
                as? String ?? "Unknown"

                return DriverStanding(
                    position:
                        standing["position"]
                        as? String ?? "-",

                    driver: driver,

                    points:
                        standing["points"]
                        as? String ?? "0"
                )
            }

        } catch {

            print("Standings API Error:", error)
            return []
        }
    }
    // MARK: Fetch Qualifying Results

    // MARK: Fetch Qualifying Results

    func fetchQualifyingResults(
        year: Int,
        round: Int
    ) async -> [QualifyingResult] {

        guard let url = URL(
            string:
            "https://api.jolpi.ca/ergast/f1/\(year)/\(round)/qualifying.json"
        ) else {
            return []
        }

        do {

            let (data, _) =
            try await URLSession.shared.data(from: url)

            guard
                let json =
                try JSONSerialization.jsonObject(
                    with: data
                ) as? [String: Any],

                let mrData =
                json["MRData"] as? [String: Any],

                let raceTable =
                mrData["RaceTable"]
                as? [String: Any],

                let races =
                raceTable["Races"]
                as? [[String: Any]],

                let firstRace = races.first,

                let qualifyingResults =
                firstRace["QualifyingResults"]
                as? [[String: Any]]

            else {
                return []
            }

            return qualifyingResults.map { result in

                let driver =
                (result["Driver"]
                    as? [String: Any])?[
                        "familyName"
                    ] as? String ?? "Unknown"

                return QualifyingResult(
                    position:
                    result["position"]
                    as? String ?? "-",

                    driver: driver,

                    q1:
                    result["Q1"]
                    as? String ?? "—",

                    q2:
                    result["Q2"]
                    as? String ?? "—",

                    q3:
                    result["Q3"]
                    as? String ?? "—"
                )
            }

        } catch {

            print(
                "Qualifying API Error:",
                error
            )

            return []
        }
    }

    // MARK: Fetch Qualifying Results

    func fetchSprintQualifyingResults(
        year: Int,
        round: Int
    ) async -> [QualifyingResult] {

        let sessionKey = 9989
        // Chinese GP 2025 Sprint Qualifying

        guard let url = URL(
            string:
            "https://api.openf1.org/v1/session_result?session_key=\(sessionKey)"
        ) else {
            return []
        }

        do {

            let (data, _) =
            try await URLSession.shared.data(from: url)

            guard let json =
            try JSONSerialization.jsonObject(
                with: data
            ) as? [[String: Any]]

            else {
                return []
            }

            return json.enumerated().map { index, result in

                let number =
                result["driver_number"]
                as? Int ?? 0

                let bestLap =
                result["best_lap_time"]
                as? Double ?? 0

                let lapString =
                bestLap > 0
                ? String(
                    format: "%.3f",
                    bestLap
                )
                : "—"

                return QualifyingResult(

                    position:
                    "\(index + 1)",

                    driver:
                    driverName(
                        from: number
                    ),

                    q1: lapString,
                    q2: lapString,
                    q3: lapString
                )
            }

        } catch {

            print(
                "Sprint Qualifying Error:",
                error
            )

            return []
        }
    }

    func driverName(from number: Int) -> String {

        switch number {

        case 1: return "Verstappen"
        case 4: return "Norris"
        case 5: return "Bortoleto"
        case 6: return "Hadjar"
        case 10: return "Gasly"
        case 12: return "Antonelli"
        case 14: return "Alonso"
        case 16: return "Leclerc"
        case 18: return "Stroll"
        case 22: return "Tsunoda"
        case 23: return "Albon"
        case 27: return "Hülkenberg"
        case 30: return "Lawson"
        case 31: return "Ocon"
        case 44: return "Hamilton"
        case 55: return "Sainz"
        case 63: return "Russell"
        case 81: return "Piastri"
        case 87: return "Bearman"

        default:
            return "\(number)"
        }
    }
}
