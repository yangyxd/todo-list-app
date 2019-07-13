import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/utils/theme_util.dart';

class CustomIconWidget extends StatefulWidget {
  final IconData iconData;
  final Function onApplyTap;
  final Color pickerColor;
  final ValueChanged<String> onTextChange;

  CustomIconWidget(
      {this.iconData,
      this.onApplyTap,
      this.pickerColor, this.onTextChange,})
      : assert(iconData != null),
        assert(onApplyTap != null),
        assert(onTextChange != null),
        assert(pickerColor != null);

  @override
  _CustomIconWidgetState createState() => _CustomIconWidgetState();
}

class _CustomIconWidgetState extends State<CustomIconWidget> {
  final List<Color> defaultColors = [
    MyThemeColor.blueGrayColor,
    MyThemeColor.darkColor,
    MyThemeColor.greenColor,
    MyThemeColor.purpleColor,
    MyThemeColor.cyanColor,
    MyThemeColor.coffeeColor,
    MyThemeColor.defaultColor,
  ];

  Color currentIconColor;
  int currentSelectIndex;

  @override
  void initState() {
    super.initState();
    currentIconColor = widget.pickerColor;
    currentSelectIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            width: 260,
            child: TextField(
              onChanged: (text) => widget.onTextChange(text),
              decoration: InputDecoration(
                hintText: DemoLocalizations.of(context).setIconName,
                prefixIcon: Icon(
                  widget.iconData,
                  color: currentIconColor,
                ),
              ),
              maxLength: 20,
              maxLines: 1,
            ),
          ),
          Row(
            children: List.generate(defaultColors.length, (index) {
              return InkWell(
                onTap: (){
                  setState(() {
                    currentSelectIndex = index;
                    currentIconColor = defaultColors[index];
                  });
                },
                child: Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: defaultColors[index],
                    border:currentSelectIndex == index ? Border.all(width: 2,color: Colors.black) : null,
                  ),
                ),
              );
            }),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      _showColorPicker(context);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 35,
                      width: 35,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.redAccent,
                            Colors.greenAccent,
                            Colors.blueAccent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: currentSelectIndex == 7
                            ? Border.all(color: currentIconColor, width: 4)
                            : null,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: Text(
                          DemoLocalizations.of(context).cancel,
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      child: Text(
                        DemoLocalizations.of(context).ok,
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: (){
                        widget.onApplyTap(currentIconColor);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  void _showColorPicker(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            elevation: 0.0,
            title: Text(DemoLocalizations.of(context).pickAColor),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: currentIconColor,
                onColorChanged: (color) {
                  currentIconColor = color;
                  currentSelectIndex = 7;
                },
                enableLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(DemoLocalizations.of(context).cancel,style: TextStyle(color: Colors.redAccent),),
                onPressed: ()  {
                  currentIconColor = widget.pickerColor;
                  currentSelectIndex = -1;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(DemoLocalizations.of(context).ok),
                onPressed: () {
                  setState(() {

                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}