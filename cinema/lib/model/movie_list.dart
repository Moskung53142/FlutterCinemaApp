class movielist {
  final String title;
  final String description;
  final int duration;
  final String startdate;
  final String moviePic;
  final String category;

  movielist({
    required this.title,
    required this.description,
    required this.duration,
    required this.startdate,
    required this.moviePic,
    required this.category
  });
}

final List<movielist> appMovieList = [
  movielist(
    title: "SuperMan",
    description: "ฉันก็เป็นมนุษย์เหมือนกับทุกคน ฉันรัก ฉันกลัวเป็น",
    duration: 135,
    startdate: "23 มีนาคม 2566",
    moviePic: "asset/image/s-l1200.jpg",
    category: "แอคชั่น"
  ),
  movielist(
    title: "กล่องผีสุ่ม",
    description:
        "เรื่องราวของเด็กกลุ่มหนึ่ง ที่โดนลงโทษให้ไปทำความสะอาดวัดป่า และบังเอิญได้พบกับกล่องโบราณที่ถูกซ่อนเอาไว้ในโบสถ์ร้าง พวกเขาทำวัตถุชิ้นหนึ่งตกลงสู่พื้น และชีวิตของเด็กกลุ่มนี้ก็ไม่เหมือนเดิมอีกต่อไป เพราะสิ่งนั้นคือลูกเต๋าจากเกมกระดานอาถรรพ์ ที่เมื่อได้ทอยแล้วจะปลดปล่อยความสยองเกินคาดเดา ทางเดียวที่จะเอาชีวิตรอด คือต้องเผชิญหน้ากับผี และเอาชนะมันให้ได้ก่อนรุ่งสาง!",
    duration: 125,
    startdate: "14 กุมภาพันธ์ 2568",
    moviePic: "asset/image/movie_poster_ghost_box.jpg",
    category: "สยองขวัญ"
  ),
];
