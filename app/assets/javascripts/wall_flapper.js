var FlapBuffer = function(wrap, num_lines) {
    this.wrap = wrap;
    this.num_lines = num_lines;
    this.line_buffer = '';
    this.buffers = [[]];
    this.cursor = 0;
};

FlapBuffer.prototype = {

    pushLine: function(line) {

        if (this.buffers[this.cursor].length < this.num_lines) {
           this.buffers[this.cursor].push(line);
        } else {
            this.buffers.push([]);
            this.cursor++;
            this.pushLine(line);
        } 
    },

    pushWord: function(word) {
        if (this.line_buffer.length === 0) {
            this.line_buffer = word;
        } else if ((word.length + this.line_buffer.length + 1) <= this.wrap) {
            this.line_buffer += ' ' + word;
        } else {
            this.pushLine(this.line_buffer);
            this.line_buffer = word;
        }
    },

    flush: function() {
        if (this.line_buffer.length) {
            this.pushLine(this.line_buffer);
            this.line_buffer = '';
        }
        while (this.buffers[this.buffers.length -1].length < this.num_lines) {
            this.pushLine("");
        }

    },

};

var FlapDemo = function(display_selector, input_selector, click_selector) {
    var _this = this;
    var window_width = $(window).width();
    var digits_per_line = 19;
    if (window_width < 720) { digits_per_line = 10; } else
    if (window_width > 1045 && window_width < 1290) { digits_per_line = 24; } else
    if (window_width > 1290 && window_width < 1550) { digits_per_line = 25; } else
    if (window_width > 1550) { digits_per_line = 30; }
    // var digits_per_line = 10;
    // if (window_width < 741) { digits_per_line = 10; } else
    // if (window_width > 740 && window_width < 1026) { digits_per_line = 24; } else
    // if (window_width > 1025) { digits_per_line = 32; }
    // ?? over 1290px   -    you could probably go around 50 blocks depending on block size


    var onAnimStart = function(e) {
        var $display = $(e.target);
        $display.prevUntil('.flapper', '.activity').addClass('active');
    };

    var onAnimEnd = function(e) {
        var $display = $(e.target);
        $display.prevUntil('.flapper', '.activity').removeClass('active');
    };

    this.opts = {
        chars_preset: 'alphanum',
        align: 'left',
        width: digits_per_line,
        on_anim_start: onAnimStart,
        on_anim_end: onAnimEnd
    };

    this.timers = [];

    this.$displays = $(display_selector);
    this.num_lines = this.$displays.length;

    this.line_delay = 500;
    // alters the amount of time btwn screen refreshes
    this.screen_delay = 11500;

    this.$displays.flapper(this.opts);

    this.$typesomething = $(input_selector);

    var text = _this.cleanInput(_this.$typesomething.text());

    var buffers = _this.parseInput(text);

    _this.stopDisplay();
    _this.updateDisplay(buffers);
};

FlapDemo.prototype = {

    cleanInput: function(text) {
        return text.trim().toUpperCase();
    },

    parseInput: function(text) {
        var buffer = new FlapBuffer(this.opts.width, this.num_lines);
        var lines = text.split(/\n/);

        for (var i in lines) {
            var words = lines[i].split(/\s/);
            for (var j in words) {
                buffer.pushWord(words[j]);
            }
            buffer.flush();
        }

        buffer.flush();
        return buffer.buffers;
    },

    stopDisplay: function() {
        for (var i in this.timers) {
            clearTimeout(this.timers[i]);
        }

        this.timers = [];
    },

    updateDisplay: function(buffers) {
        var _this = this;
        var timeout = 100;

        for (var i in buffers) {

            _this.$displays.each(function(j) {

                var $display = $(_this.$displays[j]);

                (function(i,j) {
                    _this.timers.push(setTimeout(function(){
                        if (buffers[i][j]) {
                            $display.val(buffers[i][j]).change();
                        } else {
                            $display.val('').change();
                        }
                    }, timeout));
                } (i, j));

                timeout += _this.line_delay;
            });

            timeout += _this.screen_delay;
        }
    }

};

$(document).ready(function(){
  new FlapDemo('.display', '#current_batch_of_messages', '#message_review');
});
