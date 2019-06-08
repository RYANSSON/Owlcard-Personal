
$(document).ready(function () {
    $(".clickable").on('click', function () {

        var number = this.closest('tr.mainTableRow').id;
        var row = this.closest('tr.mainTableRow');
        var id = document.getElementById("tdID" + number.toString()).innerText;
        var date = document.getElementById("tdDate" + number.toString()).innerText;
      
        document.getElementById("body_ValueHiddenField").value = number.toString() + "." + id.toString() + "." + date;
        
            document.getElementById("body_modalForm").click();

        });
    });

         function modalClose() {
        document.getElementById("body_btnClose").click();
    }
         function modalClose2() {
        document.getElementById("body_btnClose2").click();
    }
  