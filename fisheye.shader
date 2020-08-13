uniform int center_x_percent = 50;
uniform int center_y_percent = 50;
uniform float power = 1.75;

float4 mainImage(VertData v_in) : TARGET
{
    float2 center_pos = float2(center_x_percent * .01, center_y_percent * .01);
    float b = 0.0;
    if (power > 0.0){
        b = sqrt(dot(center_pos, center_pos));
    }else {
        if (uv_pixel_interval.x < uv_pixel_interval.y){
            b = center_pos.x;
        }else{
            b = center_pos.y;
        }
    }
    float2 uv;
    if (power > 0.0)
        uv = center_pos  + normalize(v_in.uv - center_pos) * tan(distance(center_pos, v_in.uv) * power) * b / tan( b * power);
    else if (power < 0.0)
        uv = center_pos  + normalize(v_in.uv - center_pos) * atan(distance(center_pos, v_in.uv) * -power * 10.0) * b / atan(-power * b * 10.0);
    else 
        uv = v_in.uv ;
    return image.Sample(textureSampler, uv);
}