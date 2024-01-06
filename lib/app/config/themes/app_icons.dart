import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcons {
  static var pathActive = 'assets/icons/active-';
  static var pathUnactive = 'assets/icons/unactive-';
  static var pathError = 'assets/icons/error-';

  static _buildSvgActive(String name) =>
      SvgPicture.asset('$pathActive$name.svg');
  static _buildSvgUnActive(String name) =>
      SvgPicture.asset('$pathUnactive$name.svg');
  static _buildSvgError(String name) => SvgPicture.asset('$pathError$name.svg');

  static _buildImageActive(String name) => Image.asset('$pathActive$name.png');
  static _buildImageUnActive(String name) =>
      Image.asset('$pathUnactive$name.png');

  // Authentication
  static var activeUsername = _buildSvgActive('username');
  static var unactiveUsername = _buildSvgUnActive('username');
  static var activeEmail = _buildSvgActive('email');
  static var unactiveEmail = _buildSvgUnActive('email');
  static var activeLock = _buildSvgActive('lock');
  static var unactiveLock = _buildSvgUnActive('lock');
  static var errorLock = _buildSvgError('lock');
  static var activeEyes = _buildSvgActive('eye');
  static var unactiveEyes = _buildSvgUnActive('eye');
  static var activeAlert = _buildSvgActive('alert');
  // static var unactiveAlert = _buildSvgUnActive('alert');

  // Bottom Navbar
  static var activeHome = _buildImageActive('home');
  static var unactiveHome = _buildImageUnActive('home');
  static var activeSearch = _buildImageActive('search');
  static var unactiveSearch = _buildImageUnActive('search');
  static var activeBookmark = _buildImageActive('bookmark');
  static var unactiveBookmark = _buildImageUnActive('bookmark');
  static var activeProfile = _buildImageActive('person');
  static var unactiveProfile = _buildImageUnActive('person');
  static var activeNotif = _buildImageActive('bell');
  static var unactiveNotif = _buildImageUnActive('bell');

  // Home menu
  static var activeAll = _buildImageActive('all');
  static var unactiveAll = _buildImageUnActive('all');
  static var activeWallArt = _buildImageActive('wall-art');
  static var unactiveWallArt = _buildImageUnActive('wall-art');
  static var activePlant = _buildImageActive('plant');
  static var unactivePlant = _buildImageUnActive('plant');
  static var activeBag = _buildImageActive('bag');
  static var unactiveBag = _buildImageUnActive('bag');
  static var activeClothing = _buildImageActive('clothing');
  static var unactiveClothing = _buildImageUnActive('clothing');
  static var activeArt = _buildImageActive('art');
  static var unactiveArt = _buildImageUnActive('art');
  static var activeJawerly = _buildImageActive('jawerly');
  static var unactiveJawerly = _buildImageUnActive('jawerly');

  // Search
  static var activeFilter = _buildImageActive('filter');
  static var unactiveFilter = _buildImageUnActive('filter');
  static var activeCheck = _buildImageActive('check');

  //Bookmark
  static var activeClear = _buildImageActive('close');
  static var activeCart = _buildImageActive('cart');

  //Profile
  static var activeLogout = _buildImageActive('logout');
}
