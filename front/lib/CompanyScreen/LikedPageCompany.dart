// screens/company/liked_page_company.dart
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:brigdeWork_app/shared_pages/background.dart';
import 'package:provider/provider.dart';
import '../../models/JobModel.dart';
import 'package:brigdeWork_app/providers/CompanyLiked.dart';

class LikedPageCompany extends StatefulWidget {
  const LikedPageCompany({super.key});

  @override
  State<LikedPageCompany> createState() => _LikedPageCompanyState();
}

class _LikedPageCompanyState extends State<LikedPageCompany> {
  @override
  Widget build(BuildContext context) {
    final likedProvider = Provider.of<CompanyLikedWorkersProvider>(context);
    final likedWorkers = likedProvider.likedWorkers;

    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(child: SizedBox.expand()),
          SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 122,
                  decoration: BoxDecoration(
                    color: HexColor("#837DE1"),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 28,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Text(
                        "Liked Company",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: likedWorkers.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No liked workers yet',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: likedWorkers.length,
                          itemBuilder: (context, index) {
                            final worker = likedWorkers[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Card(
                                elevation: 0,
                                color: Colors.white.withOpacity(0.95),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      worker.imageUrl,
                                    ),
                                    child: worker.imageUrl.isEmpty
                                        ? const Icon(Icons.person)
                                        : null,
                                  ),
                                  title: Text(
                                    worker.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(worker.place),
                                      const SizedBox(height: 4),
                                      Wrap(
                                        spacing: 4,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: HexColor("#D9D9D9"),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              worker.timing,
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: HexColor("#D9D9D9"),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              worker.flexibility,
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      likedProvider.removeWorker(worker);
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/company/worker-profile',
                                      arguments: worker,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
