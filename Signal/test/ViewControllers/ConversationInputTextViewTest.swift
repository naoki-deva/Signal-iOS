//
// Copyright 2026 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

import XCTest

@testable import Signal
@testable import SignalServiceKit

class ConversationInputTextViewTest: SignalBaseTest {

    @MainActor
    func testScrollDisabledForFourLinesOrLess() {
        let textView = ConversationInputTextView()
        textView.frame = CGRect(x: 0, y: 0, width: 320, height: 200)

        textView.setMessageBody(
            MessageBody(text: "Line 1\nLine 2\nLine 3\nLine 4", ranges: .empty),
            txProvider: SSKEnvironment.shared.databaseStorageRef.readTxProvider,
        )

        textView.layoutIfNeeded()

        XCTAssertFalse(textView.isScrollEnabled)
    }

    @MainActor
    func testScrollEnabledForMoreThanFourLines() {
        let textView = ConversationInputTextView()
        textView.frame = CGRect(x: 0, y: 0, width: 320, height: 200)

        textView.setMessageBody(
            MessageBody(text: "Line 1\nLine 2\nLine 3\nLine 4\nLine 5", ranges: .empty),
            txProvider: SSKEnvironment.shared.databaseStorageRef.readTxProvider,
        )

        textView.layoutIfNeeded()

        XCTAssertTrue(textView.isScrollEnabled)
    }
}
