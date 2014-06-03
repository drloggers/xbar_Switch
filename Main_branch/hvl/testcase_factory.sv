// Testcase factory

class testcase_factory;
  
  
  
  static function stimulus_gen return_testcase(string testcase);
    begin
      
      no_contention no_contention;
      only_one_valid only_one_valid;
      assert_test assert_test;
      half_contention half_contention;
      contention_by_invalid_frame contention_by_invalid_frame;
      no_valid_packets no_valid_packets;
      random_packets random_packets;
      message message;
      case(testcase)
        "no_contention":  
                       begin
                        no_contention=new();
                        return no_contention;
                      end
       "only_one_valid":
                        begin
                        only_one_valid=new();
                        return only_one_valid;
                        end
       "assert_test":
                        begin
                          assert_test = new();
                          return assert_test;
                        end
       "half_contention":
                        begin
                          half_contention = new();
                          return half_contention;
                        end
       "contention_by_invalid_frame": 
                        begin
                          contention_by_invalid_frame = new();
                          return contention_by_invalid_frame;
                        end
       "no_valid_packets": 
                        begin
                          no_valid_packets = new();
                          return no_valid_packets;
                        end
        "random_packets":
                        begin
                          random_packets = new();
                          return random_packets;
                        end
        "message":
                        begin
                          message = new();
                          return message;
                        end
        default:        begin
                          $fatal("Invalid Class Demand. Exiting.");
                          $finish();
                        end
                endcase
    end
  endfunction


endclass