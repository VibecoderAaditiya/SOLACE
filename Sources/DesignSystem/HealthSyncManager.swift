// Sources/DesignSystem/HealthSyncManager.swift
import Foundation
import HealthKit

#if ENABLE_TRANQUIL_UI
final class HealthSyncManager {
    static let shared = HealthSyncManager()
    private let healthStore = HKHealthStore()
    private let mindfulMinutesType = HKQuantityType.quantityType(forIdentifier: .mindfulSession)!
    
    private init() {}
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let typesToRead: Set<HKObjectType> = [mindfulMinutesType]
        healthStore.requestAuthorization(toShare: nil, read: typesToRead, completion: completion)
    }
    
    func fetchMindfulMinutes(completion: @escaping (Double) -> Void) {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: mindfulMinutesType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            var minutes = 0.0
            if let sum = result?.sumQuantity() {
                minutes = sum.doubleValue(for: HKUnit.minute())
            }
            DispatchQueue.main.async { completion(minutes) }
        }
        healthStore.execute(query)
    }
}
#endif
