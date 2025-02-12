import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _history = [
    {
      "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3ptSvyhlI6mkEM1kkVUlqP15QN4_8MHg5uA&s",
      "title": "Title 1",
      "content": "Lịch sử 1"
    },
    {
      "img": "https://invalid-url.com/image.jpg",
      "title": "Title 1",
      "content": "Lịch sử 2"
    },
    {
      "img": "https://www.drugs.com/health-guide/images/3c7b18a8-c266-455c-b552-dd660d9fac50.jpg",
      "title": "Title 1",
      "content": "Lịch sử 2"
    },
    {
      "img": "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      "title": "Title 1",
      "content": "Lịch sử 2"
    },
    {
      "img": "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      "title": "Title 1",
      "content": "Lịch sử 2"
    },
    {
      "img": "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      "title": "Title 1",
      "content": "Lịch sử 2"
    },
    {
      "img": "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      "title": "Title 1",
      "content": "Lịch sử 2"
    },
    {
      "img": "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      "title": "Title 1",
      "content": "Lịch sử 2"
    },
    {
      "img": "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      "title": "Title 1",
      "content": "Lịch sử 2"
    },
  ];

  void _showDeleteDialog(int index){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Xác nhận xóa'),
            content: Text('Bạn có chắc chắn muốn xóa mục này không'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")
              ),
              TextButton(
                  onPressed: (){
                    setState(() {
                      _history.removeAt(index);
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red
                    ),
                  )
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('History'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_outlined, color: Colors.black, size: 30,))
        ],
      ),
      body: ListView.builder(
        itemCount: _history.length,
          itemBuilder: (context, index){
            bool isSelected = index == _selectedIndex;
            return GestureDetector(
              onTap: (){
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  child:  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            _history[index]["img"] ?? "https://via.placeholder.com/110",
                            width:70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 70,
                                height: 70,
                                color: Colors.grey.shade300,
                                child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                _history[index]["title"] ?? "Unknow"
                            ),
                            Text(
                                _history[index]["content"] ?? "Unknow"
                            )
                          ],
                        ),
                        Spacer(),
                        // IconButton(
                        //     onPressed: (){},
                        //     icon: Icon(Icons.more_horiz_outlined)
                        // )
                        PopupMenuButton<String>(
                            onSelected: (value){
                              if(value == 'delete'){
                                _showDeleteDialog(index);
                              }
                            },
                            itemBuilder: (BuildContext context)=>[
                              PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text("Xóa"),
                                    ],
                                  )
                              )
                            ]
                        )
                      ],
                    ),
                  )
                ),
              ),
            );
          }
      ),
    );
  }
}
