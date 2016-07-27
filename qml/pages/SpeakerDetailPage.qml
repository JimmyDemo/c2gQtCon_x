// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import org.ekkescorner.data 1.0

import "../common"
import "../navigation"

Page {
    id: speakerDetailPage
    focus: true
    property string name: "SpeakerDetailPage"

    // property Customer customer
    property Speaker speaker
    property SettingsData settingsData
    property int speakerId: -2
    onSpeakerIdChanged: {
        if(speakerId > 0) {
            speaker = dataManager.findSpeakerBySpeakerId(speakerId)
            speakerImage.speaker = speaker
            // already resolved for the list
            // dataManager.resolveOrderReferences(order)
            // customer = order.customerAsDataObject
        }
    }


    Flickable {
        id: flickable
        property string name: "speakerDetail"

        contentHeight: root.implicitHeight
        anchors.fill: parent

        Pane {
            id: root
            anchors.fill: parent
            ColumnLayout {
                Layout.fillWidth: true
                anchors.right: parent.right
                anchors.left: parent.left
                LabelHeadline {
                    topPadding: 16
                    bottomPadding: 16
                    leftPadding: 10
                    text: speaker.name
                }
                RowLayout {
                    Layout.fillWidth: true
                    Layout.leftMargin: 16
                    Layout.rightMargin: 6
                    Layout.bottomMargin: 12
                    SpeakerImageItem {
                        id: speakerImage
                        anchors.top: parent.top
                    }
                    LabelSubheading {
                        leftPadding: 10
                        rightPadding: 10
                        wrapMode: Text.WordWrap
                        text: speaker.bio
                        //Layout.preferredWidth: 2
                    }
                } // row
                HorizontalDivider {}
                LabelSubheading {
                    leftPadding: 10
                    text: qsTr("Sessions")
                    color: primaryColor
                }
                HorizontalDivider{
                    visible: speaker.sessionsPropertyList.length
                }

                Repeater {
                    model: speaker.sessionsPropertyList

                    ColumnLayout {
                        Layout.fillWidth: true
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: 16
                            Layout.rightMargin: 6

                            ColumnLayout {
                                Layout.fillWidth: true

                                LabelSubheading {
                                    text: modelData.title
                                    font.bold: true
                                    wrapMode: Label.WordWrap
                                }

                                LabelBody {
                                    text: modelData.subtitle
                                    wrapMode: Label.WordWrap
                                }
                            } // col in row
                        } // row
                        HorizontalListDivider{}
                    } // rep col
                } // repeater


            } // col layout
        } // root







        ScrollIndicator.vertical: ScrollIndicator { }
    } // flickable
    // emitting a Signal could be another option
    Component.onDestruction: {
        cleanup()
    }

    // called immediately after Loader.loaded
    function init() {
        console.log(qsTr("Init done from SpeakerDetailPage"))
    }
    // called from Component.destruction
    function cleanup() {
        console.log(qsTr("Cleanup done from SpeakerDetailPage"))
    }

} // carPage
