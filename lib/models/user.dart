class User {
  String username;
  String password;
  String nama;

  User({required this.username, required this.password, required this.nama});
}

User user1 = User(
  username: 'cece',
  password: '011',
  nama: 'Cendikia Permata Dewanti',
);

// Di dalam user.dart
// List<User> daftarUser = [
  //User(username: 'cece', password: '011', nama: 'Cendikia Permata'),
  //User(username: 'admin', password: '123', nama: 'Admin Toko'),
  //User(username: 'dosen', password: '999', nama: 'Bapak Dosen'),
//];