$(document).ready(function(){
    
    load = function(type,date,mode) {
      $.post("load", {type: type, date: date}, function(data) {
        
        episode_json = jQuery.parseJSON(data);
        
        $('textarea#episode_body').val(episode_json.body);
        $('input#date').val(episode_json.date);
        $('input#type').val(episode_json.type);
        
        $('#type').text(episode_json.type.replace(/^\w/, function($0) { return $0.toUpperCase(); }));
        $('#start_date').text(episode_json.date);
        $('#end_date').text(episode_json.end_date);
        
        update_info_box();
        
      });
    };
    
    save = function() {
      if (changed) {
        var new_body = $('textarea#episode_body').val();
        var date = $('input#date').val();
        var type = $('input#type').val();
        
        $.post("save", {new_body: new_body, date: date, type: type}, function(success) {
          update_info_box();
        });
      };
    };
    
    update_info_box = function() {
      changed = false;
      update_count();
      update_time();
    };
    
    update_count = function() {
      var to_count = $('textarea#episode_body').val()
      
      if(to_count === '') {
        var count = 0;
      } else {
        var count = jQuery.trim(to_count).split(/ |\n/).length;
      };
      
      $('#word_count').text(count);
    };
    
    update_time = function() {
      var time=new Date();
      var h=time.getHours()+'';
      var m=time.getMinutes()+'';
      var s=time.getSeconds()+'';
      
      if (h.length < 2) { h = 0 + h };
      if (m.length < 2) { m = 0 + m };
      if (s.length < 2) { s = 0 + s };
      
      $('#last_saved').text(h + ':' + m + ':' + s);
    };
    
    // -----------------------------------------------------
    
    $('a#save').click(function(event) {
      save();
    });
    
    $('a.type_switch').click(function(event) {
      save();
      
      var new_type = $(this).html().toLowerCase();
      load(new_type);
      
    });
    
    $('textarea#episode_body').each(function() {
      $(this).bind('keyup change paste', function() {
        update_count();
        changed = true;
        
        text_changes += 1;
        if (text_changes > 50) {
          save();
          text_changes = 0;
        };
        
      });
      
    });
    
    // -----------------------------------------------------
    
    
    var text_changes = 0;
    var changed = false;
    
    load();
    
    update_count();
    update_time();
    
  });