import XCTest
import RxBlocking
import RxSwift
import RxTest
@testable import Dronecode_SDK_Swift

class ActionTest: XCTestCase {
    
    let ARBITRARY_ALTITUDE: Float = 123.5
    let ARBITRARY_SPEED: Float = 321.5
    
    let scheduler = MainScheduler.instance
    let actionResultsArray: [DronecodeSdk_Rpc_Action_ActionResult.Result] = [.busy, .commandDenied, .commandDeniedNotLanded, .commandDeniedLandedStateUnknown, .connectionError, .noSystem, .noVtolTransitionSupport, .timeout, .unknown, .vtolTransitionSupportUnknown]
    
    // MARK: - ARM
    func testArmSucceedsOnSuccess() {
        assertSuccess(result: armWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result.success))
    }
    
    func testArmFailsOnFailure() {
        actionResultsArray.forEach { result in
            assertFailure(result: armWithFakeResult(result: result))
        }
    }
    
    func armWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        var response = DronecodeSdk_Rpc_Action_ArmResponse()
        response.actionResult.result = result
        fakeService.armResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        return client.arm().toBlocking().materialize()
    }

    // MARK: - DISARM
    func testDisarmSucceedsOnSuccess() {
        assertSuccess(result: disarmWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result.success))
    }
    
    func testDisarmFailsOnFailure() {
        actionResultsArray.forEach { result in
             assertFailure(result: disarmWithFakeResult(result: result))
        }
    }
    
    func disarmWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        var response = DronecodeSdk_Rpc_Action_DisarmResponse()
        response.actionResult.result = result
        fakeService.disarmResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        return client.disarm().toBlocking().materialize()
    }
    
    // MARK: - KILL
    func testKillSucceedsOnSuccess() {
        assertSuccess(result: killWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result.success))
    }
    
    func testKillFailsOnFailure() {
        actionResultsArray.forEach { result in
            assertFailure(result: killWithFakeResult(result: result))
        }
    }
    
    func killWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        var response = DronecodeSdk_Rpc_Action_KillResponse()
        response.actionResult.result = result
        fakeService.killResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        return client.kill().toBlocking().materialize()
    }
    
    // MARK: - RETURN TO LAUNCH
    func testReturnToLaunchSucceedsOnSuccess() {
        assertSuccess(result: returnToLaunchWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result.success))
    }
    
    func testReturnToLaunchFailsOnFailure() {
        actionResultsArray.forEach { result in
             assertFailure(result: returnToLaunchWithFakeResult(result: result))
        }
    }
    
    func returnToLaunchWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        var response = DronecodeSdk_Rpc_Action_ReturnToLaunchResponse()
        response.actionResult.result = result
        fakeService.returnToLaunchResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        return client.returnToLaunch().toBlocking().materialize()
    }
    
    // MARK: - TRANSITION TO FIXED WINGS
    func testTransitionToFixedWingsSucceedsOnSuccess() {
        assertSuccess(result: transitionToFixedWingsWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result.success))
    }
    
    func testTransitionToFixedWingsFailsOnFailure() {
        actionResultsArray.forEach { result in
            assertFailure(result: transitionToFixedWingsWithFakeResult(result: result))
        }
    }
    
    func transitionToFixedWingsWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        var response = DronecodeSdk_Rpc_Action_TransitionToFixedWingResponse()
        response.actionResult.result = result
        fakeService.transitionToFixedWingResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        return client.transitionToFixedWing().toBlocking().materialize()
    }
    
    // MARK: - TRANSITION TO MULTICOPTER
    func testTransitionToMulticopterSucceedsOnSuccess() {
        assertSuccess(result: transitionToMulticopterWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result.success))
    }
    
    func testTransitionToMulticopterFailsOnFailure() {
        actionResultsArray.forEach { result in
            assertFailure(result: transitionToMulticopterWithFakeResult(result: result))
        }
    }
    
    func transitionToMulticopterWithFakeResult(result: DronecodeSdk_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        var response = DronecodeSdk_Rpc_Action_TransitionToMulticopterResponse()
        response.actionResult.result = result
        fakeService.transitionToMulticopterResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        return client.transitionToMulticopter().toBlocking().materialize()
    }
    
    // MARK: - GET TAKEOFF ALTITUDE
    func testGetTakeoffAltitudeSucceedsOnSuccess() {
        let expectedAltitude: Float = ARBITRARY_ALTITUDE
        
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        var response = DronecodeSdk_Rpc_Action_GetTakeoffAltitudeResponse()
        response.altitude = expectedAltitude
        fakeService.getTakeoffAltitudeResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        _ = client.getTakeoffAltitude().subscribe { event in
            switch event {
            case .success(let altitude):
                XCTAssert(altitude == expectedAltitude)
                break
            case .error(let error):
                XCTFail("Expecting success, got failure: getTakeoffAltitude() \(error) ")
            }
        }
    }
    
    // MARK: - SET TAKEOFF ALTITUDE
    func testSetTakeoffAltitudeSucceedsOnSuccess() {
        assertSuccess(result: setTakeoffAltitudeWithFakeResult())
    }
    
    func setTakeoffAltitudeWithFakeResult() -> MaterializedSequenceResult<Never> {
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        let response = DronecodeSdk_Rpc_Action_SetTakeoffAltitudeResponse()
        
        fakeService.setTakeoffAltitudeResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        return client.setTakeoffAltitude(altitude: 20.0).toBlocking().materialize()
    }
    
    // MARK: - GET MAXIMUM SPEED
    func testGetMaximumSpeedSucceedsOnSuccess() {
        let expectedSpeed = ARBITRARY_SPEED
        
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        var response = DronecodeSdk_Rpc_Action_GetMaximumSpeedResponse()
        response.speed = expectedSpeed
        
        fakeService.getMaximumSpeedResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        _ = client.getMaximumSpeed().subscribe { event in
            switch event {
            case .success(let speed):
                XCTAssert(speed == expectedSpeed)
                break
            case .error(let error):
                XCTFail("Expecting success, got failure: getMaximumSpeed() \(error) ")
            }
        }
    }
    
    // MARK: - SET MAXIMUM SPEED
    func testSetMaximumSpeedSucceedsOnSuccess() {
        assertSuccess(result: setMaximumSpeedWithFakeResult())
    }
    
    func setMaximumSpeedWithFakeResult() -> MaterializedSequenceResult<Never> {
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        let response = DronecodeSdk_Rpc_Action_SetMaximumSpeedResponse()
        fakeService.setMaximumSpeedResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        return client.setMaximumSpeed(speed: 20.0).toBlocking().materialize()
    }
    
    // MARK: - GET RTL ALTITUDE
    func testGetReturnToHomeAltitudeSucceedsOnSuccess() {
        let expectedAltitude: Float = 32.0
        
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        var response = DronecodeSdk_Rpc_Action_GetReturnToLaunchAltitudeResponse()
        response.relativeAltitudeM = expectedAltitude
        
        fakeService.getReturnToLaunchAltitudeResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        _ = client.getReturnToLaunchAltitude().subscribe { event in
            switch event {
            case .success(let speed):
                XCTAssert(speed == expectedAltitude)
                break
            case .error(let error):
                XCTFail("Expecting success, got failure: getMaximumSpeed() \(error) ")
            }
        }
    }

    // MARK: - SET RTL ALTITUDE
    func testSetReturnToHomeAltitude() {
        assertSuccess(result: setReturnToHomeAltitudeWithFakeResult())
    }
    
    func setReturnToHomeAltitudeWithFakeResult() -> MaterializedSequenceResult<Never> {
        let fakeService = DronecodeSdk_Rpc_Action_ActionServiceServiceTestStub()
        let response = DronecodeSdk_Rpc_Action_SetReturnToLaunchAltitudeResponse()
        fakeService.setReturnToLaunchAltitudeResponses.append(response)
        let client = Action(service: fakeService, scheduler: scheduler)
        
        return client.setReturnToLaunchAltitude(altitude: 30).toBlocking().materialize()
    }
    
    // MARK: - Utils
    func assertSuccess(result: MaterializedSequenceResult<Never>) {
        switch result {
            case .completed:
                break
            case .failed:
                XCTFail("Expecting success, got failure")
        }
    }

    func assertFailure(result: MaterializedSequenceResult<Never>) {
        switch result {
            case .completed:
                XCTFail("Expecting failure, got success")
            case .failed:
                break
        }
    }
}
