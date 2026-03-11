class movielist {
  final String title;
  final String description;
  final int duration;
  final String startdate;
  final String moviePic;
  final String category;
  final String status;
  

  movielist({
    required this.title,
    required this.description,
    required this.duration,
    required this.startdate,
    required this.moviePic,
    required this.category,
    required this.status,
  });
}

final List<movielist> appMovieList = [
  movielist(
    title: "SuperMan",
    description: "ฉันก็เป็นมนุษย์เหมือนกับทุกคน ฉันรัก ฉันกลัวเป็น",
    duration: 135,
    startdate: "1 มีนาคม 2569",
    moviePic: "asset/image/s-l1200.jpg",
    category: "แอคชั่น",
    status: "now_showing",
  ),
  movielist(
    title: "กล่องผีสุ่ม",
    description:
        "เรื่องราวของเด็กกลุ่มหนึ่ง ที่โดนลงโทษให้ไปทำความสะอาดวัดป่า และบังเอิญได้พบกับกล่องโบราณที่ถูกซ่อนเอาไว้ในโบสถ์ร้าง พวกเขาทำวัตถุชิ้นหนึ่งตกลงสู่พื้น และชีวิตของเด็กกลุ่มนี้ก็ไม่เหมือนเดิมอีกต่อไป เพราะสิ่งนั้นคือลูกเต๋าจากเกมกระดานอาถรรพ์ ที่เมื่อได้ทอยแล้วจะปลดปล่อยความสยองเกินคาดเดา ทางเดียวที่จะเอาชีวิตรอด คือต้องเผชิญหน้ากับผี และเอาชนะมันให้ได้ก่อนรุ่งสาง!",
    duration: 125,
    startdate: "25 กุมภาพันธ์ 2569",
    moviePic: "asset/image/movie_poster_ghost_box.jpg",
    category: "สยองขวัญ",
    status: "now_showing",
  ),
  movielist(
    title: "Scooby-Doo: ผจญภัยเกาะปีศาจ",
    description:
        "แก๊งไขปริศนาลึกลับ Mystery Inc. กลับมารวมตัวกันอีกครั้งบนเกาะสปู๊กกี้ เพื่อสืบหาสาเหตุที่เหล่านักท่องเที่ยวถูกล้างสมองด้วยอาคมโบราณ สกู๊บบี้และแช็กกี้ต้องรวบรวมความกล้าเผชิญหน้ากับผีตัวจริงที่ซ่อนอยู่ในเงามืด!",
    duration: 86,
    startdate: "10 มีนาคม 2569",
    moviePic: "asset/image/scoobydoo.webp",
    category: "ตลก / ผจญภัย",
    status: "now_showing",
  ),
  movielist(
    title: "The Nun II : เดอะ นัน 2",
    description:
        "ในปี 1956 ณ ประเทศฝรั่งเศส เมื่อบาทหลวงรูปหนึ่งถูกฆ่าตายอย่างปริศนา ความชั่วร้ายเริ่มแผ่ซ่านไปทั่ววิหาร ซิสเตอร์ไอรีนต้องกลับมาเผชิญหน้ากับ วาลัค (Valak) ผีแม่ชีในร่างปีศาจอีกครั้ง ในภาคต่อที่สยองขวัญและกดดันยิ่งกว่าเดิม",
    duration: 110,
    startdate: "7 มีนาคม 2569",
    moviePic: "asset/image/thenun.jpg",
    category: "สยองขวัญ / ระทึกขวัญ",
    status: "now_showing",
  ),
  movielist(
    title: "Shutter Island : เกาะนรกซ่อนทมิฬ",
    description:
        "เรื่องราวของตำรวจศาล เท็ดดี้ แดเนียลส์และคู่หูของเขา ชัค อูลที่ได้รับมอบหมายให้สืบสวนการหายตัวไปของคนไข้ในโรงพยาบาลจิตเวชบนเกาะชัตเตอร์ แต่ระหว่างการสืบสวนกลับพบกับปริศนาและความลับดำมืดที่เกาะแห่งนี้พยายามปกปิดไว้",
    duration: 139,
    startdate: "12 มีนาคม 2569",
    moviePic: "asset/image/shutter_island.jpg",
    category: "ระทึกขวัญ / ดราม่า",
    status: "now_showing",
  ),
  
  movielist(
  title: "Zootopia : นครสัตว์มหาสนุก",
  description:
      "กระต่ายตำรวจตัวแรกของเมืองสัตว์ต้องร่วมมือกับสุนัขจิ้งจอกเจ้าเล่ห์เพื่อไขคดีปริศนาในมหานครที่เต็มไปด้วยสัตว์หลากหลายสายพันธุ์",
  duration: 108,
  startdate: "12 พฤษภาคม 2569",
  moviePic: "asset/image/Zootopia.jpg",
  category: "Animation / Adventure",
  status: "coming_soon",
),

movielist(
  title: "Cars : สี่ล้อซิ่ง ชิงบัลลังก์แชมป์",
  description:
      "เรื่องราวของรถแข่งดาวรุ่งที่หลงทางไปยังเมืองเล็ก ๆ และได้เรียนรู้คุณค่าของมิตรภาพ ชีวิต และการแข่งรถที่แท้จริง",
  duration: 117,
  startdate: "25 เมษายน 2569",
  moviePic: "asset/image/Car.jpg",
  category: "Animation / Comedy",
  status: "coming_soon",
),

movielist(
  title: "Deadpool : เดดพูล",
  description:
      "อดีตหน่วยรบพิเศษที่ถูกทดลองจนมีพลังรักษาตัวเองได้ กลายเป็นฮีโร่สุดเกรียนที่ออกตามล่าคนที่ทำลายชีวิตของเขา",
  duration: 108,
  startdate: "28 กุมภาพันธ์ 2569",
  moviePic: "asset/image/Deadpool.jpg",
  category: "Action / Comedy",
  status: "now_showing",
),

movielist(
  title: "Thong Suk 13 : ทองสุก 13",
  description:
      "กลุ่มเพื่อนพานักศึกษาชื่อทองสุกไปเที่ยวเกาะ แต่เมื่อทิ้งเขาไว้กลางเกาะ พวกเขากลับต้องเผชิญเหตุการณ์สยองขวัญที่ตามหลอกหลอนอย่างไม่คาดคิด",
  duration: 104,
  startdate: "24 กันยายน 2569",
  moviePic: "asset/image/thongsuk13.jpg",
  category: "Horror / Thriller",
  status: "coming_soon",
),

movielist(
  title: "Home Alone : โดดเดี่ยวผู้น่ารัก",
  description:
      "เด็กชายที่ถูกครอบครัวลืมไว้ที่บ้านในช่วงวันหยุด ต้องปกป้องบ้านของตัวเองจากโจรสองคนด้วยแผนสุดป่วน",
  duration: 103,
  startdate: "5 เมษายน 2569",
  moviePic: "asset/image/HomeAlone.jpg",
  category: "Comedy / Family",
  status: "coming_soon",
),

movielist(
  title: "How to Train Your Dragon : อภินิหารไวกิ้งพิชิตมังกร",
  description:
      "เด็กหนุ่มไวกิ้งผู้แตกต่างจากคนอื่น ได้ผูกมิตรกับมังกรและเปลี่ยนมุมมองของเผ่าไวกิ้งที่มีต่อมังกรไปตลอดกาล",
  duration: 98,
  startdate: "22 มิถุนายน 2569",
  moviePic: "asset/image/Howtotrainyourdragon.jpg",
  category: "Animation / Fantasy",
  status: "coming_soon",
),

movielist(
  title: "Inception : จิตพิฆาตโลก",
  description:
      "หัวขโมยผู้เชี่ยวชาญในการแทรกซึมเข้าไปในความฝันของผู้อื่นได้รับภารกิจที่ยากที่สุด นั่นคือการปลูกฝังความคิดลงในจิตใต้สำนึกของเป้าหมาย",
  duration: 148,
  startdate: "1 มีนาคม 2569",
  moviePic: "asset/image/Inception.jpg",
  category: "Sci-Fi / Thriller",
  status: "now_showing",
),

movielist(
  title: "Interstellar : ทะยานดาวกู้โลก",
  description:
      "นักบินอวกาศและนักวิทยาศาสตร์ออกเดินทางผ่านรูหนอนในอวกาศเพื่อค้นหาดาวเคราะห์ใหม่ที่สามารถเป็นบ้านของมนุษยชาติ",
  duration: 169,
  startdate: "13 มีนาคม 2569",
  moviePic: "asset/image/Interstellar.jpg",
  category: "Sci-Fi / Drama",
  status: "now_showing",
),

movielist(
  title: "Oppenheimer : ออพเพนไฮเมอร์",
  description:
      "เรื่องราวชีวประวัติของนักฟิสิกส์ผู้มีบทบาทสำคัญในการสร้างระเบิดปรมาณู และผลกระทบของการค้นพบที่เปลี่ยนโลก",
  duration: 180,
  startdate: "31 มกราคม 2569",
  moviePic: "asset/image/Oppenheimer.jpg",
  category: "Biography / Drama",
  status: "now_showing",
),

movielist(
  title: "The Teacher's Diary : คิดถึงวิทยา",
  description:
      "ครูหนุ่มที่มาสอนในโรงเรียนกลางน้ำได้พบกับไดอารี่ของครูสาวคนก่อน และเริ่มผูกพันกับเรื่องราวของเธอผ่านตัวหนังสือ",
  duration: 110,
  startdate: "17 สิงหาคม 2569",
  moviePic: "asset/image/TeachersDiary.jpg",
  category: "Romance / Drama",
  status: "coming_soon",
),

movielist(
  title: "The Dark Knight : อัศวินรัตติกาล",
  description:
      "แบทแมนต้องต่อสู้กับโจ๊กเกอร์ อาชญากรอัจฉริยะที่ต้องการสร้างความโกลาหลให้กับเมืองก็อตแธม",
  duration: 152,
  startdate: "11 กุมภาพันธ์ 2569",
  moviePic: "asset/image/Thedarkknight.jpg",
  category: "Action / Crime",
  status: "now_showing",
),
  

];
