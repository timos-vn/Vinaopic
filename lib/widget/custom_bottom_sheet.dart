import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/models/network/response/info_store_response.dart';


Widget buildBottomStoreWidget(BuildContext context,List<InfoStoreResponseData> listStore) {
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter stateSetter) {
        return ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index)=>Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,),
              child: Divider(),
            ),

            itemBuilder: (BuildContext context, int index){
              return InkWell(
                onTap: ()=> Navigator.pop(context,[index,listStore[index].storeName.toString(),listStore[index].storeId.toString()]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0,right: 10),
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(listStore[index].storeName?.toString()??'',style: TextStyle(color: blue.withOpacity(0.5)),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                        Text(listStore[index].storeId?.toString()??'',style: TextStyle(color: blue.withOpacity(0.5)),),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: listStore.length
        );
      });
}

Widget buildBottomPhieuWidget(BuildContext context,List<String> listName) {
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter stateSetter) {
        return ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index)=>Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,),
              child: Divider(),
            ),

            itemBuilder: (BuildContext context, int index){
              return InkWell(
                onTap: ()=> Navigator.pop(context,[index,listName[index].toString()]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0,right: 10),
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(listName[index].toString(),style: TextStyle(color: blue.withOpacity(0.5)),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: listName.length
        );
      });
}

Widget buildBottomSexWidget(BuildContext context,List<String> listName) {
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter stateSetter) {
        return ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index)=>Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,),
              child: Divider(),
            ),

            itemBuilder: (BuildContext context, int index){
              return InkWell(
                onTap: ()=> Navigator.pop(context,[index,listName[index].toString()]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0,right: 10),
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(listName[index].toString(),style: TextStyle(color: blue.withOpacity(0.5)),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: listName.length
        );
      });
}