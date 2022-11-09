import 'package:apms_mobile/bloc/repositories/user_location_repo.dart';
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
  final UserLocationBloc _userLocationBloc =
      UserLocationBloc(UserLocationProvider());

  @override
  void initState() {
    _userLocationBloc.add(GetUserLocation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUserLocation(context);
  }

  Widget _buildUserLocation(context) {
    return BlocProvider(
        create: (_) => _userLocationBloc,
        child: BlocListener<UserLocationBloc, UserLocationState>(
            listener: (context, state) {
              if (state is UserLocationFetchedFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Failed"),
                  ),
                );
              }
            },
            child: BlocBuilder<UserLocationBloc, UserLocationState>(
              builder: ((context, state) => AppBar(
                    title: state is UserLocationFetchedSuccessfully
                        ? Text(state.userPlacemark[0].street! +
                            ", " +
                            state.userPlacemark[0].country!)
                        : Text(""),
                  )),
            )));
  }
}
