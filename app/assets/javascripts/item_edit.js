$(function(){
  var images = gon.image
  var upload_image = $(".sell-dropbox-items-edit");
  var i_count = 0;
  function edit_image(image) {
    var html = `<li class="sell-upload-item">
                  <img src="${image}" alt="画像">
                  <div class="sell-upload-button">
                    <a href="" class="sell-upload-edit">編集</a>
                    <a href="" class="sell-upload-delete">削除</a>
                  </div>
                </li>`
    upload_image.append(html);
  }
//   images.slice(0, -1).forEach((item, i) =>{
//   console.log(`${i}: ${item}`);
// });

  for (let i = 0; i < images.length -1; i++){
    var ima = images[i]
    console.log(ima.image.url)
    // ima.forEach(function(result){
    //   console.log(result)
    // })
    // console.log(ima)
    // for (let n = 0; n < images.length -1; n++){
    //   console.log(ima)
    //   var url = ima[n]
      // console.log(url)
      edit_image(ima.image.url)
    }
  var target = document.getElementById('drop');
  if (target) {
    // ドラッグ
    target.addEventListener('dragover', function (e) {
      // デフォルトアクションを抑止
      e.preventDefault();
      // 親要素へのイベントの伝播をストップ
      e.stopPropagation();
      // ドロップされた要素はローカルからのコピー
      e.dataTransfer.dropEffect = 'copy';
    });

    // ドロップ
    target.addEventListener('drop', function (e) {
      e.preventDefault();
      e.stopPropagation();
      //DataTransfer.files - ファイルの一覧
      document.getElementById('item_image'+ i_count).files = e.dataTransfer.files;
    });
  }

// ドロップ後 表示させとく
  $('.item_images').on("change",function(e) {
    for(var i = 0; i < this.files.length; i++){
      // FileReaderを作成
      var fileReader = new FileReader();
      // 読み込み完了時のイベント
      fileReader.onload = function (e) {
      //e.target.result
        edit_image(e.target.result,i_count);
      }
      // 読み込み実行readAsDataURL()は、FileReaderのメソッド
      fileReader.readAsDataURL(this.files[i]);
      i_count += 1;
      $("label.sell-dropbox-uploader-container").attr('for','item_image'+ i_count);
    }
  });
  })
