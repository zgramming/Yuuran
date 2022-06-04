part of '../dues_form_page.dart';

class _InputDropdownCitizen extends StatelessWidget {
  const _InputDropdownCitizen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pilih Warga',
          style: hFont.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Consumer(
          builder: (context, ref, child) {
            final future = ref.watch(getCitizens);
            return future.when(
              data: (data) {
                final citizenId = ref.watch(duesFormParameter.select((value) => value.citizenId));
                final selectedCitizen = data.firstWhereOrNull((element) => element.id == citizenId);
                return DropdownButton<UserModel>(
                  isExpanded: true,
                  value: selectedCitizen,
                  hint: Text(
                    "Pilih warga yang ingin dibuatkan iuran",
                    style: bFont.copyWith(fontSize: 12.0, color: grey),
                  ),
                  items: data
                      .map(
                        (e) => DropdownMenuItem(value: e, child: Text(e.name)),
                      )
                      .toList(),
                  onChanged: (value) => ref
                      .watch(duesFormParameter.notifier)
                      .update((state) => state.copyWith(citizenId: value?.id)),
                );
              },
              error: (error, trace) => Center(child: Text("Error $error")),
              loading: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
