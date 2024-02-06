import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

class Supporte extends StatelessWidget {
  const Supporte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitialView(
        selectedindex: 0,
        appbar: AppBar(
          title: Text(
            'Supporte'.tr,
            style: TextStyle(fontFamily: 'Bitter'),
          ),
          // centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(30),
            child: const Column(
              children: [
                Text(
                  "Article 1 – Objet des conditions générales",
                  style: TextStyle(
                      fontFamily: 'Bitter',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ''' Article 1 – Objet des conditions générales Taleb a développé, exploite et commercialise une application mobile (l'"Application") dans le domaine de l'enseignement supérieur et de la préparation aux concoures d'entrée à l'université.
Dans ce cadre, la Société offre aux utilisateurs de l'Application (les "Utilisateurs") un accès à des ressources de préparation aux concoures d'entrée à l'université, notamment des informations sur les prochains concours universitaires et des exemples de sujets d'examens passés au format PDF pour faciliter leur préparation.
Toute personne accédant à l'Application s'engage à se conformer sans réserve aux présentes conditions générales, qui constituent les conditions générales d'utilisation et de vente (les "Conditions Générales"). Elles sont soumises à l'acceptation de l'Utilisateur avant le téléchargement de l'Application et s'appliquent à l'utilisation de l'Application ainsi qu'à l'achat et à l'utilisation des ressources de préparation aux concoures.
Taleb se réserve le droit de modifier les Conditions Générales à tout moment et sans préavis, notamment pour tenir compte de toute évolution légale, jurisprudentielle, éditoriale et/ou technique. La version prévalente est celle accessible sur l'Application.''',
                  style: TextStyle(fontFamily: 'Bitter'),
                ),
              ],
            ),
          ),
        ));
  }
}
