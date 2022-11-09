import 'package:apms_mobile/bloc/user_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationBar extends StatefulWidget implements PreferredSizeWidget {
  const CurrentLocationBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  State<CurrentLocationBar> createState() => _CurrentLocationBarState();
}

class _CurrentLocationBarState extends State<CurrentLocationBar> {
  final UserLocationBloc _userLocationBloc = UserLocationBloc();

  @override
  void initState() {
    _userLocationBloc.add(GetUserLocation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUserLocation();
  }

  Widget _buildUserLocation() {
    return BlocBuilder<UserLocationBloc, UserLocationState>(
        builder: ((context, state) => Scaffold(
              appBar: AppBar(
                title: state is UserLocationFetchedSuccessfully
                    ? Text(state.userLocation.longitude.toString())
                    : Text("Failed"),
              ),
            )));
  }
}
