import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sprint2/api/api.dart';
import 'package:sprint2/models/data_models.dart';
import 'package:sprint2/widget/glass_card.dart';

class MyCarousel extends StatelessWidget {
  MyCarousel({Key? key}) : super(key: key);

  final SprintApi _api = SprintApi();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      constraints: const BoxConstraints(
        maxWidth: 800,
      ),
      child: CarouselSlider(
        items: [
          weatherCard(),
          newsCard(),
          // imageCard(),
        ],
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
        ),
      ),
    );
  }

  GlassCard imageCard() {
    return GlassCard(
      borderRadius: BorderRadius.circular(15.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/IMG_20201203_205800.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "Arindam Karmakar",
              textScaleFactor: 1.3,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GlassCard newsCard() {
    return GlassCard(
      borderRadius: BorderRadius.circular(15.0),
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder<List<News>>(
        future: _api.getNews(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Headlines",
                  textScaleFactor: 2.0,
                  style: TextStyle(
                    color: Colors.lightGreen.shade200.withOpacity(0.8),
                    //color: Colors.white.withOpacity(0.6),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: snapshot.data!
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                e.title,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Text(
              // snapshot.error.toString(),
              "Unable to load data!",
              style: TextStyle(color: Colors.red),
            );
          } else {
            return Align(
              alignment: Alignment.topLeft,
              child: CircularProgressIndicator(
                color: Colors.white.withOpacity(0.4),
              ),
            );
          }
        },
      ),
    );
  }

  GlassCard weatherCard() {
    return GlassCard(
      borderRadius: BorderRadius.circular(15.0),
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder<Weather>(
        future: _api.getWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Text(
                    snapshot.data!.name,
                    textScaleFactor: 2.0,
                    style: TextStyle(
                      color: Colors.lightGreen.shade200.withOpacity(0.8),
                      //color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    snapshot.data!.condition,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "temp: ${snapshot.data!.temp}°C",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "humd: ${snapshot.data!.hum}",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "wind: ${snapshot.data!.temp}mph",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "uv: ${snapshot.data!.uv}",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Text(
              // snapshot.error.toString(),
              "Unable to load data!",
              style: TextStyle(color: Colors.red),
            );
          } else {
            return Align(
              alignment: Alignment.topLeft,
              child: CircularProgressIndicator(
                color: Colors.white.withOpacity(0.4),
              ),
            );
          }
        },
      ),
    );
  }
}
