import 'package:flutter/material.dart';

Widget ExamDetailForm(BuildContext context,
    {required int id,
      required String quiz_title,
    required int levelNumber,
    required String domain,
    required List<String> question,
    required int passing_score}) {
  return Container(
      decoration: const BoxDecoration(
        color:Color.fromARGB(236, 242, 250, 242)
      ),
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.height * 0.3,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration:const BoxDecoration(
                  color:Color.fromARGB(120, 36, 157, 65),
                   borderRadius:BorderRadius.all(Radius.circular(20)),
                ) ,
                height: 150,
                width: 270,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text("Quiz Title",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,10,0,10),
                    child: Text(quiz_title,overflow: TextOverflow.fade,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:Colors.white),softWrap: true),
                  )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Container(
                decoration:const BoxDecoration(
                  color:Color.fromARGB(120, 36, 157, 65),
                  borderRadius:BorderRadius.all(Radius.circular(20)),
                ) ,
                height: 150,
                width: 270,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text("Domain",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white))),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,10,0,10),
                      child: Text(domain,overflow: TextOverflow.fade,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:Colors.white),softWrap: true),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10,0,10,20),
              child: Container(
                decoration:const BoxDecoration(
                  color:Color.fromARGB(120, 36, 157, 65),
                  borderRadius:BorderRadius.all(Radius.circular(20)),
                ) ,
                height: 150,
                width: 270,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text("Passing Score",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white))),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,10,0,10),
                      child: Text("$passing_score",overflow: TextOverflow.fade,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:Colors.white,fontSize: 15),softWrap: true),
                    )
                  ],
                ),
              ),
            ),

            Container(
              decoration:const BoxDecoration(
                color:Color.fromARGB(120, 36, 157, 65),
                borderRadius:BorderRadius.all(Radius.circular(20)),
              ) ,
              height: 150,
              width: 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Text("Level",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,10,0,10),
                    child: Text("$levelNumber",overflow: TextOverflow.fade,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:Colors.white,fontSize: 15),softWrap: true),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:10,left: 10,right: 10),
              child: Container(
                height: 300,
                child: ListView.builder(
                    itemCount: question.length,
                    itemBuilder: (context,index){
                      return Container(

                        color:Colors.white,
                        child: ListTile(
                          leading: Text("${index+1}",style:Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black)),
                          title: Text(question[index],style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:Colors.black),),
                        ),
                      );

                }),
              ),
            )
          ],
        ),
      ));
}
