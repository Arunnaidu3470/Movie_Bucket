import 'package:flutter/material.dart';

// custom tab bar
class CustomTabBar<T> extends StatefulWidget {
  final List<HeaderItem<T>> children;
  final void Function(int index, T value) onSelect;
  final Color selectedColor;
  final Color unSelectedColor;
  final ScrollController controller;

  CustomTabBar({
    Key key,
    @required this.children,
    this.onSelect,
    this.selectedColor,
    this.unSelectedColor,
    this.controller,
  }) : super(key: key);

  @override
  _CustomTabBarState<T> createState() => _CustomTabBarState<T>();
}

class _CustomTabBarState<T> extends State<CustomTabBar<T>> {
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        controller: widget.controller,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (_selectedItem != index) {
                setState(() => _selectedItem = index);
                if (widget.onSelect != null) {
                  widget.onSelect(index, widget.children[index].value);
                }
              }
            },
            child: HeaderItem<T>(
              label: widget.children[index].label,
              icon: widget.children[index].icon,
              backgroundColor: _selectedItem == index
                  ? widget.selectedColor ?? Colors.blue[800]
                  : widget.unSelectedColor ?? Colors.transparent,
              value: widget.children[index].value,
            ),
          );
        },
        itemCount: widget.children.length,
      ),
    );
  }
}

// Item for options
class HeaderItem<T> extends StatelessWidget {
  final String label;
  final Widget icon;
  final Color backgroundColor;
  final T value;
  const HeaderItem({
    Key key,
    this.label,
    this.icon,
    this.backgroundColor = Colors.transparent,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? Container(),
          SizedBox(width: 5),
          Text(label ?? '', style: Theme.of(context).primaryTextTheme.bodyText1)
        ],
      ),
    );
  }
}
