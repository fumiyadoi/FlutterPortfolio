import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../common_widget/tag.dart';
import '../common_widget/tag_with_delete_button.dart';
import '../common_widget/text_bold.dart';
import '../common_widget/text_bold_white.dart';
import '../common_widget/time_drum.dart';
import '../common_widget/user_info_detail_row_can_edit.dart';
import 'edit_meeting_place.dart';
import 'send_offer_model.dart';

class SendOffer extends HookConsumerWidget {
  final String user1Id;
  final String user2Id;

  const SendOffer({
    Key? key,
    required this.user1Id,
    required this.user2Id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.microtask(() async {
        await initSendOffer(ref);
      });
      return;
    }, const []);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        // タイトル
        centerTitle: true,
        title: const TextBold(
          text: 'オファー設定',
          fontSize: 18,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const TextBold(text: 'タグの追加', fontSize: 15),
              const SizedBox(height: 24),
              const TextBold(text: 'タグ一覧', fontSize: 12),
              const SizedBox(height: 16),
              FutureBuilder(
                future: fetchTags(),
                builder: (context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.none || snapshot.hasData == false) {
                    return const CircularProgressIndicator();
                  }
                  return Wrap(
                    spacing: 8,
                    children: snapshot.data!
                        .map<Widget>(
                          (tag) => GestureDetector(
                            onTap: () => ref.read(selectedTagsProvider.notifier).addTag(tag),
                            child: Tag(text: tag),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 24),
              const TextBold(text: '追加したタグ', fontSize: 12),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: ref
                    .watch(selectedTagsProvider)
                    .map<Widget>(
                      (tag) => TagWithDeleteButton(
                        text: tag,
                        onPressed: ref.read(selectedTagsProvider.notifier).removeTag,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              const TextBold(text: '日時・場所の設定', fontSize: 15),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => TimeDrum(
                      displayTime: ref.watch(displayMeetingTimeProvider),
                      selectActiveTime: false,
                      saveTime: saveMeetingTime,
                    ),
                  );
                },
                child: UserInfoDetailRowCanEdit(title: '希望日時', content: ref.watch(displayMeetingTimeProvider)),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const EditMeetingPlace(),
                  );
                },
                child: UserInfoDetailRowCanEdit(title: '希望場所', content: ref.watch(meetingPlaceProvider.state).state),
              ),
              const SizedBox(height: 79),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: FloatingActionButton(
            heroTag: 'オファーする',
            child: const TextBoldWhite(text: 'オファーする'),
            backgroundColor: Theme.of(context).primaryColor,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            onPressed: () => {},
          ),
        ),
      ),
    );
  }
}
