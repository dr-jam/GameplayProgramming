Shader "Black Hole" {
	Properties {
		_MainTex ("Main", 2D) = "white" {}
		_Center ("Center", Vector) = (0.5, 0.5, 0, 0)
		_Distortion ("Distortion", Float) = -2
		_DarkRange ("Dark Range", Float) = 0.1
	}
	CGINCLUDE
		#include "UnityCG.cginc"
		sampler2D _MainTex;
		float2 _Center;
		float _Distortion, _DarkRange;
		float4 frag (v2f_img i) : SV_TARGET
		{
			float2 uv = i.uv;
			float2 center = _Center * _ScreenParams.xy;
			float2 uvpixel = uv * _ScreenParams.xy;
			float dist = distance(center, uvpixel);

			float2 warp = normalize(_Center - uv) * pow(dist, _Distortion) * 30.0;
			warp.y = -warp.y;
			uv = uv + warp;
	
			float light = saturate(_DarkRange * dist - 1.5);
	
			return tex2D(_MainTex, uv) * light;
			
		}
	ENDCG
	SubShader {
		ZTest Off Cull Off ZWrite Off Blend Off
	  	Fog { Mode off }
		Pass {
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			ENDCG
		}
	}
	FallBack Off
}