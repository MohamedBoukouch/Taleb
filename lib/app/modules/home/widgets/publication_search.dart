import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/themes/app_theme.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/pages/commentaires.dart';
import 'package:taleb/app/shared/description_style.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class PostCardSearch extends StatefulWidget {
  final String localisation;
  final String timeAgo;
  final String titel;
  final String description;
  final String postImage;
  final String id_publication;
  bool? forcomment = false;
  final int numberlike;
  final int numbercomment;
  final int is_favorit;
  final int is_liked;
  final String link;
  final String link_titel;

  PostCardSearch({
    Key? key,
    required this.localisation,
    required this.timeAgo,
    required this.titel,
    required this.description,
    required this.postImage,
    required this.id_publication,
    required this.numberlike,
    required this.numbercomment,
    required this.is_favorit,
    required this.is_liked,
    required this.link,
    required this.link_titel,
  }) : super(key: key);

  @override
  State<PostCardSearch> createState() => _PostCardSearchState();
}

class _PostCardSearchState extends State<PostCardSearch> {
  bool _isExpanded = false;
  late int _isliked = widget.is_liked;
  late int _isfavorit = widget.is_favorit;
  int _like = 0;
  int comment = 0;
  late int nbr_like = widget.numberlike;
  final HomeController controller = Get.put(HomeController());
  final PageController _pageController = PageController();
  int currentPage = 0;
  late String inputImage = widget.postImage;
  List<String> charArray = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    splitString();
  }

  void splitString() {
    String filenamesString = widget.postImage.substring(1, widget.postImage.length - 1); // Remove leading "[" and trailing "]"
    charArray = filenamesString.split(',').map((filename) => filename.trim().replaceAll('"', '')).toList(); // Split by "," and trim whitespace, remove quotes
    setState(() {
      _isLoading = false; // Set loading to false once images are split
    });
    print("Images: $charArray"); // Debug print to check the image URLs
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = "${now.year}/${now.month}/${now.day}";
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Color.fromARGB(242, 245, 247, 245),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.pin_drop,
                  color: Colors.red,
                  size: 20,
                ),
                Text(widget.localisation, style: TextStyle(fontFamily: 'Bitter')),
              ],
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.timer,
                  color: Colors.blue,
                  size: 19,
                ),
                Text("${widget.timeAgo}", style: TextStyle(fontFamily: 'Bitter')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isExpanded
                    ? Text(
                        widget.titel,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Bitter',
                        ),
                      )
                    : Text(
                        widget.titel,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(
                    _isExpanded ? "" : "  Read More...",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          _isExpanded
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      StyledText(text: widget.description),
                      widget.link.isNotEmpty
                          ? Row(
                              children: [
                                Text(
                                  widget.link_titel,
                                  style: TextStyle(fontFamily: 'Bitter'),
                                ),
                                Link(
                                  uri: Uri.parse(widget.link),
                                  builder: (context, followLink) => TextButton(
                                    onPressed: followLink,
                                    child: Text(
                                      widget.link,
                                      style: TextStyle(fontFamily: 'Bitter'),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Text(""),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? "Read Less" : "",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: AppConstant.screenHeight * 0.45,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: charArray.length,
                          itemBuilder: (context, index) {
                            String imageUrl = "$linkserverimages/publication/${charArray[index].trim()}";
                            print("Loading image: $imageUrl"); // Debug print to check the URL
                            return Padding(
                              padding: EdgeInsets.all(3),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return Scaffold(
                                        body: Center(
                                          child: PhotoView(
                                            imageProvider: NetworkImage(imageUrl),
                                            backgroundDecoration: BoxDecoration(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                                },
                                child: ClipRRect(
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: CircularProgressIndicator()
                                      );
                                    },
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          onPageChanged: (int page) {
                            setState(() {
                              currentPage = page;
                            });
                          },
                        ),
                      ),
                      charArray.length > 1
                          ? DotsIndicator(
                              dotsCount: charArray.length,
                              position: currentPage,
                              decorator: const DotsDecorator(
                                activeColor: AppTheme.main_color_1,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
          
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: AppConstant.screenWidth * .29,
                  height: AppConstant.screenHeight * .06,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(64, 158, 158, 158),
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: AppConstant.screenWidth * .055),
                        child: IconButton(
                          icon: _isliked == 0
                              ? const Icon(
                                  Icons.favorite_border,
                                  size: 25,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 25,
                                ),
                          onPressed: () async {
                            setState(() {
                              _isliked == 0 ? _isliked = 1 : _isliked = 0;
                              _isliked == 0 ? nbr_like-- : nbr_like++;
                              // nbr_like++;
                            });
                            if (_isliked == true) {
                              // setState(()  {
                              try {
                                await controller.Addlike(
                                    widget.id_publication, "$nbr_like");
                              } catch (e) {
                                print("saba hhh");
                              }
                              // });
                            } else {
                              try {
                                await controller.Droplike(
                                    widget.id_publication, '$nbr_like');
                              } catch (e) {
                                print("saba hhh");
                              }
                              // });
                            }
                          },
                        ),
                      ),
                      Text(
                        "$nbr_like",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: AppConstant.screenWidth * .29,
                  height: AppConstant.screenHeight * .06,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(64, 158, 158, 158),
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: AppConstant.screenWidth * .055),
                        child: IconButton(
                          icon: const Icon(
                            Icons.chat_bubble_outline,
                            size: 25,
                          ),
                          onPressed: () {
                            Get.to(() => Commentaire(
                                  id_publication: "${widget.id_publication}",
                                )
                                );
                          },
                        ),
                      ),
                      Text(
                        "${widget.numbercomment}",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: AppConstant.screenWidth * .29,
                  height: AppConstant.screenHeight * .06,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(64, 158, 158, 158),
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    icon: _isfavorit == 0
                        ? const Icon(
                            Icons.star_border,
                            size: 25,
                          )
                        : const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 25,
                          ),
                    onPressed: () async {
                      print(widget.postImage);
                      setState(() {
                        _isfavorit == 0 ? _isfavorit = 1 : _isfavorit = 0;
                      });
                      if (_isfavorit == 1) {
                        // setState(()  {
                        try {
                          await controller.Addfavorite(widget.id_publication);
                        } catch (e) {
                          print("saba JJJ");
                        }
                        // });
                      } else {
                        try {
                          await controller.Dropfavorite(widget.id_publication);
                        } catch (e) {
                          print("saba hhh");
                        }

                        // });
                      }
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

    void _launchFacebook() async {
    const facebookPageUrl = 'https://www.facebook.com'; // Replace 'example' with your Facebook page username or ID
    if (await canLaunch(facebookPageUrl)) {
      await launch(facebookPageUrl);
    } else {
      throw 'Could not launch $facebookPageUrl';
    }
  }
}
