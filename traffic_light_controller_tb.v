`timescale 1ns/1ps
module traffic_light_controller_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg pedestrian_button;
    reg traffic_sensor;
    wire [2:0] main_light;
    wire [2:0] side_light;
    wire pedestrian_signal;

    // Instantiate the Traffic Light Controller module
    traffic_light_controller uut (
        .clk(clk),
        .reset(reset),
        .pedestrian_button(pedestrian_button),
        .traffic_sensor(traffic_sensor),
        .main_light(main_light),
        .side_light(side_light),
        .pedestrian_signal(pedestrian_signal)
    );

    // Clock generation (100 MHz)
    always #5 clk = ~clk;  // 10ns period

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;            // Assert reset
        pedestrian_button = 0; 
        traffic_sensor = 0;

        // Hold reset for a while to ensure proper initialization
        #20 reset = 0;         // Deassert reset after 20ns

        // Test traffic sensor activation after reset
        #50 traffic_sensor = 1; // Traffic sensor active
        #100 traffic_sensor = 0; // Traffic sensor inactive

        // Test pedestrian button press after some time
        #100 pedestrian_button = 1;
        #50 pedestrian_button = 0; // Button released after 50ns

        // Further simulation to see system behavior over time
        #300 traffic_sensor = 1;   // Traffic sensor active again
        #50 pedestrian_button = 1; // Pedestrian button pressed
        #20 pedestrian_button = 0; // Button released
        #100 traffic_sensor = 0;   // Traffic sensor inactive

        // Allow simulation to run for a while
        #1000;

        // End simulation
        $finish;
    end

    // Monitor the inputs and outputs
    initial begin
        $monitor("Time=%0t | clk=%b | reset=%b | pedestrian_button=%b | traffic_sensor=%b | main_light=%b | side_light=%b | pedestrian_signal=%b", 
                  $time, clk, reset, pedestrian_button, traffic_sensor, main_light, side_light, pedestrian_signal);
    end

endmodule
