import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // Daftar nama file gambar anggota tim
    final List<String> imageList = [
      'agung.jpg',
      'fandii.jpg',
      'gusnaldi.jpg',
      'ai.jpeg',
      'wahyu.png',
    ];

    final List<String> teamMembers = [
      'Agung', // Nama anggota tim 1
      'Fandi', // Nama anggota tim 2
      'Gusnaldi', // Nama anggota tim 3
      'Juan', // Nama anggota tim 4
      'Wahyu', // Nama anggota tim 5
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10), // Jarak kecil di atas
              // Bagian About Us
              Text(
                'Welcome to Headlines Hub',
                style: TextStyle(
                  fontSize: 22, // Ukuran teks sedikit lebih kecil
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8), // Jarak antar teks lebih rapat
              Text(
                'Headlines Hub adalah platform berita terkemuka yang menghadirkan berita terbaru, terpercaya, dan relevan dari berbagai sumber di seluruh dunia. Kami berkomitmen untuk memberikan informasi yang akurat dan menarik kepada pembaca kami.',
                style: TextStyle(
                  fontSize: 14, // Ukuran teks lebih kecil
                  color: theme.textTheme.bodyMedium?.color,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16), // Jarak antar bagian lebih kecil

              // Bagian Our Team
              Text(
                'Our Team',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth < 600
                      ? 3
                      : 5, // Responsif: 3 atau 5 bingkai per baris
                  crossAxisSpacing: 8, // Jarak horizontal lebih kecil
                  mainAxisSpacing: 8, // Jarak vertikal lebih kecil
                  childAspectRatio: 1,
                ),
                itemCount:
                    imageList.length, // Jumlah anggota tim berdasarkan array
                itemBuilder: (context, index) {
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bingkai foto
                      Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Menambahkan padding di sekitar foto
                        child: Container(
                          height:
                              screenWidth < 600 ? 70 : 90, // Ukuran responsif
                          width:
                              screenWidth < 600 ? 70 : 90, // Ukuran responsif
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white70
                                  : Colors.blueAccent,
                              width: 1,
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                'images/${imageList[index]}', // Path otomatis dari daftar
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height:
                              4), // Jarak lebih kecil antara bingkai dan teks
                      // Nama anggota tim
                      Text(
                        teamMembers[
                            index], // Menampilkan nama sesuai dengan index
                        style: TextStyle(
                          fontSize: 12, // Ukuran teks lebih kecil
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16), // Jarak akhir lebih kecil
            ],
          ),
        ),
      ),
    );
  }
}
