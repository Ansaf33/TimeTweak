import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final List<Map<String, String?>> teamMembers = [
    {
      'name': 'Anupama Mary Joseph',
      'role': 'Team Lead',
      'description': 'Orchestrates and inspires with precision and clarity.',
    },
    {
      'name': 'Ansaf Hassan',
      'role': 'Backend Developer',
      'description': 'Builds strong backbones with clean APIs.',
    },
    {
      'name': 'Gokulkrishna V',
      'role': 'Frontend Developer',
      'description': 'Crafts interfaces with elegance and efficiency.',
    },
    {
      'name': 'Gopinath S Kumar',
      'role': 'Designer',
      'description': 'Transforms ideas into visual serenity.',
    },
    {
      'name': 'Rushda P',
      'role': 'Documentation',
      'description': 'Writes with clarity and precision.',
    },
  ];

  AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 35),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const Text(
            'About Us',
            style: TextStyle(color: Colors.white, letterSpacing: 1.1),
          ),
        ),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_rounded, color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _glassBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'About the Project',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'A seamless fusion of innovation and simplicity, this futuristic scheduling platform revolutionizes faculty - student interaction. Designed with precision and purpose, it empowers users to manage appointments effortlessly through a clean, intuitive interface. Born from collaboration and driven by passion, TimeTweak is a testament to thoughtful design, smart engineering, and a shared vision for smarter academic communication.',
                      style: TextStyle(color: Colors.white70, fontSize: 16, fontFamily: 'Loranthus'),
                    ),
                    Text(
                      'Built with ❤️ by ZTC',
                      style: TextStyle(color: Colors.white70, fontSize: 16, fontFamily: 'Loranthus'),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Faculty Guide: Anu Mary Chacko',
                      style: TextStyle(color: Colors.white60, fontSize: 13, fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Meet the Crew',
                style: TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 1),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: teamMembers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final member = teamMembers[index];
                  return _glassBox(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage("lib/assets/team_profiles/$index.jpeg"),
                          // backgroundColor: Colors.primaries[index % Colors.primaries.length].shade700,
                          // child: Text(
                          //   member['name']![0],
                          //   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          // ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member['name']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                member['role']!,
                                style: const TextStyle(color: Colors.white60, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                member['description']!,
                                style: const TextStyle(color: Colors.white38, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassBox({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(28, 28, 30, 0.03),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.06)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(4, 4),
            blurRadius: 12,
          ),
          BoxShadow(
            color: Colors.black26,
            offset: Offset(-3, -3),
            blurRadius: 12,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
