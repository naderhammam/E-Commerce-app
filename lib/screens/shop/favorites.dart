import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/favorites_model.dart';

import '../../cubit_shop/cubit_shop.dart';
import '../../cubit_shop/states_shop.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return (ShopCubit.get(context).favoriteModel!.data!.dataP!.length != 0)
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => BuildFavItem(
                    ShopCubit.get(context).favoriteModel!.data!.dataP![index],
                    context),
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                ),
                itemCount:
                    ShopCubit.get(context).favoriteModel!.data!.dataP!.length,
              )
            : const Center(
                child: Text(
                '♻  No Favorites  ♻',
                style: TextStyle(
                  fontSize: 25,
                ),
              ));
      },
    );
  }

  Widget BuildFavItem(DataP model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.product!.image}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (model.product!.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Text('DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 8)),
                  )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.product!.name}',
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price!.round()}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      if ( model.product!.discount != 0)
                        Text(
                          '${model.product!.oldPrice!.round()}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .ChangeFavorite(model.product!.id!);
                          //print('${model.id}');
                        },
                        icon: CircleAvatar(
                            backgroundColor: ShopCubit.get(context)
                                    .favorite[model.product!.id]!
                                ? Colors.red
                                : Colors.grey.withOpacity(0.9),
                            radius: 16,
                            child: const Icon(Icons.favorite_border,
                                color: Colors.white, size: 17)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
