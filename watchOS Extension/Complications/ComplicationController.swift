//
//  ComplicationController.swift
//  MoviesWatch Extension
//
//  Created by Adam Young on 15/07/2020.
//

import ClockKit
import TMDb

class ComplicationController: NSObject, CLKComplicationDataSource {

    private let moviesManager: MoviesManager
    private let tvShowsManager: TVShowsManager

    override init() {
        self.moviesManager = TMDbMoviesManager()
        self.tvShowsManager = TMDbTVShowsManager()
        super.init()
        TMDbAPI.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
    }

    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: ComplicationType.trendingMovie.rawValue,
                                      displayName: ComplicationType.trendingMovie.displayName,
                                      supportedFamilies: CLKComplicationFamily.allCases),
            CLKComplicationDescriptor(identifier: ComplicationType.trendingTVShow.rawValue,
                                      displayName: ComplicationType.trendingTVShow.displayName,
                                      supportedFamilies: CLKComplicationFamily.allCases)
        ]

        handler(descriptors)
    }

    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration

    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date().addingTimeInterval(10))
    }

    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population

    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        createTemplate(for: complication) { template in
            guard let template = template else {
                handler(nil)
                return
            }

            template.tintColor = UIColor(named: "AccentColor")
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        }
    }

    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        handler(nil)
    }

    // MARK: - Sample Templates

    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        createTemplate(for: complication) { template in
            guard let template = template else {
                handler(nil)
                return
            }

            template.tintColor = UIColor(named: "AccentColor")
            handler(template)
        }
    }

}

extension ComplicationController {

    // swiftlint:disable cyclomatic_complexity
    private func createTemplate(for complication: CLKComplication, handler: @escaping (CLKComplicationTemplate?) -> Void) {
        guard let complicationType = ComplicationType(rawValue: complication.identifier) else {
            handler(nil)
            return
        }

        let headerTextProvider = createHeaderTextProvider(for: complicationType)
        createBodyTextProvider(for: complicationType) { bodyTextProvider in
            switch complication.family {
            case .circularSmall:
                handler(self.createCircularSmallTemplate(headerTextProvider: headerTextProvider,
                                                         bodyTextProvider: bodyTextProvider))

            case .modularSmall:
                handler(self.createModularSmallTemplate(headerTextProvider: headerTextProvider,
                                                        bodyTextProvider: bodyTextProvider))

            case .modularLarge:
                handler(self.createModularLargeTemplate(headerTextProvider: headerTextProvider,
                                                        bodyTextProvider: bodyTextProvider))

            case .utilitarianSmall:
                handler(self.createUtilitarianSmallTemplate(bodyTextProvider: bodyTextProvider))

            case .utilitarianSmallFlat:
                handler(self.createUtilitarianSmallFlatTemplate(bodyTextProvider: bodyTextProvider))

            case .utilitarianLarge:
                handler(self.createUtilitarianLargeTemplate(bodyTextProvider: bodyTextProvider))

            case .extraLarge:
                handler(self.createExtraLargeTemplate(bodyTextProvider: bodyTextProvider))

            case .graphicCorner:
                handler(self.createGraphicCornerTemplate(headerTextProvider: headerTextProvider,
                                                         bodyTextProvider: bodyTextProvider))

            case .graphicBezel:
                handler(self.createGraphicBezelTemplate(headerTextProvider: headerTextProvider,
                                                        bodyTextProvider: bodyTextProvider))

            case .graphicCircular:
                handler(self.createGraphicCircularTemplate(headerTextProvider: headerTextProvider,
                                                           bodyTextProvider: bodyTextProvider))

            case .graphicRectangular:
                handler(self.createGraphicRectangleTemplate(headerTextProvider: headerTextProvider,
                                                            bodyTextProvider: bodyTextProvider))

            case .graphicExtraLarge:
                handler(self.createGraphicExtraLargeTemplate(headerTextProvider: headerTextProvider,
                                                             bodyTextProvider: bodyTextProvider))

            @unknown default:
                handler(nil)
            }
        }
    }
    // swiftlint:enable cyclomatic_complexity

}

extension ComplicationController {

    private func createCircularSmallTemplate(headerTextProvider: CLKTextProvider,
                                             bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        CLKComplicationTemplateCircularSmallStackText(line1TextProvider: headerTextProvider,
                                                      line2TextProvider: bodyTextProvider)
    }

    private func createModularSmallTemplate(headerTextProvider: CLKTextProvider,
                                            bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        CLKComplicationTemplateModularSmallStackText(line1TextProvider: headerTextProvider,
                                                     line2TextProvider: bodyTextProvider)
    }

    private func createModularLargeTemplate(headerTextProvider: CLKTextProvider,
                                            bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        CLKComplicationTemplateModularLargeStandardBody(headerTextProvider: headerTextProvider,
                                                        body1TextProvider: bodyTextProvider)
    }

    private func createUtilitarianSmallTemplate(bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        CLKComplicationTemplateUtilitarianSmallFlat(textProvider: bodyTextProvider)
    }

    private func createUtilitarianSmallFlatTemplate(bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        CLKComplicationTemplateUtilitarianSmallFlat(textProvider: bodyTextProvider)
    }

    private func createUtilitarianLargeTemplate(bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        CLKComplicationTemplateUtilitarianLargeFlat(textProvider: bodyTextProvider)
    }

    private func createExtraLargeTemplate(bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        CLKComplicationTemplateExtraLargeSimpleText(textProvider: bodyTextProvider)
    }

    private func createGraphicCornerTemplate(headerTextProvider: CLKTextProvider,
                                             bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        CLKComplicationTemplateGraphicCornerStackText(innerTextProvider: headerTextProvider,
                                                      outerTextProvider: bodyTextProvider)
    }

    private func createGraphicBezelTemplate(headerTextProvider: CLKTextProvider,
                                            bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        let circularTemplate = CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: headerTextProvider,
                                                                               line2TextProvider: bodyTextProvider)
        return CLKComplicationTemplateGraphicBezelCircularText(circularTemplate: circularTemplate)
    }

    private func createGraphicCircularTemplate(headerTextProvider: CLKTextProvider,
                                               bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        let imageProvider = CLKFullColorImageProvider(fullColorImage: UIImage(named: "ComplicationGraphic")!)
        return CLKComplicationTemplateGraphicCircularImage(imageProvider: imageProvider)
    }

    private func createGraphicRectangleTemplate(headerTextProvider: CLKTextProvider,
                                                bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        CLKComplicationTemplateGraphicRectangularStandardBody(headerTextProvider: headerTextProvider,
                                                              body1TextProvider: bodyTextProvider)
    }

    private func createGraphicExtraLargeTemplate(headerTextProvider: CLKTextProvider,
                                                 bodyTextProvider: CLKTextProvider) -> CLKComplicationTemplate {
        CLKComplicationTemplateGraphicExtraLargeCircularStackText(line1TextProvider: headerTextProvider,
                                                                  line2TextProvider: bodyTextProvider)
    }

}

extension ComplicationController {

    private func createHeaderTextProvider(for complicationType: ComplicationType) -> CLKSimpleTextProvider {
        let textProvider: CLKSimpleTextProvider
        switch complicationType {
        case .trendingMovie:
            textProvider = createTrendingMovieHeaderTextProvider()

        case .trendingTVShow:
            textProvider = createTrendingTVShowHeaderTextProvider()
        }

        textProvider.tintColor = UIColor(named: "AccentColor")!

        return textProvider
    }

    private func createTrendingMovieHeaderTextProvider() -> CLKSimpleTextProvider {
        CLKSimpleTextProvider(text: "Top Movie", shortText: "Movie")
    }

    private func createTrendingTVShowHeaderTextProvider() -> CLKSimpleTextProvider {
        CLKSimpleTextProvider(text: "Top TV Show", shortText: "TV Show")
    }

    private func createBodyTextProvider(for complicationType: ComplicationType,
                                        completionHandler:  @escaping (CLKSimpleTextProvider) -> Void) {
        switch complicationType {
        case .trendingMovie:
            createTrendingMovieTextProvider(completionHandler: completionHandler)

        case .trendingTVShow:
            createTrendingTVShowTextProvider(completionHandler: completionHandler)
        }
    }

    private func createTrendingMovieTextProvider(completionHandler:  @escaping (CLKSimpleTextProvider) -> Void) {
        moviesManager.fetchTopTrending { movie in
            let nameProvider = CLKSimpleTextProvider(text: movie?.title ?? "---")
            completionHandler(nameProvider)
        }
    }

    private func createTrendingTVShowTextProvider(completionHandler:  @escaping (CLKSimpleTextProvider) -> Void) {
        tvShowsManager.fetchTopTrending { tvShow in
            let nameProvider = CLKSimpleTextProvider(text: tvShow?.name ?? "---")
            completionHandler(nameProvider)
        }
    }

}
