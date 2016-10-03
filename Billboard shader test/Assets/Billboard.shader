Shader "Custom/Billboard"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Tint("Tint", Color) = (1,1,1,1)
	}
	Category {
    	ZWrite Off
      	Cull Back
    	Blend SrcAlpha OneMinusSrcAlpha
    	Tags {Queue=Transparent}
		SubShader
		{
			Tags { "RenderType"="Transparent" "DisableBatching"="True"}
			LOD 100

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_fog
				
				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					UNITY_FOG_COORDS(1)
					float4 vertex : SV_POSITION;
				};

				sampler2D _MainTex;
				float4 _MainTex_ST;
				fixed4 _Tint;
			
				v2f vert(appdata v) {
			       	v2f o;
					float4x4 mv = UNITY_MATRIX_MV;

					// modify matrix
					mv._m00 = 1.0f; 
					mv._m10 = 0.0f; 
					mv._m20 = 0.0f; 
					mv._m01 = 0.0f; 
					mv._m11 = 1.0f; 
					mv._m21 = 0.0f; 
					mv._m02 = 0.0f; 
					mv._m12 = 0.0f; 
					mv._m22 = 1.0f; 
							
				    o.vertex = mul(UNITY_MATRIX_P, mul(mv, v.vertex));
			      	o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					UNITY_TRANSFER_FOG(o,o.vertex);
					return o;
				}
				
				fixed4 frag (v2f i) : SV_Target
				{
					fixed4 col = tex2D(_MainTex, i.uv) * _Tint;
					UNITY_APPLY_FOG(i.fogCoord, col);
					return col;
				}
				ENDCG
			}
		}
	}
}
