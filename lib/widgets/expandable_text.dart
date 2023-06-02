import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    //kiểm tra độ dài của đoạn text
    if(widget.text.length > textHeight){
      //Cắt đoạn văn bản từ 0 đến độ trộng của textHeight
      firstHalf = widget.text.substring(0,textHeight.toInt());
      //lấy nội dung còn lại của đoạn văn bản đã bị cắt
      secondHalf = widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ?SmallText(
            text: firstHalf, size: Dimensions.font16, color: AppColors.paraColor,)
          :Column(
        children: [
          SmallText(
            text: hiddenText?("$firstHalf..."):(firstHalf + secondHalf),
            size: Dimensions.font16,
            color: AppColors.paraColor,
          ),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(
                  text: hiddenText? "Show more" : "Show less", color: AppColors.mainColor,
                ),
                Icon( hiddenText
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                  color: AppColors.mainColor,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
