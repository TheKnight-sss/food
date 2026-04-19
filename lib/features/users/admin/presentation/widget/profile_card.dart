import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/orders/presentation/cubit/order_cubit.dart';
import 'package:food/features/orders/presentation/cubit/order_state.dart';
import 'package:gap/gap.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.txt,
    this.color,
    required this.asset,
    required this.isOk,
    required this.done,
  });

  final String txt;
  final Color? color;
  final String asset;
  final bool isOk;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 48,
          width: 48,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: (isOk == true)
                  ? SvgPicture.asset(
                      asset,
                      colorFilter: ColorFilter.mode(
                        color ?? AppColors.icon,
                        BlendMode.srcIn,
                      ),
                      height: 24,
                      width: 24,
                    )
                  : Image.asset(
                      asset,
                      color: color ?? AppColors.icon,
                      height: 24,
                      width: 24,
                    ),
            ),
          ),
        ),
        Gap(13),
        Text(txt, style: Style.regular),
        Spacer(),
        (done == true)
            ? Icon(Icons.arrow_forward_ios_sharp, color: AppColors.arrow)
            : BlocProvider(
                create: (context) => OrderCubit(),
                child: BlocConsumer<OrderCubit, OrderState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is OrderInitial) {
                      context.read<OrderCubit>().fetchAllOrdersCount();
                      return Text('Loading...');
                    }
                    if (state is OrdersLoaded) {
                      return Text(state.orders.length.toString());
                    }
                    if (state is OrderFailure) {
                      return Text('Error');
                    }
                    return Text('Loading...');
                  },
                ),
              ),
      ],
    );
  }
}
