List<String> historyRetriever(Map<String,List> data){
  List<String> result=[];
  int? count=data["manipulate"]?.where((element) => element==0).length;
  if(count==data["manipulate"]?.length){
    return ["History is Clear!!"];
  }
  for(int i=0;i<(data["players"]?.length)!;i++){
    for(int j=i+1;j<(data["players"]?.length)!;j++){
      if(data["manipulate"]![i] & (1<<j) == (1<<j)) {
        result.add("${data["players"]![i]},${data["players"]![j]}");
      }
    }
  }
  if((data["coupling"]?.isNotEmpty)!){
    for(int i=0;i<(data["players"]?.length)!;i++){
      if(data["coupling"]![i]!=0){
        result.add(data["players"]![i]);
      }
    }
  }
  return result;
}