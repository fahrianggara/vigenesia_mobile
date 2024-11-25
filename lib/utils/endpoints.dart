part of 'utilities.dart';

// BASE URL
const baseURL = "https://news.fahrianggara.my.id/api";

// AUTHENTICATION
const loginURL    = "$baseURL/login";
const registerURL = "$baseURL/register";
const logoutURL   = "$baseURL/logout";
const meURL       = "$baseURL/me";
const updateProfileURL = "$baseURL/update-profile";

// POST URL
const postsCarouselURL = "$baseURL/posts/carousel";
const postsURL         = "$baseURL/posts";
const storePostURL     = "$postsURL/store";
const updatePostURL    = "$postsURL/update";
const deletePostURL    = "$postsURL/destroy";

// CATEGORIES URL
const fetchCategoryURL = "$baseURL/fetch-categories"; // for select input
const categoriesURL    = "$baseURL/categories";
const categoryURL      = "$categoriesURL/show";