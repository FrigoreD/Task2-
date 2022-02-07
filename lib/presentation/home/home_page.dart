import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/application/app/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/application/new_user_form/new_user_bloc.dart';
import 'package:task2/infrastructation/database.dart';
import 'package:task2/presentation/task_2_theme.dart';
import 'package:task2/presentation/user_form/user_form_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton(
            key: const Key('homePage_logout_TextButton'),
            child: Text(
              'Logout',
              style: textTheme.headline3,
            ),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          ),
        ],
      ),
      body: BlocProvider<NewUserBloc>(
        create: (_) => NewUserBloc(context.read<Database>()),
        child: Align(
          alignment: const Alignment(0, -3 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 300, child: ListOfUsers()),
              Text('email: ${user.email}', style: textTheme.headline5),
              const PasswordWidget(),
              const Button()
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid.toString();
    final textTheme = Theme.of(context).textTheme;
    return StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              'Something went wrong',
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          Object? doc = snapshot.data!.get('password');
          return Text(
            'password:  $doc',
            style: textTheme.headline5,
          );
        });
  }
}

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push<void>(UserFormPage.route());
        },
        child: const Text('Add user'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary: kPrimaryGreen,
        ));
  }
}

class ListOfUsers extends StatelessWidget {
  const ListOfUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final uid = FirebaseAuth.instance.currentUser!.uid.toString();
    return BlocBuilder<NewUserBloc, NewUserState>(builder: (context, state) {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('data')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text(
                'Something went wrong',
              );
            }
            if (!snapshot.hasData) {
              return const Text("");
            }
            {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot allDocs = snapshot.data!.docs[index];
                      return Card(
                        elevation: 5,
                        borderOnForeground: true,
                        color: kPrimaryBackground,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              color: kPrimaryborder,
                            )),
                        child: ListTile(
                            trailing: IconButton(
                              icon: (const Icon(Icons.delete)),
                              onPressed: () {
                                context.read<NewUserBloc>().add(
                                    DeleteNewUserEvent(state.username.value));
                              },
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: kPrimaryborder,
                                )),
                            onTap: () {
                              showDialog(
                                  useRootNavigator: false,
                                  context: context,
                                  builder: (newContext) {
                                    return BlocProvider<NewUserBloc>(
                                      create: (_) =>
                                          NewUserBloc(context.read<Database>()),
                                      child: BlocBuilder<NewUserBloc,
                                              NewUserState>(
                                          builder: (context, state) {
                                        return AlertDialog(
                                            title: const Text(
                                                'Information about user'),
                                            content: Column(
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      context
                                                          .read<NewUserBloc>()
                                                          .userStateChanged(
                                                              username: allDocs[
                                                                  'username'],
                                                              surname: allDocs[
                                                                  'surname'],
                                                              name: allDocs[
                                                                  'name'],
                                                              phone: allDocs[
                                                                  'phone']);
                                                    },
                                                    child: const Text(
                                                        'Show information')),
                                                Text(state.username.value),
                                                Text(state.surname.value),
                                                Text(state.name.value),
                                                Text(state.phone.value),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push<void>(
                                                        UserFormPage.route(),
                                                      );
                                                    },
                                                    child: const Text('edit'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      primary: kPrimaryGreen,
                                                    ))
                                              ],
                                            ));
                                      }),
                                    );
                                  });
                            },
                            leading: Text(
                              allDocs['username'],
                              style: textTheme.headline6,
                            )),
                      );
                    }),
              );
            }
          });
    });
  }
}
