// const linkservername = "http://172.20.128.1/Taleb_DB";
// const linkservername = "https://kotlinboukouchtest.000webhostapp.com";

// http://127.0.0.1:8000/api/signup




//TAWJIHI_EXEMPLE
const linkservername = "http://10.0.2.2:8000/api";
const linkserverimages = "http://10.0.2.2:8000/images";





//Auth
const linksignup = "$linkservername/signup";
const linklogin = "$linkservername/login";
const linkverifyEmail = "$linkservername/verifyEmail";

//ResetPassword
const linkcheckEmail = "$linkservername/reset_password/check-email";
const linkverifycompte = "$linkservername/reset_password/verify-compte";
const linkresertpassword = "$linkservername/reset-password/reset";

//Publication
const linkshowpubli = "$linkservername/publications/getPublications";

//Comments
const linkaddcomment = "$linkservername/comments/add";
const linkshowcomment = "$linkservername/publications/show-comments";
const linkdeletcomment ="$linkservername/comments/delete";
const linkNumbercomment =
    "$linkservername/publication/comment/Number_comment.php";

//Like_publication
const linkLike = "$linkservername/publications/update-number-of-likes";
const linkAddlike = "$linkservername/likes/add";
const linkDroplike = "$linkservername/likes/drop";

//favorit
const linkAddfavorit = "$linkservername/favorites/add";
const linkDropfavorit = "$linkservername/favorites/delete";
const linkselectfavorit ="$linkservername/favorites/select";

//Search
const linksearch = "$linkservername/publications/search";

//Notification
const link_notification = "$linkservername/Notification/notification_active.php";
const link_delet_notification = "$linkservername/notifications/delete";

const link_all_notifications ="$linkservername/notifications/select";

const link_update_notification_status =
    "$linkservername/notifications/update-status";

const link_notification_active =
    "$linkservername/notifications/check_is_active";

const link_show_publication =
    "$linkservername/Notification/show_publication.php";

//Messages
const link_send_messages = "$linkservername/chat/send_message";
const link_show_messages = "$linkservername/chat/select_messages";
const link_delet_message = "$linkservername/chat/delete_message";
const link_active_message = "$linkservername/chat/active";
const link_update_status_message = "$linkservername/chat/update_status";

//Profile
const link_profile = "$linkservername/profile/fetch-profile";
const link_add_pic_profile = "$linkservername/profile/add-profile-image";

//Compte
const link_edit_compte = "$linkservername/compte/edit-compte";
const link_edit_password = "$linkservername/compte/edit-password";
const link_delet_compte = "$linkservername/compte/delete-compte";

//Councoures
const link_select_ecole = "$linkservername/ecoles/select";
const link_select_ville_ecole = "$linkservername/ecolevilles/select";
const link_select_pdfs = "$linkservername/pdfconcours/select";


//Slider
const fetch_slider_link = "$linkservername/sliders";

