import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/model/dues_category/dues_category_model.dart';
import '../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../data/model/dues_response/dues_response_model.dart';
import '../../../data/model/user/user_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/app_config/app_config_notifier.dart';
import '../../riverpod/citizen/citizens_notifier.dart';
import '../../riverpod/dues/dues_action_notifier.dart';
import '../../riverpod/dues/dues_notifier.dart';
import '../../riverpod/dues_category/dues_categories_notifier.dart';
import '../../riverpod/parameter/dues_form_parameter.dart';
import '../widgets/modal_loading.dart';
import '../widgets/modal_success.dart';

part 'widget/input_dropdown_month.dart';
part 'widget/input_dropdown_year.dart';
part 'widget/input_dropdown_citizen.dart';
part 'widget/input_dropdown_category.dart';
part 'widget/input_amount.dart';
part 'widget/input_description.dart';
part 'widget/input_status.dart';

class DuesFormPage extends ConsumerWidget {
  const DuesFormPage({
    Key? key,
    required this.duesDetailID,
  }) : super(key: key);

  final String duesDetailID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Listen [duesNotifier] when load dues detail from API
    ref.listen<AsyncValue<DuesDetailModel?>>(
      getDuesDetail(duesDetailID),
      (_, state) {
        state.whenData((value) {
          ref.watch(duesFormParameter.notifier).update((state) => state.copyWith(
                duesId: value?.id,
                amount: value?.amount,
                citizenId: value?.usersId,
                description: value?.description,
                duesCategoryId: value?.duesCategoryId,
                month: value?.month,
                year: value?.year,
                statusPaid: value?.status,
              ));
        });
      },
    );

    /// Listen [duesActionNotifier] when saving data
    ref.listen<AsyncValue<DuesResponse?>>(
      duesActionNotifier.select((value) => value.saveAsync),
      (_, state) async {
        if (state.isLoading) {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ModalLoadingWidget(),
          );
          return;
        }

        /// Close modal loading
        Navigator.pop(context);

        if (state.hasError) {
          sharedFunction.showSnackbar(context, color: Colors.red, title: "${state.error}");
          return;
        }

        final response = state.value;
        await showDialog(
          context: context,
          builder: (context) => ModalSuccessWidget(message: "${response?.message}"),
        );
      },
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Builder(builder: (context) {
          final future = ref.watch(getDuesDetail(duesDetailID));

          if (future is AsyncLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (future is AsyncError) {
            final message = future.error;
            return Scaffold(body: Center(child: Text("$message")));
          }
          final duesDetail = future.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                title: Text(
                  duesDetail?.id == null ? "Tambah Iuran" : "Update Iuran",
                  style: hFontWhite.copyWith(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => ref.invalidate(getDuesDetail(duesDetailID)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ...[
                                    const SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        _InputDropdowpMonth(),
                                        SizedBox(width: 16.0),
                                        _DropdownYear(),
                                      ],
                                    ),
                                    const SizedBox(height: 16.0),
                                  ],
                                  const _InputDropdownCitizen(),
                                  const SizedBox(height: 16.0),
                                  const _InputDropdownDuesCategory(),
                                  const SizedBox(height: 16.0),
                                  const _InputAmount(),
                                  const SizedBox(height: 16.0),
                                  const _InputDescription(),
                                  const SizedBox(height: 16.0),
                                  const _InputStatus(),
                                  const SizedBox(height: 16.0),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final userLogin =
                                          ref.read(appConfigNotifer).itemAsync.value?.userSession;
                                      final form = ref.read(duesFormParameter);
                                      await ref.read(duesActionNotifier.notifier).saveDues(
                                            form.duesId,
                                            duesCategoryId: form.duesCategoryId,
                                            usersId: form.citizenId,
                                            month: form.month,
                                            year: form.year,
                                            amount: form.amount,
                                            status: form.statusPaid,
                                            description: form.description,
                                            createdBy: userLogin?.id ?? 0,
                                          );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(16.0),
                                      primary: primary,
                                    ),
                                    child: Text(
                                      "Submit",
                                      style: bFont.copyWith(
                                          fontWeight: FontWeight.bold, fontSize: 16.0),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
