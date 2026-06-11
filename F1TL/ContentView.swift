import SwiftUI

// MARK: - Home Screen
struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // MARK: - Background Gradient
                LinearGradient(
                    colors: [
                        .black,
                        Color(red: 0.18, green: 0, blue: 0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // MARK: - Main Content
                VStack {
                    
                    Spacer()
                    
                    // Title
                    Text("F1TL")
                        .font(.system(size: 64, weight: .heavy))
                        .foregroundColor(.white)
                        .tracking(3)
                        .shadow(
                            color: .red.opacity(0.45),
                            radius: 16
                        )
                    
                    // Subtitle
                    Text("Every Race. Every Rivalry. Every Era.")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                    
                    // Description
                    Text("Experience Formula 1 history race by race.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.top, 4)
                    
                    Spacer()
                    
                    // MARK: - Start Button
                    NavigationLink {
                        SeasonSelectionView()
                    } label: {
                        HStack(spacing: 10) {
                            Text("ENTER")
                                .fontWeight(.bold)
                            
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.85))
                        .cornerRadius(22)
                        .padding(.horizontal, 24)
                    }
                    
                    Text("1950 — Present")
                        .foregroundColor(.gray.opacity(0.8))
                        .font(.footnote)
                        .padding(.top, 18)
                        .padding(.bottom, 30)
                }
            }
        }
        .task {

            let sessions =
            await OpenF1Service()
                .fetchSprintShootoutSession()

            print("OPENF1 SESSIONS:")

            for session in sessions {

                print(
                    session.sessionName,
                    session.sessionKey
                )
            }
        }
    }
}

// MARK: - Season Selection View
struct SeasonSelectionView: View {
    
    let seasons = Array((1950...2026).reversed())
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            List {
                Section {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Choose a Season")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                        
                        Text("Relive Formula 1 history")
                            .foregroundColor(.gray)
                    }
                    .listRowBackground(Color.black)
                    
                    ForEach(seasons, id: \.self) { season in
                        NavigationLink {
                            Season2021View(year: season)
                        }
                        label: {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(season, format: .number.grouping(.never))")
                                    .font(.system(size: 28, weight: .heavy))
                                    .foregroundColor(.white)
                                
                                Text(seasonDescription(for: season))
                                    .foregroundColor(.gray)
                                
                                HStack {
                                    Text("Enter Season")
                                        .foregroundColor(.red)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.vertical, 12)
                        }
                        .listRowBackground(Color.black)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
        }
        .navigationBarBackButtonHidden(false)
    }
    
    func seasonDescription(for season: Int) -> String {
        switch season {
        case 2026:
            return "New Era Begins"
            
        case 2025:
            return "Norris vs Verstappen"
            
        case 2024:
            return "Verstappen vs McLaren"
            
        case 2023:
            return "Verstappen Dominance"
            
        case 2022:
            return "Verstappen vs Leclerc"
            
        case 2021:
            return "Verstappen vs Hamilton"
            
        case 2020:
            return "Hamilton's Seventh Crown"
            
        case 2019:
            return "Hamilton vs Ferrari"
            
        case 2018:
            return "Hamilton vs Vettel"
            
        case 2017:
            return "Hamilton vs Vettel"
            
        case 2016:
            return "Hamilton vs Rosberg"
            
        case 2015:
            return "Hamilton vs Rosberg"
            
        case 2014:
            return "Hamilton vs Rosberg"
            
        case 2013:
            return "Vettel's Final Masterclass"
            
        case 2012:
            return "Vettel vs Alonso"
            
        case 2011:
            return "Vettel Ascends"
            
        case 2010:
            return "Four-Way Title Fight"
            
        case 2009:
            return "Brawn GP Miracle"
            
        case 2008:
            return "Hamilton vs Massa"
            
        case 2007:
            return "Hamilton vs Alonso"
            
        case 2006:
            return "Schumacher vs Alonso"
            
        case 2005:
            return "Alonso Ends Ferrari Era"
            
        case 2004:
            return "Schumacher Dominance"
            
        case 2003:
            return "Schumacher vs Räikkönen"
            
        case 2002:
            return "Ferrari Domination"
            
        case 2001:
            return "Schumacher Reigns"
            
        case 2000:
            return "Schumacher vs Häkkinen"
            
        case 1999:
            return "Häkkinen vs Irvine"
            
        case 1998:
            return "Schumacher vs Häkkinen"
            
        case 1997:
            return "Villeneuve vs Schumacher"
            
        case 1996:
            return "Hill vs Villeneuve"
            
        case 1995:
            return "Schumacher vs Hill"
            
        case 1994:
            return "Schumacher vs Hill"
            
        case 1993:
            return "Prost vs Senna"
            
        case 1992:
            return "Mansell Unstoppable"
            
        case 1991:
            return "Senna vs Mansell"
            
        case 1990:
            return "Senna vs Prost"
            
        case 1989:
            return "Senna vs Prost"
            
        case 1988:
            return "Senna vs Prost"
            
        case 1987:
            return "Piquet vs Mansell"
            
        case 1986:
            return "Prost vs Mansell"
            
        case 1985:
            return "Prost's First Crown"
            
        case 1984:
            return "Lauda vs Prost"
            
        case 1983:
            return "Piquet vs Prost"
            
        case 1982:
            return "The Wildest Season"
            
        case 1981:
            return "Piquet vs Reutemann"
            
        case 1980:
            return "Jones vs Piquet"
            
        case 1979:
            return "Scheckter vs Villeneuve"
            
        case 1978:
            return "Andretti's Glory"
            
        case 1977:
            return "Lauda's Comeback"
            
        case 1976:
            return "Hunt vs Lauda"
            
        case 1975:
            return "Lauda Begins Reign"
            
        case 1974:
            return "Fittipaldi vs Regazzoni"
            
        case 1973:
            return "Stewart's Final Crown"
            
        case 1972:
            return "Fittipaldi Arrives"
            
        case 1971:
            return "Stewart Dominates"
            
        case 1970:
            return "Rindt's Legacy"
            
        case 1969:
            return "Stewart Ascends"
            
        case 1968:
            return "Hill vs Stewart"
            
        case 1967:
            return "Clark vs Brabham"
            
        case 1966:
            return "Brabham's Masterclass"
            
        case 1965:
            return "Clark Dominance"
            
        case 1964:
            return "Surtees vs Hill"
            
        case 1963:
            return "Clark Emerges"
            
        case 1962:
            return "Hill vs Clark"
            
        case 1961:
            return "Hill vs Von Trips"
            
        case 1960:
            return "Brabham Breakthrough"
            
        case 1959:
            return "Brabham vs Moss"
            
        case 1958:
            return "Hawthorn vs Moss"
            
        case 1957:
            return "Fangio's Final Crown"
            
        case 1956:
            return "Fangio vs Collins"
            
        case 1955:
            return "Mercedes Dominance"
            
        case 1954:
            return "Fangio Returns"
            
        case 1953:
            return "Ascari Reigns"
            
        case 1952:
            return "Ascari Dominance"
            
        case 1951:
            return "Fangio vs Alfa Romeo"
            
        case 1950:
            return "The Beginning"
            
        default:
            return "Formula 1 Season"
        }
    }
    struct Season2021View: View {
        
        let year: Int
        @State private var races: [Race] = []
        
        var body: some View {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 10) {

                        Text("\(year, format: .number.grouping(.never)) Season")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)

                        Text(SeasonSelectionView().seasonDescription(for: year))
                            .foregroundColor(.red)

                        Text(seasonSubtitle())
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(spacing: 14) {
                            
                            ForEach(races) { race in
                                
                                NavigationLink {
                                    RaceDetailView(
                                        year: year,
                                        round: Int(race.round) ?? 1,
                                        raceName: race.raceName,
                                        race: race
                                    )
                                    
                                } label: {
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading, spacing: 6) {
                                            
                                            Text("ROUND \(race.round)")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                            
                                            Text(race.raceName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            
                                            Text(race.Circuit.circuitName)
                                                .foregroundColor(.red)
                                                .font(.subheadline)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.06))
                                    .cornerRadius(18)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .task {
                    races = await F1Service().fetchSeason(year: year)
                }
            }
        }
        func seasonSubtitle() -> String {

            let currentYear = Calendar.current.component(
                .year,
                from: Date()
            )

            if year >= currentYear {
                return "\(races.count) races • Season in progress"
            }

            return "\(races.count) races • Championship decided in Abu Dhabi"
        }
    }
}
func seasonTitle(for season: Int) -> String {
    switch season {
        
    case 2025:
        return "Norris vs Verstappen"
        
    case 2024:
        return "Verstappen vs McLaren"
        
    case 2023:
        return "Verstappen Dominance"
        
    case 2022:
        return "Verstappen vs Leclerc"
        
    case 2021:
        return "Verstappen vs Hamilton"
        
    case 2020:
        return "Hamilton's Seventh Crown"
        
    case 2019:
        return "Hamilton vs Ferrari"
        
    case 2018:
        return "Hamilton vs Vettel"
        
    case 2017:
        return "Hamilton vs Vettel"
        
    case 2016:
        return "Hamilton vs Rosberg"
        
    case 2015:
        return "Hamilton vs Rosberg"
        
    case 2014:
        return "Hamilton vs Rosberg"
        
    default:
        return "Formula 1 Season"
    }
}
// MARK: - Race Detail View
struct RaceDetailView: View {
    
    let year: Int
    let round: Int
    let raceName: String
    let race: Race
    
    @State private var isSprintWeekend = false
    @State private var results: [RaceResult] = []
    @State private var standings: [DriverStanding] = []
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 18) {
                    
                    Text(raceName)
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    // Small Track Map
                    AsyncImage(url: URL(string: trackURL())) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 180)
                    .padding(.vertical, 6)
                    
                    Text(
                        "Round \(round) • \(year, format: .number.grouping(.never))"
                    )
                    .foregroundColor(.gray)
                        .foregroundColor(.gray)
                    
                    Divider()
                        .overlay(Color.white.opacity(0.2))
                    
                    // MARK: - Weekend Format
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack {
                            
                            Text("WEEKEND FORMAT")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            
                            if isSprintWeekend {
                                Text("⚡ SPRINT")
                                    .font(.caption2.bold())
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.yellow)
                                    .cornerRadius(8)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 14) {
                            
                            if isSprintWeekend {
                                
                                WeekendRow(
                                    title: "FP1",
                                    date: formattedDate(race.FirstPractice?.date)
                                )

                                NavigationLink {

                                    QualifyingView(
                                        year: year,
                                        round: round,
                                        raceName: raceName,
                                        isSprintQualifying: true
                                    )

                                } label: {

                                    WeekendRow(
                                        title: "SPRINT QUALIFYING",
                                        date: formattedDate(
                                            race.Qualifying?.date
                                        )
                                    )
                                }

                                NavigationLink {

                                    SessionResultsView(
                                        title: "\(raceName) Sprint",
                                        year: year,
                                        round: round,
                                        sessionType: "sprint"
                                    )

                                } label: {

                                    WeekendRow(
                                        title: "SPRINT",
                                        date: formattedDate(
                                            race.Sprint?.date
                                        )
                                    )
                                }

                                NavigationLink {

                                    QualifyingView(
                                        year: year,
                                        round: round,
                                        raceName: raceName,
                                        isSprintQualifying: false
                                    )

                                } label: {

                                    WeekendRow(
                                        title: "QUALIFYING",
                                        date: formattedDate(race.Qualifying?.date)
                                    )
                                }

                                NavigationLink {

                                    SessionResultsView(
                                        title: "\(raceName) Race",
                                        year: year,
                                        round: round,
                                        sessionType: "results"
                                    )

                                } label: {

                                    WeekendRow(
                                        title: "RACE",
                                        date: formattedDate(
                                            race.date
                                        ),
                                        isRace: true
                                    )
                                }
                                
                            } else {
                                
                                NavigationLink {

                                    SessionResultsView(
                                        title: "\(raceName) FP1",
                                        year: year,
                                        round: round,
                                        sessionType: "results"
                                    )

                                } label: {

                                    WeekendRow(
                                        title: "FP1",
                                        date: formattedDate(
                                            race.FirstPractice?.date
                                        )
                                    )
                                }

                                NavigationLink {

                                    SessionResultsView(
                                        title: "\(raceName) FP2",
                                        year: year,
                                        round: round,
                                        sessionType: "results"
                                    )

                                } label: {

                                    WeekendRow(
                                        title: "FP2",
                                        date: formattedDate(
                                            race.SecondPractice?.date
                                        )
                                    )
                                }

                                NavigationLink {

                                    SessionResultsView(
                                        title: "\(raceName) FP3",
                                        year: year,
                                        round: round,
                                        sessionType: "results"
                                    )

                                } label: {

                                    WeekendRow(
                                        title: "FP3",
                                        date: formattedDate(
                                            race.ThirdPractice?.date
                                        )
                                    )
                                }

                                NavigationLink {

                                    QualifyingView(
                                        year: year,
                                        round: round,
                                        raceName: raceName,
                                        isSprintQualifying: false
                                    )

                                } label: {

                                    WeekendRow(
                                        title: "QUALIFYING",
                                        date: formattedDate(race.Qualifying?.date)
                                    )
                                }

                                NavigationLink {

                                    SessionResultsView(
                                        title: "\(raceName) Race",
                                        year: year,
                                        round: round,
                                        sessionType: "results"
                                    )

                                } label: {

                                    WeekendRow(
                                        title: "RACE",
                                        date: formattedDate(
                                            race.date
                                        ),
                                        isRace: true
                                    )
                                }
                            }
                        }
                    }
                    
                    // MARK: - Race Result
                    
                    Text("RACE RESULT")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top)
                    
                    ForEach(results.prefix(3)) { result in
                        
                        HStack {
                            
                            Text(result.position)
                                .font(.headline.bold())
                                .foregroundColor(.red)
                                .frame(width: 28)
                            
                            VStack(alignment: .leading) {
                                
                                Text(result.driver)
                                    .foregroundColor(.white)
                                
                                Text(result.constructor)
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            Text("\(result.points) pts")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                    }
                    NavigationLink {
                        FullResultsView(results: results)
                    } label: {
                        Text("View All Results")
                            .foregroundColor(.red)
                            .padding(.top, 6)
                    }
                    
                    // MARK: - Driver Standings
                    
                    Text("DRIVER STANDINGS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top)
                    
                    ForEach(standings.prefix(5)) { standing in
                        
                        HStack {
                            
                            Text(standing.position)
                                .font(.headline.bold())
                                .foregroundColor(.red)
                                .frame(width: 28)
                            
                            Text(standing.driver)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text(standing.points)
                                .foregroundColor(.gray)
                            
                            Text("pts")
                                .foregroundColor(.gray.opacity(0.7))
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                    }
                    NavigationLink {
                        FullStandingsView(standings: standings)
                    } label: {
                        Text("View Full Standings")
                            .foregroundColor(.red)
                            .padding(.top, 6)
                    }
                }
                .padding()
            }
            .task {
                
                checkSprintWeekend()
                
                results =
                await F1Service()
                    .fetchRaceResults(
                        year: year,
                        round: round
                    )
                
                standings =
                await F1Service()
                    .fetchDriverStandings(
                        year: year,
                        round: round
                    )
            }
        }
    }
    func trackURL() -> String {

        switch raceName {

        case "Australian Grand Prix":
            return "https://media.formula1.com/image/upload/f_auto/q_auto/v1677244576/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Australia_Circuit.png"

        case "Bahrain Grand Prix":
            return "https://media.formula1.com/image/upload/f_auto/q_auto/v1677244576/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Bahrain_Circuit.png"

        case "Saudi Arabian Grand Prix":
            return "https://media.formula1.com/image/upload/f_auto/q_auto/v1677244576/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/SaudiArabia_Circuit.png"

        case "Monaco Grand Prix":
            return "https://media.formula1.com/image/upload/f_auto/q_auto/v1677244576/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Monaco_Circuit.png"

        case "British Grand Prix":
            return "https://media.formula1.com/image/upload/f_auto/q_auto/v1677244576/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Britain_Circuit.png"

        case "Italian Grand Prix":
            return "https://media.formula1.com/image/upload/f_auto/q_auto/v1677244576/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Italy_Circuit.png"

        case "Japanese Grand Prix":
            return "https://media.formula1.com/image/upload/f_auto/q_auto/v1677244576/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Japan_Circuit.png"

        case "Abu Dhabi Grand Prix":
            return "https://media.formula1.com/image/upload/f_auto/q_auto/v1677244576/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/AbuDhabi_Circuit.png"

        default:
            return ""
        }
    }
    func formattedDate(_ dateString: String?) -> String {

        guard let dateString = dateString else {
            return "--"
        }

        let input = DateFormatter()
        input.dateFormat = "yyyy-MM-dd"

        let output = DateFormatter()
        output.dateFormat = "MMM d"

        guard let date = input.date(from: dateString)
        else {
            return "--"
        }

        return output.string(from: date)
    }
    
    // MARK: - Sprint Detection
    
    func checkSprintWeekend() {
        
        let sprintRounds: [Int: [Int]] = [
            
            2021: [10, 14, 19],
            2022: [4, 11, 21],
            2023: [4, 9, 12, 17, 18, 20],
            2024: [5, 6, 11, 19, 21, 23],
            2025: [2, 6, 12, 19, 21, 23]
        ]
        
        isSprintWeekend =
        sprintRounds[year]?.contains(round) ?? false
    }
}
// MARK: - Weekend Row
struct WeekendRow: View {

    let title: String
    let date: String
    var isRace: Bool = false
    
    var body: some View {
        
        HStack {

            Circle()
                .fill(isRace ? .red : .gray.opacity(0.6))
                .frame(width: 8, height: 8)

            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)

            Spacer()

            Text(date)
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.65))

            if isRace {
                Image(systemName: "flag.checkered")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}
// MARK: - Full Results View
struct FullResultsView: View {

    let results: [RaceResult]

    var body: some View {

        ZStack {
            Color.black
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {

                VStack(spacing: 12) {

                    Text("FULL RACE RESULTS")
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    ForEach(results) { result in

                        HStack {

                            Text(result.position)
                                .foregroundColor(.red)
                                .frame(width: 30)

                            VStack(alignment: .leading) {

                                Text(result.driver)
                                    .foregroundColor(.white)

                                Text(result.constructor)
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }

                            Spacer()

                            HStack(spacing: 6) {
                                Text(result.points)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)

                                Text("pts")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Full Standings View
struct FullStandingsView: View {

    let standings: [DriverStanding]

    var body: some View {

        ZStack {
            Color.black
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {

                VStack(spacing: 12) {

                    Text("FULL DRIVER STANDINGS")
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    ForEach(standings) { standing in

                        HStack {

                            Text(standing.position)
                                .foregroundColor(.red)
                                .frame(width: 30)

                            Text(standing.driver)
                                .foregroundColor(.white)

                            Spacer()

                            Text("\(standing.points) pts")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                    }
                }
                .padding()
            }
        }
    }
}
// MARK: - QUALIFYING + SPRINT QUALIFYING VIEW
struct QualifyingView: View {
    
    let year: Int
    let round: Int
    let raceName: String
    var isSprintQualifying: Bool = false
    
    @State private var qualifyingResults:
    [QualifyingResult] = []
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // MARK: - Title + Video
                Text(
                    isSprintQualifying
                    ? "\(raceName) Sprint Qualifying"
                    : "\(raceName) Qualifying"
                )
                .font(.title.bold())
                .foregroundColor(.white)
                
                // MARK: - Qualifying Table
                
                ScrollView(
                    .vertical,
                    showsIndicators: false
                ) {
                    
                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {
                        
                        // Header
                        
                        HStack(spacing: 8) {
                            
                            Text("Driver")
                                .frame(
                                    width: 90,
                                    alignment: .leading
                                )
                            
                            if isSprintQualifying {

                                Text("Grid")
                                    .frame(width: 75)

                                Text("Position")
                                    .frame(width: 75)

                                Text("")
                                    .frame(width: 75)

                            } else {

                                Text("Q1")
                                    .frame(width: 75)

                                Text("Q2")
                                    .frame(width: 75)

                                Text("Q3")
                                    .frame(width: 75)
                            }
                        }
                        .foregroundColor(.gray)
                        .font(.caption.bold())
                        
                        // Results
                        
                        ForEach(
                            qualifyingResults,
                            id: \.id
                        ) { qualifying in
                            
                            HStack(spacing: 8) {
                                
                                Text(
                                    qualifying.driver
                                )
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(
                                    width: 90,
                                    alignment: .leading
                                )
                                
                                Text(
                                    qualifying.q1
                                )
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .frame(width: 75)
                                
                                Text(
                                    qualifying.q2
                                )
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .frame(width: 75)
                                
                                Text(
                                    qualifying.q3
                                )
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .frame(width: 75)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(
                                Color.white.opacity(0.05)
                            )
                            .cornerRadius(12)
                        }
                        
                        if qualifyingResults.isEmpty {
                            
                            VStack(spacing: 10) {
                                
                                Image(
                                    systemName:
                                        "chart.xyaxis.line"
                                )
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                                
                                Text(
                                    "No qualifying data"
                                )
                                .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 40)
                        }
                    }
                }
                .frame(height: 520)
                
                Spacer()
            }
            .padding()
            .task {
                qualifyingResults = isSprintQualifying
                ? await F1Service().fetchSprintQualifyingResults(
                    year: year,
                    round: round
                )
                : await F1Service().fetchQualifyingResults(
                    year: year,
                    round: round
                )
            }
        }
    }
}
#Preview {
    ContentView()
}

