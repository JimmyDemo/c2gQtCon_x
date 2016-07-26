// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

import "../pages"
import "../common"

Page {
    id: navPage
    property alias depth: navPane.depth
    property string name: "SpeakerNavPage"
    // index to get access to Loader (Destination)
    property int myIndex: index

    StackView {
        id: navPane
        anchors.fill: parent
        property string name: "SpeakerNavPane"
        focus: true

        initialItem: SpeakerListPage{
            id: initialItem
        }

        Loader {
            id: speakerDetailPageLoader
            property int speakerId: -1
            active: false
            visible: false
            source: "../pages/SpeakerDetailPage.qml"
            onLoaded: {
                item.speakerId = speakerId
                navPane.push(item)
                item.init()
            }
        }

        function pushSpeakerDetail(speakerId) {
            speakerDetailPageLoader.orderNr = speakerId
            speakerDetailPageLoader.active = true
        }

        function popOnePage() {
            var page = pop()
            if(page.name == "SpeakerDetailPage") {
                speakerDetailPageLoader.active = false
                return
            }
        } // popOnePage

    } // navPane

    function destinationAboutToChange() {
        // nothing
    }

    // triggered from BACK KEYs:
    // a) Android system BACK
    // b) Back Button from TitleBar
    function goBack() {
        // check if goBack is allowed
        //
        navPane.popOnePage()
    }

    Component.onDestruction: {
        cleanup()
    }

    function init() {
        console.log("INIT SpeakerNavPane")
        initialItem.init()
    }
    function cleanup() {
        console.log("CLEANUP SpeakerNavPane")
    }

} // navPage
