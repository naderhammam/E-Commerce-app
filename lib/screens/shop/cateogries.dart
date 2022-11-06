import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit_shop/cubit_shop.dart';
import 'package:shop_app/model/categories_model.dart';

import '../../cubit_shop/states_shop.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder:(context, index) => _buildItem(ShopCubit.get(context).categoriesModel!.data!.data[index]) ,
        separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
            ),
        itemCount:  ShopCubit.get(context).categoriesModel!.data!.data.length,
    );
  },
);
  }
  Widget _buildItem(DataModel data) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:  [
          Image(
            image: NetworkImage(
                '${data.image}'),
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${data.name}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            size: 25,
            color: Colors.black,
          ),

        ],
      ),
    );
  }
}
