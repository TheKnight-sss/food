import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/components/buttons/main_button.dart';
import 'package:food/components/inputs/custom_text_field.dart';
import 'package:food/core/functions/show_dialog.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/food/presentation/cubit/product_cubit.dart';
import 'package:food/features/food/presentation/cubit/product_state.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
    const AddItemScreen({super.key,});

  


  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  File? productImage;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductCubit>();
    return Scaffold(
      body: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductLoading) {
            showLoadingDialog(context);
          } else if (state is ProductAdded) {
            Navigator.pop(context);
            showMyDialog(
              context,
              "Item added successfully",
              type: Dialogs.success,
            );
            pushwithReplacement(context, Routes.admindashboard);
          } else if (state is AddItemError) {
            Navigator.pop(context);
            showMyDialog(context, state.message, type: Dialogs.error);
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 23),
          child: Form(
            key: cubit.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(24),
                Row(
                  children: [
                    Container(
                      width: 57,
                      height: 57,
                      decoration: BoxDecoration(
                        color: AppColors.accentcolor4,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ),
                    Gap(16),
                    Text(
                      "Add New Items",
                      style: Style.title.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Gap(24),
                Row(children: [Text("ITEM NAME", style: Style.title)]),
                Gap(8),
                CustomTextField(
                  hint: "Enter Item Name",
                  controller: cubit.nameController,
                ),
                Gap(16),
                Text("UPLOAD PHOTO", style: Style.title),
                Gap(8),
                GestureDetector(
                  onTap: () => uploadImages(isCamera: false),
                  child: Container(
                    height: 110,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.accentcolor4,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.cloud_upload_outlined,
                      color: AppColors.darkColor,
                    ),
                  ),
                ),
                Row(children: [Text("ITEM PRICE", style: Style.title)]),
                Gap(8),
                CustomTextField(
                  hint: "Enter Item Price",
                  controller: cubit.priceController,
                ),
                Row(children: [Text("ITEM Category", style: Style.title)]),
                Gap(8),
                DropdownMenu<String>(
                  hintText: "Select Item Category",
                  width: double.infinity,
                  onSelected: (value) {
                  cubit.categController.text = value ?? '';
                  },
                  dropdownMenuEntries: [
                  DropdownMenuEntry(value: 'Pizza', label: 'Pizza'),
                  DropdownMenuEntry(value: 'Drink', label: 'Drink'),
                  DropdownMenuEntry(value: 'Sandwich', label: 'Sandwich'),
                  DropdownMenuEntry(value: 'Burger', label: 'Burger'),
                  ],
                ),
                Gap(16),
                Row(children: [Text("ITEM DESCRIPTION", style: Style.title)]),
                Gap(8),
                CustomTextField(
                  hint: "Enter Item Description",
                  controller: cubit.descController,
                ),
                Spacer(),
                CustomButton(txt: "Save Changes", onpressed: (){
                  cubit.addItem(productImage!);
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> uploadImages({required bool isCamera}) async {
    XFile? pickedfile = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedfile != null) {
      setState(() {
        productImage = File(pickedfile.path);
      });
    }
  }
}
