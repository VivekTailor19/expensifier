import 'package:expensifier/controller/expensifier_Controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {

  ExpensifierController control = Get.put(ExpensifierController());

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

       body: SingleChildScrollView(
         child: Padding(
           padding:  EdgeInsets.symmetric(horizontal: 3.w),
           child: Column(
             children: [
               SizedBox(height: 2.h,),

               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [

                   GestureDetector(
                     onTap: () {

                     },
                     child: Container(height: 4.h,width: 25.w,
                     alignment: Alignment.center,
                     child: Row(mainAxisSize: MainAxisSize.min,
                       children: [
                         Icon(Icons.keyboard_arrow_down_rounded,size: 20.sp,color: Color(0xff7F3DFF),),
                         Text("Month",style: TextStyle(fontWeight: FontWeight.w400),),
                       ],
                     ),
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.w),
                     border: Border.all(color: Colors.black12,width: 0.5)),),
                   ),

                   GestureDetector(
                     onTap:  () {
                       Get.bottomSheet(
                         isScrollControlled: true,
                           Container(
                             height: 60.h,width: 100.w, decoration: BoxDecoration(color: Colors.white,
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(8.w),topRight: Radius.circular(8.w))),
                             child: Padding(
                               padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 3.h),
                               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                   Text("Filter Transaction",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp),),
                                   GestureDetector(
                                     onTap: () async {
                                       control.selectedIndexFilterBy.value = -1;
                                       control.selectedFilterBy.value = "";
                                       control.selectedIndexSortBy.value = -1;
                                       control.selectedSortBy.value = "";
                                       control.selectedIndexCategory.value = -1;
                                       control.selectedFilterCategory.value = "";

                                       await control.load_ExpensifierDB();
                                     },
                                     child: Container(height: 4.h,width: 20.w,alignment:Alignment.center,
                                       decoration: BoxDecoration(color: Colors.indigo.shade100,borderRadius: BorderRadius.circular(2.h)),

                                       child:Text("Reset",style: TextStyle(color: Colors.indigo,fontSize: 14.sp,fontWeight: FontWeight.w300),),),
                                   )
                                 ],),

                                 Padding(
                                   padding: EdgeInsets.symmetric(vertical: 1.h),
                                   child: Text("Filter By",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                 ),

                                      SizedBox(height:5.h,
                                         child: ListView.builder(
                                           scrollDirection: Axis.horizontal,
                                           itemCount: control.filterByList.length,
                                           itemBuilder: (context, index) {

                                             // control.selFilterByColorText.value = Colors.amber ;
                                         // control.selFilterByColorBox.value = Colors.white ;
                                         // if(control.selectedIndex.value == control.filterByList[index])
                                         // {
                                         //   control.selFilterByColorText.value =  Colors.white;
                                         //   control.selFilterByColorBox.value = Colors.yellow;
                                         // }

                                         return  GestureDetector(
                                               onTap: () {
                                                 control.selectionFilterBy(index);

                                                 // print("selected filterby  === ${control.selectedFilterBy.value}");
                                                 // print("color text == >> ${control.selFilterByColorText}");
                                                 // print("index = $index");
                                               },
                                               child: Obx(
                                                 () =>  Container(height: 5.h,width: 25.w,margin: EdgeInsets.only(right: 5.w),
                                                       alignment:Alignment.center,
                                                       decoration: BoxDecoration(color: control.selectedIndexFilterBy.value == index ? Color(0xffEEE5FF) : Color(0xffffffff),
                                                           borderRadius: BorderRadius.circular(2.5.h),border: Border.all(color: Colors.black12)),

                                                       child: Text("${control.filterByList[index]}",style: TextStyle(color: control.selectedIndexFilterBy.value == index ? Color(0xff7F3DFF) :Color(0xff0D0E0F),fontSize: 14.sp,fontWeight: FontWeight.w300),),),
                                               ),

                                         );
                                       },
                                     ),
                                   ),

                                 Padding(
                                     padding: EdgeInsets.symmetric(vertical: 1.h),
                                     child: Text("Sort By",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.sp),)),

                                      SizedBox(height:10.h,
                                     child: GridView.builder(
                                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 3,),


                                       itemCount: control.sortByList.length,
                                       itemBuilder: (context, index) {

                                         // control.selFilterByColorText.value = Colors.amber ;
                                         // control.selFilterByColorBox.value = Colors.white ;
                                         // if(control.selectedIndex.value == control.filterByList[index])
                                         // {
                                         //   control.selFilterByColorText.value =  Colors.white;
                                         //   control.selFilterByColorBox.value = Colors.yellow;
                                         // }

                                         return  GestureDetector(
                                           onTap: () {
                                             control.selectionSortBy(index);
                                           },
                                           child: Obx(
                                                 () =>  Padding(
                                                   padding: EdgeInsets.only(bottom: 1.w),
                                                   child: Container(
                                                     height: 5.h,width: 25.w,margin: EdgeInsets.only(right: 5.w),
                                                     alignment:Alignment.center,
                                                     decoration: BoxDecoration(color: control.selectedIndexSortBy.value == index ? Color(0xffEEE5FF) : Color(0xffffffff),
                                                         borderRadius: BorderRadius.circular(2.5.h),border: Border.all(color: Colors.black12)),

                                                     child: Text("${control.sortByList[index]}",style: TextStyle(color: control.selectedIndexSortBy.value == index ? Color(0xff7F3DFF) :Color(0xff0D0E0F),fontSize: 14.sp,fontWeight: FontWeight.w300),),),
                                                 ),
                                           ),




                                         );
                                       },
                                     ),
                                   ),

                                 Padding(
                                   padding: EdgeInsets.symmetric(vertical: 1.h),
                                   child: Text("Category",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                 ),

                                       SizedBox(height:12.h,
                                          child: GridView.builder(
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 3,),

                                            itemCount: control.categoryList.length,
                                            itemBuilder: (context, index) {

                                              return  GestureDetector(
                                                onTap: () {
                                                  control.selectionCategory(index);
                                                },
                                                child: Obx(() =>  Padding(
                                                            padding: EdgeInsets.only(bottom: 1.w),
                                                            child: Container(
                                                              height: 5.h,width: 30.w,margin: EdgeInsets.only(right: 2.w),
                                                              alignment:Alignment.center,
                                                              decoration: BoxDecoration(color: control.selectedIndexCategory.value == index ? Color(0xffEEE5FF) : Color(0xffffffff),
                                                                  borderRadius: BorderRadius.circular(2.5.h),border: Border.all(color: Colors.black12)),

                                                              child: Text("${control.categoryList[index]}",style: TextStyle(color: control.selectedIndexCategory.value == index ? Color(0xff7F3DFF) :Color(0xff0D0E0F),fontSize: 12.sp,fontWeight: FontWeight.w300),),),
                                                          ),
                                                      ),

                                              );
                                            },
                                          ),
                                        ),


                                 GestureDetector(
                                   onTap: () async {

                                     if(control.selectedFilterBy == "" && control.selectedFilterCategory == "" )
                                       {
                                         await control.load_ExpensifierDB();
                                       }
                                     else
                                       {
                                         control.load_FilteredDB(
                                             cate:control.selectedFilterCategory.value,
                                             filterBy: control.selectedFilterBy.value
                                         );
                                       }

                                    Get.back();
                                   },
                                   child: Container(height: 7.h,width: 100.w,alignment: Alignment.center,
                                       padding: EdgeInsets.symmetric(horizontal: 5.w),
                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w),
                                           color: Color(0xff7F3DFF),
                                           border: Border.all(color: Colors.black12)),
                                       child: Text("Apply",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17.sp,color: Colors.white),),
                                     ),
                                 )

                               ],),
                             ),
                       ),
                           backgroundColor: Colors.transparent,
                       );
                     },
                     child: Container(height: 4.5.h,width: 5.h,
                     alignment: Alignment.center,
                     child: Icon(Icons.filter_list_rounded,size: 20.sp,color: Color(0xff7F3DFF)),
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w),
                     border: Border.all(color: Colors.black12,width: 0.5)),),
                   ),
                 ],
               ),

               Container(height: 5.h,width: 100.w,
                 alignment: Alignment.center,
                 padding: EdgeInsets.all(3.w),
                 margin: EdgeInsets.symmetric(vertical:2.h),
                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("See your financial report",style: TextStyle(color:Color(0xff7F3DFF)),),
                     Icon(Icons.arrow_forward_ios_rounded,size: 16.sp,color: Color(0xff7F3DFF)),
                   ],
                 ),
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.5.w),color: Color(0xffEEE5FF),
                     ),),


               Obx(
                 () =>  ListView.builder(
                   itemCount: control.filterList.length,
                   reverse: true,
                   shrinkWrap:true,
                   physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (context, index) {
                     control.selCategoryTab(control.filterList[index]['category']);

                     return InkWell(

                       onTap: () {

                         print("click transaction item");

                         Get.toNamed("/update",arguments: {"index":index});
                       },

                       child: ItemListTile(
                         amount: control.filterList[index]['amount'],
                         status: control.filterList[index]['status'],
                         category: control.filterList[index]['category'],
                         paymentType: control.filterList[index]['paymentType'],
                         categoryImg: control.selCategoryImgPath.value,
                         categoryColor: control.selCategoryBg.value
                       ),
                     );
                   },),
               ),
             ],
           ),
         ),
       )
      ),
    );
  }

  Widget ItemListTile({category,paymentType,amount,time,categoryImg,categoryColor,status})
  {
    return  Container(height: 8.h,width: 100.w,
        margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.5.h),
        padding: EdgeInsets.symmetric(horizontal: 1.5.w,),
        child: Row(
          children: [
            Container(height: 8.h,width: 8.h,
              alignment: Alignment.center,
              child: Image.asset("$categoryImg",height: 5.h,),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w),color: categoryColor),),
            SizedBox(width: 3.w,),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$category",style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),),
                      Text(status=='Income'?" \$ $amount":"- \$ $amount",style: TextStyle(color: status=='Income'?Colors.green:Colors.red),)
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$paymentType"),
                      Text("10.00 AM")
                    ],
                  ),

                ],),
            ),

          ],
        ),
      );
  }

}
