// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Utils"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		AlphaToMask On
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#define ASE_USING_SAMPLING_MACROS 1
		struct Input
		{
			half filler;
		};

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			AlphaToMask Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18934
2446.5;-391.3333;1535;807;3572.392;-2128.762;1;True;True
Node;AmplifyShaderEditor.LerpOp;179;-506.2903,2741.812;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-2054.052,1261.868;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;73;-2080.882,525.8525;Inherit;False;Property;_Noise_Contrast;Noise_Contrast;4;0;Create;True;0;0;0;False;0;False;4.26;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;54;-1798.128,-752.1129;Inherit;False;Property;_Noise_Direction;Noise_Direction;3;0;Create;True;0;0;0;False;0;False;0.1,0.1;0.1,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;64;-1856.174,201.4009;Inherit;True;22;Transition_Gradient;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;16;-1834.157,-316.2034;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;101;-1296.323,-2232.664;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;69;-1521.152,543.8632;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;22;-694.5742,-180.0264;Inherit;True;Transition_Gradient;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;21;-897.3235,-178.0127;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;79;-1072.929,-691.1791;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;77;-906.9833,215.083;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;84;-1699.56,990.4833;Inherit;True;2;1;COLOR;0,0,0,0;False;0;FLOAT;2.61;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;88;-2015.767,-620.3312;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;68;-1289.275,360.198;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PiNode;167;-1963.073,2543.088;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;27;-1222.685,987.705;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;162;-2393.175,2929.266;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;183;-2498.392,2736.429;Inherit;False;Constant;_Offset_Initial_Value;Offset_Initial_Value;16;0;Create;True;0;0;0;False;0;False;-0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;153;-2083.817,1943.285;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;157;-1331.968,1893.944;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;136;-2525.391,-1760.421;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;131;-712.3824,-1362.051;Inherit;False;Property;_Step_Range;Step_Range;16;0;Create;True;0;0;0;False;0;False;1.2;1.67;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-548.0907,-2330.203;Inherit;False;Property;_Distortion_Contrast;Distortion_Contrast;12;0;Create;True;0;0;0;False;0;False;2;0;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;100;-1770.192,-2204.134;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;79.72747,-2568.514;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;-700.2848,208.0349;Inherit;True;Noise_Transition;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;159;-1155.165,1906.795;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-2084.108,918.8848;Inherit;False;Property;_Hard_Noise_Contrast;Hard_Noise_Contrast;6;0;Create;True;0;0;0;False;0;False;0.5;0.95;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-2030.38,1025.738;Inherit;True;41;Noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;52;-1544.546,-668.488;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-3084.83,-2091.269;Inherit;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-1618.696,-2521.538;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SmoothstepOpNode;126;-800.2301,-1260.482;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-2015.378,-543.2391;Inherit;False;Constant;_Noise_Speed;Noise_Speed;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;20;-1168.479,-175.7503;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-1764.874,-618.5085;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;94;-2527.833,-2590.401;Inherit;True;Property;_DistortionMap;Distortion Map;8;0;Create;True;0;0;0;False;0;False;None;None;False;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleAddOpNode;67;-1056.164,215.3989;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-869.0149,977.2805;Inherit;False;Hard_Noise_Step_Transition;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;180;-817.9655,2576.426;Inherit;False;Property;_Wave_Color_3;Wave_Color_02;10;0;Create;True;0;0;0;False;0;False;0,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;96;-2244.237,-2582.91;Inherit;True;Property;_TextureSample1;Texture Sample 1;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;104;-2716.43,-2228.669;Inherit;False;3;0;FLOAT2;1,1;False;2;FLOAT2;0.12,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;92;-1315.53,-2735.468;Inherit;True;Property;_Mask;Mask;7;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-1541.134,300.0779;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-3173.114,-1538.301;Inherit;False;Property;_Heat_Dist_Speed;Heat_Dist_Speed;14;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1709.461,1455.887;Inherit;False;Property;_Hard_Noise_Point;Hard_Noise_Point;2;0;Create;True;0;0;0;False;0;False;0;-0.22;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;144;-2979.513,-1643.201;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1849.489,-83.39599;Inherit;False;Property;_Transition_Point;Transition_Point;0;0;Create;True;0;0;0;False;0;False;0;-0.6;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-1330.789,-688.2859;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;97;-1877.946,-2577.665;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;170;-1827.483,2712.249;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;164;-2236.115,2934.003;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;152;-2054.323,1767.35;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;158;-1636.349,2089.26;Inherit;False;Property;_Cam_Depth_Falloff;Cam_Depth_Falloff;22;0;Create;True;0;0;0;False;0;False;0;5.24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;133;22.64835,-1615.859;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;135;-2239.744,-1805.523;Inherit;True;Property;_TextureSample3;Texture Sample 3;13;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;138;-1493.053,-1661.865;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;130;-484.0155,-1428.301;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;128;-1204.472,-1705.114;Inherit;True;Property;_TextureSample2;Texture Sample 2;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;132;-237.9823,-1553.751;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;137;-2755.913,-1696.944;Inherit;False;3;0;FLOAT2;1,1;False;2;FLOAT2;0,-0.5;False;1;FLOAT;0.1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;139;-1805.427,-1528.229;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-786.127,-687.9739;Inherit;False;Noise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-1935.122,-2425.45;Inherit;False;Property;_DistortionAmount;Distortion Amount;11;0;Create;True;0;0;0;False;0;False;0.5;1.94;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;81;-1554.396,-837.6245;Inherit;False;Property;_Noise_Tiling;Noise_Tiling;5;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;66;-2098.336,312.3396;Inherit;True;41;Noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;120;787.4155,-1772.26;Inherit;False;Distortion_Noise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;134;307.6206,-1773.89;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-1485.121,1236.455;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-1186.355,-1437.058;Inherit;False;Property;_Step_Transition;Step_Transition;19;0;Create;True;0;0;0;False;0;False;0.11;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;166;-2275.39,2536.721;Inherit;False;Property;_Wave_Frequency1;Wave_Frequency;15;0;Create;True;0;0;0;False;0;False;1;0;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;184;-2256.392,2794.429;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;163;-2598.447,2812.812;Inherit;False;Property;_Wave_Offset1;Wave_Offset;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;175;-1643.814,2957.393;Inherit;False;Property;_Wave_Sharpness1;Wave_Sharpness;17;0;Create;True;0;0;0;False;0;False;0.1;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1507.812,-22.787;Inherit;False;Property;_Transition_Range;Transition_Range;1;0;Create;True;0;0;0;False;0;False;1;4.6;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;168;-2148.081,2635.696;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;108;-2512.857,-2271.506;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;111;-2012.308,-2174.493;Inherit;False;3;0;FLOAT2;1,1;False;2;FLOAT2;1,0.12;False;1;FLOAT;0.2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;156;-1490.737,1896.529;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;125;-652.2104,-1698.83;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;161;-2620.609,3000.279;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;154;-1685.678,1838.437;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-1605.05,2650.792;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;172;-1359.164,2640.389;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;-1315.114,2897.907;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;177;-1485.03,3060.229;Inherit;False;Property;_Wave_Transition1;Wave_Transition;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;178;-769.8217,2784.108;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;176;-1039.153,2788.593;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;72;-1845.303,414.157;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;7.65;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;165;-2044.712,2834.997;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;747.3226,438.5878;Inherit;False;120;Distortion_Noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;169;-2691.966,2893.597;Inherit;False;Property;_Wave_Speed1;Wave_Speed;21;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;181;-816.8632,2376.663;Inherit;False;Property;_Wave_Color_2;Wave_Color_01;9;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;105;-3110.53,-2198.668;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-2891.23,-2196.169;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;143;-3198.813,-1645.7;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;140;-1912.335,-1807.194;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;93;-969.3513,-2571.54;Inherit;True;Property;_TextureSample0;Texture Sample 0;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1461.328,-256.4551;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;155;-1745.187,1968.789;Inherit;False;Property;_Cam_Depth_Distance;Cam_Depth_Distance;20;0;Create;True;0;0;0;False;0;False;0;8.26;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;173;-1576.86,2876.012;Inherit;False;Constant;_Float1;Float 0;16;0;Create;True;0;0;0;False;0;False;-10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;113;-189.3625,-2564.538;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1020.978,107.0547;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Utils;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;112;-2062.308,-2254.134;Inherit;False;534.5162;236.8411;Original UV;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;15;-1902.993,-386.0953;Inherit;False;1462.929;512.2972;Transition_Gradient;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;103;-2577.833,-2640.401;Inherit;False;1121.534;330.351;Distort UV;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;87;-2134.107,868.8847;Inherit;False;1563.491;702.4026;Hard_Noise_Transition;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;91;-2065.767,-887.6245;Inherit;False;1504.44;459.7854;Noise;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;78;-2148.336,151.4009;Inherit;False;1672.851;645.8621;Noise_Transition;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;151;-3248.813,-1857.194;Inherit;False;3791.834;850.1119;Heat_Distortion;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;160;-2133.817,1717.35;Inherit;False;1149.452;487.3098;Cam_Depth;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;182;-2741.966,2326.663;Inherit;False;2501.342;848.5667;Gradient_Colorize;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;116;-597.0907,-2618.514;Inherit;False;912.2181;450.7111;Contrast;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;121;-3160.53,-2785.468;Inherit;False;3861.221;809.5987;Distortion_Noise;0;;1,1,1,1;0;0
WireConnection;179;0;181;0
WireConnection;179;1;180;0
WireConnection;179;2;178;0
WireConnection;101;0;98;0
WireConnection;101;1;100;0
WireConnection;69;0;64;0
WireConnection;22;0;21;0
WireConnection;21;0;20;0
WireConnection;79;0;49;0
WireConnection;77;0;67;0
WireConnection;84;1;42;0
WireConnection;84;0;86;0
WireConnection;68;0;65;0
WireConnection;68;1;69;0
WireConnection;167;0;166;0
WireConnection;27;0;84;0
WireConnection;27;1;43;0
WireConnection;162;0;169;0
WireConnection;162;1;161;0
WireConnection;157;0;156;0
WireConnection;157;1;158;0
WireConnection;136;1;137;0
WireConnection;100;1;111;0
WireConnection;114;0;113;0
WireConnection;114;1;115;0
WireConnection;70;0;77;0
WireConnection;159;0;157;0
WireConnection;52;2;54;0
WireConnection;52;1;89;0
WireConnection;98;0;97;0
WireConnection;98;1;99;0
WireConnection;126;0;128;1
WireConnection;126;2;127;0
WireConnection;20;0;19;0
WireConnection;20;1;18;0
WireConnection;89;0;88;0
WireConnection;89;1;90;0
WireConnection;67;0;64;0
WireConnection;67;1;68;0
WireConnection;83;0;27;0
WireConnection;96;0;94;0
WireConnection;96;1;108;0
WireConnection;104;1;106;0
WireConnection;65;0;64;0
WireConnection;65;1;72;0
WireConnection;144;0;143;0
WireConnection;144;1;145;0
WireConnection;49;0;81;0
WireConnection;49;1;52;0
WireConnection;97;0;96;0
WireConnection;170;0;168;2
WireConnection;170;2;165;0
WireConnection;164;0;162;0
WireConnection;133;0;125;0
WireConnection;133;1;132;0
WireConnection;135;0;94;0
WireConnection;135;1;136;0
WireConnection;138;0;140;0
WireConnection;138;1;139;0
WireConnection;130;0;127;0
WireConnection;130;1;131;0
WireConnection;128;0;92;0
WireConnection;128;1;138;0
WireConnection;132;0;128;1
WireConnection;132;1;130;0
WireConnection;137;1;144;0
WireConnection;41;0;79;0
WireConnection;120;0;134;0
WireConnection;134;0;125;0
WireConnection;134;1;133;0
WireConnection;43;0;32;1
WireConnection;43;1;44;0
WireConnection;184;0;183;0
WireConnection;184;1;163;0
WireConnection;108;1;104;0
WireConnection;156;0;154;0
WireConnection;156;1;155;0
WireConnection;125;0;128;1
WireConnection;125;1;127;0
WireConnection;154;0;152;0
WireConnection;154;1;153;0
WireConnection;171;0;167;0
WireConnection;171;1;170;0
WireConnection;172;0;171;0
WireConnection;174;0;173;0
WireConnection;174;1;175;0
WireConnection;178;0;176;0
WireConnection;176;0;172;0
WireConnection;176;1;174;0
WireConnection;176;2;177;0
WireConnection;72;1;66;0
WireConnection;72;0;73;0
WireConnection;165;0;184;0
WireConnection;165;1;164;0
WireConnection;106;0;105;0
WireConnection;106;1;107;0
WireConnection;140;0;135;0
WireConnection;93;0;92;0
WireConnection;93;1;101;0
WireConnection;19;0;16;2
WireConnection;19;1;17;0
WireConnection;113;0;93;0
WireConnection;113;1;115;0
ASEEND*/
//CHKSM=ACBA4EE8E433A347A5FB0A79126A2FA4E3ABDD64