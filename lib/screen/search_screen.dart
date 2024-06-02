
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/screen/details_product_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var Search = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).search=[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          var cubit =AppCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          elevation: 0.0,),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: Search,
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: (){
                      cubit.getSearchProduct(text: Search.text);
                    },
                    icon: Icon(Icons.search),
                  ),
                  contentPadding:const  EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(color: Colors.blue,width: 5),
                  ),
                ),
                onFieldSubmitted: (val){
                  cubit.getSearchProduct(text: val);

                },
              ),
              SizedBox(height: 20,),

              (state is LoadingGetAllUser)?
              Center(child: CircularProgressIndicator(),):
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1/1.3,
                        mainAxisSpacing: 20
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:cubit.search.length ,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ProductDetailsScreen(productModel: cubit.search[index],);
                          }));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(cubit.search[index].image??'',
                                      width: double.infinity,
                                      fit: BoxFit.fill,)),
                              ),
                              const SizedBox(height: 10,),
                              Text(cubit.search[index].name??'',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      fontFamily: 'KantumruyPro'
                                  ),textAlign: TextAlign.center),
                              const SizedBox(height: 10,),
                              Text('Price : ${cubit.search[index].price??''} EGP',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      fontFamily: 'KantumruyPro'
                                  ),textAlign: TextAlign.center),
                              const SizedBox(height: 10,),
                              Text('Rate : ${cubit.search[index].rate??''}',
                                  style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      fontFamily: 'KantumruyPro'
                                  ),textAlign: TextAlign.center),


                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
