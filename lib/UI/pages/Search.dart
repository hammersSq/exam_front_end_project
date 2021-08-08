
import 'package:flutter/material.dart';
import 'package:front_end_project/UI/widgets/CircularIconButton.dart';
import 'package:front_end_project/UI/widgets/InputField.dart';
import 'package:front_end_project/UI/widgets/ProductCard.dart';
import 'package:front_end_project/model/Model.dart';
import 'package:front_end_project/model/objects/Product.dart';


class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);



  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _searching = false;
  List<Product> _products;

  TextEditingController _searchFiledController = TextEditingController();

  bool _category=false;
  int _pageSize=4;
  int _pageNumber=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            top(),
            bottom(),
          ],
        ),
      ),
    );
  }

  Widget top() {
    int pageNumberG=_pageNumber+1;
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

      child: Row(
        children: [
          Flexible(
            child: InputField(
              labelText: "search",
              controller: _searchFiledController,
              onSubmit: (value) {
                _search();
              },
            ),
          ),
          Column(
          children:[
            Row(
              children: [
                CircularIconButton(
                  icon: Icons.search_rounded,
                  onPressed: () {
                    _pageNumber=0;
                    _search();
                  },
                ),
                RawMaterialButton(
                    onPressed: (){_pageNumber=0;searchByCategory();},
                    child: Padding(padding: EdgeInsets.all(10),child: Text("Categoria"),),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: Theme.of(context).buttonColor,
                    padding: EdgeInsets.all(15.0),
                )

              ],
            ),
            Text("$pageNumberG", style: TextStyle(color: Theme.of(context).primaryColor),),
            Row(
              children: [
                RawMaterialButton(onPressed:(){previousPage();},child: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor,),),
                RawMaterialButton(onPressed:(){nextPage();},child: Icon(Icons.arrow_forward,color: Theme.of(context).primaryColor),)
              ],
            )
            ]
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    if(!_searching){
      if(_products==null)
        return SizedBox.shrink();
      else if(_products.length==0)
        return noResults();
      else
        return yesResults();
    }
    else
      return CircularProgressIndicator();
  }

  Widget noResults() {
    return Expanded(
      child: Text(
        "Nessun Risultato",
        style: TextStyle(
          fontSize: 50,
          color: Theme.of(context).primaryColor,

        ),
      ),
    );
  }

  Widget yesResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: _products[index],
            );
          },
        ),
      ),
    );
  }

  void searchByCategory(){
    setState(() {
      _category=true;
      _searching = true;
      _products = null;
    });
    Model.sharedInstance.searchProductbyCateogry(_searchFiledController.text,_pageNumber,_pageSize,"id").then((result) {
      setState(() {
        _searching = false;
        if(result!=null)
          _products = result;
        else
          _products=List();
      });
    });

  }
  void _search() {
    setState(() {
      _category=false;
      _searching = true;
      _products = null;
    });
    Model.sharedInstance.searchProductbyName(_searchFiledController.text,_pageNumber,_pageSize,"id").then((result) {
      setState(() {
        _searching = false;
        if(result!=null)
          _products = result;
        else
          _products=List();;
      });
    });
  }

  void nextPage(){
    setState(() {
      if(_products.length==_pageSize)
        _pageNumber++;
      if(_category)
        searchByCategory();
      else
        _search();
    });
  }
  void previousPage(){
    setState(() {
      if(_pageNumber>0)
        _pageNumber--;
      if(_category)
        searchByCategory();
      else
        _search();
    });
  }


}
