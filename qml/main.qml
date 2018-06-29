import QtQuick 2.7			//ApplicationWindow
import QtQuick.Controls 2.1	//Dialog

ApplicationWindow {
	id: window

	visible: true
	title: "Simple QML game"
	minimumWidth: 320
	minimumHeight: 270

	function checkIfWin(pcc) {
		for (var y = 0; y < 5; y++) {
			var _pcc = pcc[y].children[0]
			for (var x = 0; x < 5; x++) {
				if (_pcc.children[x].contentItem.text == 'x') return
			}
		}
		win_dialog.open()
	}

	function changeXO(orig_x, orig_y, parent){
		var pc = parent.children

		for (var x = 0; x < 5; x++) {
			var pc_ci = pc[x].contentItem
			pc_ci.text = pc_ci.text=='x' ? 'o' : 'x'
			pc_ci.color = pc_ci.text=='x' ? "#ff0000" : "#008B00"
		}

		var pcc = parent.parent.parent.children

		for (var y = 0; y < 5; y++) {
			var pcc_ci = pcc[y].children[0].children[orig_x].contentItem
			if (y != orig_y){
				pcc_ci.text = pcc_ci.text=='x' ? 'o' : 'x'
				pcc_ci.color = pcc_ci.text=='x' ? "#ff0000" : "#008B00"
			}
		}

		checkIfWin(pcc)

	}

	Repeater{
		model: 5

		Column {
			x: 10
			y: 50 * index

			Row {
				property int btnY: index

				Repeater {
					model: 5
					property int btnY: parent.btnY

					Button{
					    property int btnX: index
					    property int btnY: parent.btnY
					    width: 60
	        			height: 60

						contentItem: Text {
						        text: 'x'
						        color: "#ff0000"
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
