import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/dues_citizen/dues_citizen_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/dues/dues_citizen_notifier.dart';
import '../../riverpod/parameter/dues_citizen_parameter.dart';
import '../widgets/dues_detail_card.dart';

import 'widgets/citizen_dues_filter.dart';

class CitizenDuesPage extends ConsumerWidget {
  const CitizenDuesPage({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final future = ref.watch(getCitizenDues(username));
          if (future.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (future.hasError) {
            return Center(child: Text("Error ${future.error}"));
          }

          final value = future.value ?? const DuesCitizenModel();

          final user = value.citizen;
          final dues = value.dues;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                centerTitle: true,
                title: Text("Iuran ${user.name}"),
                actions: [
                  IconButton(
                    onPressed: () async => await showDialog(
                        context: context, builder: (ctx) => const CitizenDuesFilter()),
                    icon: const Icon(Icons.filter_alt),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(blurRadius: 2.0, color: black.withOpacity(.25)),
                  ],
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    final parameter = ref.watch(duesCitizenParameter);
                    return Text(
                      "${parameter.duesCategory?.name ?? "Semua Iuran"} ${sharedFunction.monthString(parameter.month)} ${parameter.year}",
                      style: hFontWhite.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        letterSpacing: 1.1,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 1));
                    ref.refresh(getCitizenDues(username));
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: dues.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      final item = dues[index];
                      return DuesDetailCard(
                        onTap: () => gotoPage.duesFormUpdate(context, duesDetailID: item.id!),
                        item: item,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
