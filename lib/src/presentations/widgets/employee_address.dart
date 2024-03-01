import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tarek_test_app/src/core/utils/functions.dart';
import 'package:tarek_test_app/src/presentations/component/button.dart';
import 'package:tarek_test_app/src/presentations/component/loading.dart';
import 'package:tarek_test_app/src/presentations/cubits/database_cubit/database_cubit.dart';

class EmployeeAddress extends StatefulWidget {
  const EmployeeAddress({
    super.key,
  });

  @override
  State<EmployeeAddress> createState() => _EmployeeAddressState();
}

class _EmployeeAddressState extends State<EmployeeAddress> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  String city = '';
  var formKey = GlobalKey<FormState>();
  final LatLng initialCameraPosition = const LatLng(
    25.405222303717462,
    55.508230770593535,
  );
  late GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 2,
            title: const Text(
              'Pick Employee Address',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  textDirection: TextDirection.rtl,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: getScreenHeight(context) / 1.5,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: initialCameraPosition,
                          zoom: 15.0,
                        ),
                        onMapCreated: onMapCreated,
                        myLocationEnabled: true,
                        buildingsEnabled: true,
                        onTap: (LatLng latLng) async {
                          setState(() async {
                            city = await cubit.convertPosToReality(latLng);
                            cubit.setCity(city);
                          });
                          // print(city.text.toString());
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    state is GetEmployeesLocationLoadingState
                        ? const DefaultLoading()
                        : InkWell(
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Your City',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                cubit.city.text,
                                style: const TextStyle(
                                  color: Color(0xFF192747),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DefaultButton(
                        function: () {
                          if (cubit.city.text.isNotEmpty) {
                            popScreen(context);
                            cubit.setCity(city);
                          }
                        },
                        text: 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onMapCreated(GoogleMapController googleMapController) {
    controller = googleMapController;
  }
}
