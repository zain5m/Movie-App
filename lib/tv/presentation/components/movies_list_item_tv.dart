import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move/core/network/api_constance.dart';
import 'package:move/core/utils/global/components.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/tv/domain/entities/tv.dart';
import 'package:shimmer/shimmer.dart';

class MoviesListItemTv extends StatelessWidget {
  const MoviesListItemTv({
    super.key,
    required this.movie,
  });

  final Tv movie;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenHeight(8)),
        decoration: const BoxDecoration(
          color: Color(0xFF303030),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: movie.backdropPath != null
                  ? CachedNetworkImage(
                      width: getProportionateScreenWidth(80.0),
                      height: getProportionateScreenHeight(120),
                      fit: BoxFit.cover,
                      imageUrl: ApiConstance.imageUrl(movie.backdropPath!),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[850]!,
                        highlightColor: Colors.grey[800]!,
                        child: Container(
                          width: getProportionateScreenWidth(80.0),
                          height: getProportionateScreenHeight(120),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : nullImage(
                      width: getProportionateScreenWidth(80.0),
                      height: getProportionateScreenHeight(120),
                    ),
            ),
            SizedBox(width: getProportionateScreenWidth(15)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5)),
                  Row(
                    children: [
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //     vertical: getProportionateScreenHeight(2),
                      //     horizontal: getProportionateScreenWidth(8.0),
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: Colors.red,
                      //     borderRadius: BorderRadius.circular(4.0),
                      //   ),
                      //   child: Text(
                      //     movie.releaseDate.split('-')[0],
                      //     style: const TextStyle(
                      //       // fontSize: 16.0,
                      //       letterSpacing: 1,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: getProportionateScreenWidth(16)),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18.0,
                          ),
                          SizedBox(width: getProportionateScreenWidth(4)),
                          Text(
                            (movie.voteAverage / 2).toStringAsFixed(1),
                          ),
                          SizedBox(width: getProportionateScreenWidth(4)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
