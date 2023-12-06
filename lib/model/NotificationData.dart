class NotificationClass {
   int id;
   String title;
   String detail;
   DateTime time;

  NotificationClass({required this.id,required this.detail,required this.time,required this.title}); 

  NotificationClass.fromSnapShot(Map<Object?,Object?> js):
    id=int.parse( js["id"].toString()) ,
    title= js["title"].toString(),
    detail=js["detail"].toString(),
    time=DateTime.parse(js["time"].toString());

    toJson(){
      return{
        "id": id,
        "title":title,
        "detail":detail,
        "time":time
      };
    }
}