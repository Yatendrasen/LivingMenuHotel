import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Constants/appFontSizes.dart';

class BookingDateTimeScreen extends StatefulWidget {
  const BookingDateTimeScreen({super.key});

  @override
  State<BookingDateTimeScreen> createState() => _BookingDateTimeScreenState();
}

class _BookingDateTimeScreenState extends State<BookingDateTimeScreen> {
  late double w,h;
  List<DateTime> _selectedDates = [];

  final ScrollController _scrollController = ScrollController();
  List<String> _timeSlots = [];
  String? _selectedTime;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _selectedDates = args.value; // ✅ Stores selected dates
    });
  }

  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
  }

  void _generateTimeSlots() {
    DateTime now = DateTime.now();
    DateTime startTime = DateTime(now.year, now.month, now.day, 0, 0); // Start from 12:00 AM
    DateTime endTime = DateTime(now.year, now.month, now.day, 23, 59); // End at 11:59 PM

    while (startTime.isBefore(endTime)) {
      _timeSlots.add(DateFormat.jm().format(startTime)); // Formats as '12:00 AM'
      startTime = startTime.add(Duration(minutes: 30)); // Add 30 minutes
    }
  }


  void _showDatePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Dates"),
          content: Container(
            height: 400,
            width: 350,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.multiple, // ✅ Allows multiple selection
              onSelectionChanged: _onSelectionChanged,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h * 0.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.05, top: h * 0.01, bottom: h * 0.01, right: w * 0.05),
                    child: SvgPicture.asset('assets/icons/arrow_back.svg'),
                  ),
                ),
              ),
              Text('Choose Date & Time',
                style: TextStyle(
                  fontFamily: 'Inter_medium',
                  fontWeight: FontWeight.w700,
                  fontSize: fontSizes.fontSize14,
                  color: Colors.black
                ),
              ),
              Container(
                width: w * 0.1,
              ),
            ],
          ),
          SizedBox(height: h * 0.01,),
          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFE3E4E4),
          ),
          SizedBox(height: h * 0.015,),
          Padding(
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/icons/button_control_left.svg'),
                Text('November 2025',
                  style: TextStyle(
                    fontSize: fontSizes.fontSize15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter_medium',
                    color: Colors.black
                  ),
                ),
                SvgPicture.asset('assets/icons/button_control_right.svg')
              ],
            ),
          ),

          Container(
            height: h * 0.3,
            width: w,
            child: SfDateRangePicker(
              backgroundColor: Colors.white,
              selectionMode: DateRangePickerSelectionMode.multiple, // ✅ Allows multiple selection
              onSelectionChanged: _onSelectionChanged,
            ),
          ),
          SizedBox(height: h * 0.015,),
          Container(
            width: w,
            height: h * 0.01,
            color: Color(0xFFE3E4E4),
          ),
          SizedBox(height: h * 0.015,),
          Padding(
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('From',
                  style: TextStyle(
                      fontSize: fontSizes.fontSize15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter_bold',
                      color: Colors.black
                  ),
                ),
                SizedBox(height: h * 0.005,),
                Text('Nov 10, 2025',
                  style: TextStyle(
                      fontSize: fontSizes.fontSize15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter_light',
                      color: Colors.black
                  ),
                ),
                SizedBox(height: h * 0.015,),
                Container(
                  height: h * 0.05, // Fixed height for horizontal list
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal, // ✅ Horizontal scrolling
                    itemCount: _timeSlots.length,
                    itemBuilder: (context, index) {
                      String time = _timeSlots[index];
                      bool isSelected = _selectedTime == time;
                      return _buildTimeSloItems(time, isSelected, fontSizes);
                    },
                  ),
                ),
                SizedBox(height: h * 0.01,),
                Scrollbar(
                  controller: _scrollController, // Attach controller
                  thickness: 6, // Customize thickness
                  radius: Radius.circular(10), // Rounded scrollbar
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Container(
                      height: 10, // Height of scrollbar
                      width: _timeSlots.length * 60, // Adjust based on content width
                      color: Colors.transparent, // Background color of scrollbar track
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSloItems(String time, bool isSelected, AppFontSizes fontSizes){
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTime = time;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w * 0.01),
        padding: EdgeInsets.only(left: w * 0.1, right: w * 0.1),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFE0EDFF) : Color(0xFFF6F7F9), // Highlight selected time
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Color(0xFF3348FF) : Color(0xFFF6F7F9)
          )
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              fontSize: fontSizes.fontSize15,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter_light',
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

}
