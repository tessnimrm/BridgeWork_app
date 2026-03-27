import 'package:brigdeWork_app/CompanyScreen/companyProfileSet.dart';
import 'package:brigdeWork_app/WorkerScreen/workerProfileSet.dart';
import 'package:brigdeWork_app/shared_pages/background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/WorkerProvider.dart';
import '../providers/CompanyProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Choicepage extends StatefulWidget {
  const Choicepage({super.key});

  @override
  State<Choicepage> createState() => _ChoicepageState();
}

class _ChoicepageState extends State<Choicepage> {
  @override
  Widget build(BuildContext context) {
    final workerProvider = Provider.of<WorkerProvider>(context, listen: false);
    final companyProvider = Provider.of<CompanyProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: const Text(
                  "How do you want to use BridgeWork?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "You can switch modes anytime!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String fullName = prefs.getString('fullName') ?? '';
                    String email = prefs.getString('email') ?? '';

                    workerProvider.createProfile(
                      selectedJob: '',
                      selectedSkills: [],
                      selectedAvailability: [],
                      selectedLanguages: [],
                      customJobs: [],
                      customLanguages: [],
                      fullName: fullName,
                      email: email,
                      phone: '',
                      bio: '',
                      education: '',
                      experience: '',
                      projects: '',
                      coverImagePath: '',
                      profileImagePath: '',
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WorkerProfileSet(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 300,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(79, 70, 229, 1),
                          Color.fromRGBO(131, 125, 225, 1),
                          Color.fromRGBO(217, 217, 217, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Work",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Find jobs Fast",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String fullName = prefs.getString('fullName') ?? '';
                    String email = prefs.getString('email') ?? '';

                    companyProvider.createProfile(
                      selectedIndustry: '',
                      selectedAvailabilities: [],
                      requiredSkills: [],
                      selectedLanguages: [],
                      customIndustries: [],
                      customLanguages: [],
                      description: '',
                      companyName: fullName,
                      email: email,
                      phone: '',
                      website: '',
                      coverImagePath: '',
                      logoImagePath: '',
                      address: '',
                      employeeCount: 0,
                      services: '',
                      achievements: '',
                      companyOverview: '',
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompanyProfileSet(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 300,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(79, 70, 229, 1),
                          Color.fromRGBO(131, 125, 225, 1),
                          Color.fromRGBO(217, 217, 217, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Hire",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Hire talent easily",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 120),
              const Text(
                "Skip for now --> Explore as a guest",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
