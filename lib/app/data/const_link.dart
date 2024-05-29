// const linkservername = "http://172.20.128.1/Taleb_DB";
// const linkservername = "https://kotlinboukouchtest.000webhostapp.com";

// http://127.0.0.1:8000/api/signup




//TAWJIHI_EXEMPLE
const linkservername = "http://10.0.2.2:8000/api";
const linkserverimages = "http://10.0.2.2:8000/storage";





//Auth
const linksignup = "$linkservername/signup";
const linklogin = "$linkservername/login";
const linkverifyEmail = "$linkservername/verifyEmail";

//ResetPassword
const linkcheckEmail = "$linkservername/ResetPassword/CheckEmail.php";
const linkverifycompte = "$linkservername/ResetPassword/verifycompte.php";
const linkresertpassword = "$linkservername/ResetPassword/resetpassword.php";

//Publication
const linkshowpubli = "$linkservername/publications/getPublications";

//Comments
const linkaddcomment = "$linkservername/publication/comment/Add_comment.php";
const linkshowcomment = "$linkservername/publication/comment/Show_comment.php";
const linkdeletcomment =
    "$linkservername/publication/comment/delete_comment.php";
const linkNumbercomment =
    "$linkservername/publication/comment/Number_comment.php";

//Like_publication
const linkLike = "$linkservername/publication/Like/like.php";
const linkAddlike = "$linkservername/publication/Like/Add_like.php";
const linkDroplike = "$linkservername/publication/Like/Drop_like.php";

//favorit
const linkAddfavorit = "$linkservername/publication/favorit/add_favorit.php";
const linkDropfavorit = "$linkservername/publication/favorit/drop_favorit.php";
const linkselectfavorit =
    "$linkservername/publication/favorit/select_favorit.php";

//Search
const linksearch = "$linkservername/search/serch_publication.php";

//Notification
const link_notification = "$linkservername/Notification/notification_active.php";
const link_delet_notification =
    "$linkservername/Notification/deletnotification.php";
const link_all_notifications =
    "$linkservername/Notification/all_notification.php";
const link_update_notification_status =
    "$linkservername/Notification/update_status_notification.php";
const link_notification_active =
    "$linkservername/Notification/notification_active.php";
const link_show_publication =
    "$linkservername/Notification/show_publication.php";

//Messages
const link_send_messages = "$linkservername/Chat/send_message.php";
const link_show_messages = "$linkservername/Chat/show_message.php";
const link_delet_message = "$linkservername/Chat/delet_message.php";
const link_active_message = "$linkservername/Chat/active_messages.php";
const link_update_status_message = "$linkservername/Chat/update_status.php";

//Profile
const link_profile = "$linkservername/profile/fetch-profile";
const link_add_pic_profile = "$linkservername/profile/add-profile-image";
//Compte
const link_edit_compte = "$linkservername/compte/edit-compte";
const link_edit_password = "$linkservername/compte/edit-password";
const link_delet_compte = "$linkservername/compte/delete-compte";

//Councoures
const link_select_ecole = "$linkservername/Admin/concoures/SelectEcoles.php";
const link_select_ville_ecole =
    "$linkservername/Admin/concoures/Villes/SelectVilleEcole.php";
const link_select_pdfs = "$linkservername/Admin/concoures/PDF/SelectPdf.php";


//Slider
const fetch_slider_link = "$linkservername/sliders";

