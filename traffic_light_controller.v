module traffic_light_controller(
    input clk,                // Clock signal
    input reset,              // Reset signal
    input pedestrian_button,  // Pedestrian button signal
    input traffic_sensor,     // Traffic sensor signal
    output reg [2:0] main_light,   // Traffic light for main road (Red, Yellow, Green)
    output reg [2:0] side_light,   // Traffic light for side road (Red, Yellow, Green)
    output reg pedestrian_signal   // Pedestrian crossing signal
);

// State encoding
parameter RED    = 3'b100;
parameter YELLOW = 3'b010;
parameter GREEN  = 3'b001;

// State definitions
parameter S_MAIN_GREEN = 3'b000;
parameter S_MAIN_YELLOW = 3'b001;
parameter S_SIDE_GREEN = 3'b010;
parameter S_SIDE_YELLOW = 3'b011;
parameter S_PED_CROSS = 3'b100;

reg [2:0] state, next_state;
reg [15:0] timer;  // Timer for delay

// State transition
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S_MAIN_GREEN;
        timer <= 16'd0;
    end else begin
        state <= next_state;
        if (timer > 0)
            timer <= timer - 1;
    end
end

// Next state logic and output control
always @(*) begin
    case (state)
        S_MAIN_GREEN: begin
            main_light = GREEN;
            side_light = RED;
            pedestrian_signal = 0;
            if (traffic_sensor || timer == 16'd5000) // Change based on timer or sensor
                next_state = S_MAIN_YELLOW;
            else
                next_state = S_MAIN_GREEN;
        end
        S_MAIN_YELLOW: begin
            main_light = YELLOW;
            side_light = RED;
            pedestrian_signal = 0;
            if (timer == 16'd1000)
                next_state = S_SIDE_GREEN;
            else
                next_state = S_MAIN_YELLOW;
        end
        S_SIDE_GREEN: begin
            main_light = RED;
            side_light = GREEN;
            pedestrian_signal = 0;
            if (pedestrian_button || timer == 16'd5000) // Change based on timer or pedestrian button
                next_state = S_SIDE_YELLOW;
            else
                next_state = S_SIDE_GREEN;
        end
        S_SIDE_YELLOW: begin
            main_light = RED;
            side_light = YELLOW;
            pedestrian_signal = 0;
            if (timer == 16'd1000)
                next_state = S_PED_CROSS;
            else
                next_state = S_SIDE_YELLOW;
        end
        S_PED_CROSS: begin
            main_light = RED;
            side_light = RED;
            pedestrian_signal = 1;
            if (timer == 16'd3000)
                next_state = S_MAIN_GREEN;
            else
                next_state = S_PED_CROSS;
        end
        default: begin
            next_state = S_MAIN_GREEN;
        end
    endcase
end
endmodule
