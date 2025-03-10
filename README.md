# FortiSOAR Compatiable Contenthub Builder

## Instruction

### Compress Connector Folder

Place folder/file structure as below.

some_folder/
├─ connector-sample-connector/
│  ├─ connector/
│  │  ├─ info.json
│  │  ├─ connector.py
│  │
│  ├─ README.md
│
├─ build_connector.py

use command below to trigger the compression in macos.

``` shell
cd some_folder
python build_connector -i connector-sample-connector
```

### Compress Widget Folder

Place folder/file structure as below.

some_folder/
├─ widget-sample-widget/
│  ├─ widget/
│  │  ├─ info.json
│  │  ├─ edit.html
│  │
│  ├─ README.md
│
├─ build_widget.py

use command below to trigger the compression in macos.

``` shell
cd some_folder
python build_widget -i widget-sample-widget
```
