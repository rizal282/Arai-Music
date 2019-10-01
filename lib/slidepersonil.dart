import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SlidePersonil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
      height: 345.0,
      child: CarouselSlider(
        height: 400.0,
        items: [
         'http://pic3.16pic.com/00/55/42/16pic_5542988_b.jpg',
         'http://photo.16pic.com/00/38/88/16pic_3888084_b.jpg',
         'http://pic3.16pic.com/00/55/42/16pic_5542988_b.jpg',
         'http://photo.16pic.com/00/38/88/16pic_3888084_b.jpg'
        ].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.black),
                  child: GestureDetector(
                      child: Image.network(i, fit: BoxFit.fill),
                      onTap: () {
                        print("object");
                      }));
            },
          );
        }).toList(),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Personil"),
      ),
      body: Container(
        child: Center(
          child: imageCarousel,
        ),
      ),
    );
  }
}
