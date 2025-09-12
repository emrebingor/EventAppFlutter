part of '../event_list_screen.dart';

final class _EventListViewWidget extends StatelessWidget {
  const _EventListViewWidget({
    required this.events,
    required this.onDelete,
    required this.onTap,
  });

  final List<LocalEvent>? events;
  final void Function(LocalEvent event) onDelete;
  final void Function(LocalEvent event) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: events?.length ?? 0,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        if (events?.isEmpty ?? false) return const SizedBox.shrink();
        final LocalEvent event = events![index];
        return Slidable(
          key: ValueKey(event.id),
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => onDelete(event),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: InkWell(
              onTap: () => onTap(event),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(event.date),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

final class _EmptyEventWidget extends StatelessWidget {
  const _EmptyEventWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.calendar_month),
          SizedBox(height: 12),
          Text(
            'There is no active event please add event.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
