import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            // ---------- TOP IMAGE SECTION ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.62),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      // Replace this with your real asset image
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              //image: NetworkImage(
                                //"https://placehold.co/309x83", // replace later
                                image: AssetImage(
                                "assets/images/Initial_page.png",
                                ),
                              //),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      // ---------- GET STARTED TEXT ----------
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              // TODO: Navigate to login/signup page
                              Navigator.pushNamed(context, "/login");
                            },
                            child: Text(
                              "Get started",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Inter",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ---------- COPYRIGHT ----------
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Copyright© 2025 Gom.Inc. All rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF253E05),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // ---------- BOTTOM HANDLE (IPHONE STYLE) ----------
            Container(
              height: 34,
              alignment: Alignment.center,
              child: Container(
                width: 134,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





