import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: ProfilePage(),
  ));
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image.asset(
                      "Image/AyamGoreng.jpg",
                      width: double.infinity,
                      height: 175,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Transform.translate(
                      offset: Offset(0,
                          -50), // Geser ke kiri 20 pixel dan ke atas 20 pixel
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white, // Border color
                                  width: 5.0, // Border width
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1000.0))),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/Image/PhotoProfile.jpeg"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Muchammad Fachri Syakur',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Mulish',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'XI PG',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Mulish',
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ...List.generate(customListTile.length, (index) {
                            final data = customListTile[index];
                            return Card(
                              elevation: 4,
                              shadowColor: Colors.black12,
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailBarPage(title: data.title),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Icon(data.icon),
                                  title: Text(
                                    data.title,
                                    style: TextStyle(
                                        fontFamily: 'Mulish',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  trailing: Icon(Icons.chevron_right),
                                ),
                              ),
                            );
                          }),
                        ],
                      )),
                ],
              )),
        ),
      ),
    );
  }
}

class CustomListTile {
  final IconData icon;
  final String title;
  CustomListTile({
    required this.icon,
    required this.title,
  });
}

List<CustomListTile> customListTile = [
  CustomListTile(
    icon: Icons.insights,
    title: "Aktivitas",
  ),
  CustomListTile(
    icon: Icons.location_on_outlined,
    title: "Lokasi",
  ),
  CustomListTile(
    title: "Notifikasi",
    icon: Icons.notifications,
  ),
  CustomListTile(
    title: "Ganti Password",
    icon: Icons.key,
  ),
  CustomListTile(
    icon: Icons.logout,
    title: "Logout",
  ),
];

class DetailBarPage extends StatelessWidget {
  final String title;

  const DetailBarPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              // Notifikasi dalam aplikasi
              ListTile(
                title: Text(
                  "Notifikasi dalam aplikasi",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: "Mulish",
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Aksi ketika diklik
                },
              ),
              Divider(),
              Text(
                "Interaksi",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: "Mulish",
                ),
                textAlign: TextAlign.left,
              ),
              SwitchListTile(
                title: Text(
                  "Suka",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Mulish",
                  ),
                  textAlign: TextAlign.left,
                ),
                value: false,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: Text(
                  "Komentar",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Mulish",
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: Text(
                  "Pengikut baru",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Mulish",
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: Text(
                  "Sebutan",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Mulish",
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: Text(
                  "Posting ulang",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Mulish",
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
