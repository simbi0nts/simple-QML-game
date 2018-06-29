import QtQuick 2.7		//ApplicationWindow
import QtQuick.Controls 2.1	//Dialog

ApplicationWindow {
	id: window

	visible: true
	title: "Simple QML game"

	property int con_X: 5
	property int con_Y: 5

	minimumWidth: 50 * con_X + 20
	minimumHeight: 50 * con_Y + 10

	function checkIfWin(pcc) {
		for (var y = 0; y < con_Y; y++) {
			var _pcc = pcc[y].children[0]
			for (var x = 0; x < con_X; x++) {
				if (_pcc.children[x].children[0].text == 'x') return
			}
		}
		win_dialog.open()
	}

	function changeXO(orig_x, orig_y, parent){
		var pc = parent.children

		for (var x = 0; x < con_X; x++) {
			var pc_ci = pc[x].children[0]
			pc_ci.text = pc_ci.text=='x' ? 'o' : 'x'
			pc_ci.color = pc_ci.text=='x' ? "#ff0000" : "#008B00"
		}

		var pcc = parent.parent.parent.children

		for (var y = 0; y < con_Y; y++) {
			var pcc_ci = pcc[y].children[0].children[orig_x].children[0]
			if (y != orig_y){
				pcc_ci.text = pcc_ci.text=='x' ? 'o' : 'x'
				pcc_ci.color = pcc_ci.text=='x' ? "#ff0000" : "#008B00"
			}
		}

		checkIfWin(pcc)

	}

	Repeater{
		model: con_Y

		Column {
			x: 10
			y: 50 * index

			Row {
				property int btnY: index

				Repeater {
					model: con_X
					property int btnY: parent.btnY

					Button{
					    property int btnX: index
					    property int btnY: parent.btnY
					    width: 50
	        			height: 60

						Text {
            					anchors.centerIn: parent
            					font.pixelSize: 25
						        text: Math.round(Math.random()) ? 'x' : 'o'
						        color: text=='x' ? "#ff0000" : "#008B00"
						}

					    onClicked: changeXO(btnX, btnY, parent)
					}
				}
			}
		}
	}

	Dialog {
		id: win_dialog

		x: (window.width - width) * 0.5
		y: (window.height - height) * 0.5

		contentWidth: window.width * 0.5
		contentHeight: window.height * 0.25
		standardButtons: Dialog.Ok

		 Text {
            anchors.centerIn: parent
			text: "You win!"
		}
	}
}
