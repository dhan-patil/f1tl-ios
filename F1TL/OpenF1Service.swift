import Foundation

// MARK: - OpenF1 Session Model

struct OpenF1Session: Codable, Identifiable {
    let sessionKey: Int
    let sessionName: String
    let countryName: String?
    let circuitShortName: String?
    let dateStart: String?

    var id: Int { sessionKey }

    enum CodingKeys: String, CodingKey {
        case sessionKey = "session_key"
        case sessionName = "session_name"
        case countryName = "country_name"
        case circuitShortName = "circuit_short_name"
        case dateStart = "date_start"
    }
}
struct OpenF1Position: Codable {

    let driver_number: Int
    let position: Int
}   

// MARK: - OpenF1 Service

class OpenF1Service {

    // Test Fetch: Get Sprint Shootout session
    func fetchSprintShootoutSession() async -> [OpenF1Session] {

        guard let url = URL(
            string: "https://api.openf1.org/v1/sessions?year=2025&country_name=China"
        ) else {
            return []
        }

        do {

            let (data, _) =
            try await URLSession.shared.data(from: url)

            let decoded =
            try JSONDecoder().decode(
                [OpenF1Session].self,
                from: data
            )

            return decoded

        } catch {

            print(
                "OpenF1 Error:",
                error
            )

            return []
        }
    }
}
