Shader "GPUInstancer/Universal Render Pipeline/Nature/SpeedTree7"
{
    Properties
    {
        _Color("Main Color", Color) = (1,1,1,1)
        _HueVariation("Hue Variation", Color) = (1.0,0.5,0.0,0.1)
        _MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
        _DetailTex("Detail", 2D) = "black" {}
        _BumpMap("Normal Map", 2D) = "bump" {}
        _Cutoff("Alpha Cutoff", Range(0,1)) = 0.333
        [MaterialEnum(Off,0,Front,1,Back,2)] _Cull("Cull", Int) = 2
        [MaterialEnum(None,0,Fastest,1,Fast,2,Better,3,Best,4,Palm,5)] _WindQuality("Wind Quality", Range(0,5)) = 0
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "IgnoreProjector" = "True"
            "RenderType" = "Opaque"
            "DisableBatching" = "LODFading"
            "RenderPipeline" = "UniversalPipeline"
            "UniversalMaterialType" = "SimpleLit"
        }
        LOD 400
        Cull [_Cull]

        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode" = "UniversalForward" }

            HLSLPROGRAM

            #pragma vertex SpeedTree7Vert
            #pragma fragment SpeedTree7Frag

            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile _ _SHADOWS_SOFT
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile_vertex LOD_FADE_PERCENTAGE
            #pragma multi_compile_fog


            #pragma shader_feature_local GEOM_TYPE_BRANCH GEOM_TYPE_BRANCH_DETAIL GEOM_TYPE_FROND GEOM_TYPE_LEAF GEOM_TYPE_MESH
            #pragma shader_feature_local EFFECT_BUMP
            #pragma shader_feature_local EFFECT_HUE_VARIATION

            #define ENABLE_WIND
            #define VERTEX_COLOR

            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Input.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Passes.hlsl"

            
#include "./../../Shaders/Include/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
ENDHLSL
        }

        Pass
        {
            Name "SceneSelectionPass"
            Tags{"LightMode" = "SceneSelectionPass"}

            HLSLPROGRAM

            #pragma vertex SpeedTree7VertDepth
            #pragma fragment SpeedTree7FragDepth


            #pragma shader_feature_local GEOM_TYPE_BRANCH GEOM_TYPE_BRANCH_DETAIL GEOM_TYPE_FROND GEOM_TYPE_LEAF GEOM_TYPE_MESH

            #define ENABLE_WIND
            #define DEPTH_ONLY
            #define SCENESELECTIONPASS

            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Input.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Passes.hlsl"
            
#include "./../../Shaders/Include/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
ENDHLSL
        }

        Pass
        {
            Name "ShadowCaster"
            Tags{"LightMode" = "ShadowCaster"}

            ColorMask 0

            HLSLPROGRAM

            #pragma vertex SpeedTree7VertDepth
            #pragma fragment SpeedTree7FragDepth

            #pragma multi_compile_vertex LOD_FADE_PERCENTAGE


            #pragma shader_feature_local GEOM_TYPE_BRANCH GEOM_TYPE_BRANCH_DETAIL GEOM_TYPE_FROND GEOM_TYPE_LEAF GEOM_TYPE_MESH

            #define ENABLE_WIND
            #define DEPTH_ONLY
            #define SHADOW_CASTER

            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Input.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Passes.hlsl"
            
#include "./../../Shaders/Include/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
ENDHLSL
        }

        Pass
        {
            Name "GBuffer"
            Tags{"LightMode" = "UniversalGBuffer"}

            HLSLPROGRAM

            #pragma exclude_renderers gles
            #pragma vertex SpeedTree7Vert
            #pragma fragment SpeedTree7Frag

            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            //#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            //#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile _ _SHADOWS_SOFT
            #pragma multi_compile_vertex LOD_FADE_PERCENTAGE
            #pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT


            #pragma shader_feature_local GEOM_TYPE_BRANCH GEOM_TYPE_BRANCH_DETAIL GEOM_TYPE_FROND GEOM_TYPE_LEAF GEOM_TYPE_MESH
            #pragma shader_feature_local EFFECT_BUMP
            #pragma shader_feature_local EFFECT_HUE_VARIATION

            #define ENABLE_WIND
            #define VERTEX_COLOR
            #define GBUFFER

            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Input.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Passes.hlsl"

            
#include "./../../Shaders/Include/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
ENDHLSL
        }

        Pass
        {
            Name "DepthOnly"
            Tags{"LightMode" = "DepthOnly"}

            ColorMask 0

            HLSLPROGRAM

            #pragma vertex SpeedTree7VertDepth
            #pragma fragment SpeedTree7FragDepth

            #pragma multi_compile_vertex LOD_FADE_PERCENTAGE


            #pragma shader_feature_local GEOM_TYPE_BRANCH GEOM_TYPE_BRANCH_DETAIL GEOM_TYPE_FROND GEOM_TYPE_LEAF GEOM_TYPE_MESH

            #define ENABLE_WIND
            #define DEPTH_ONLY

            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Input.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Passes.hlsl"

            
#include "./../../Shaders/Include/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
ENDHLSL
        }

        // This pass is used when drawing to a _CameraNormalsTexture texture
        Pass
        {
            Name "DepthNormals"
            Tags{"LightMode" = "DepthNormals"}

            HLSLPROGRAM
            #pragma vertex SpeedTree7VertDepthNormal
            #pragma fragment SpeedTree7FragDepthNormal

            #pragma multi_compile_vertex LOD_FADE_PERCENTAGE


            #pragma shader_feature_local GEOM_TYPE_BRANCH GEOM_TYPE_BRANCH_DETAIL GEOM_TYPE_FROND GEOM_TYPE_LEAF GEOM_TYPE_MESH
            #pragma shader_feature_local EFFECT_BUMP

            #define ENABLE_WIND

            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Input.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/Nature/SpeedTree7Passes.hlsl"

            
#include "./../../Shaders/Include/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
ENDHLSL
        }
    }

    Dependency "BillboardShader" = "GPUInstancer/Universal Render Pipeline/Nature/SpeedTree7 Billboard"
    CustomEditor "SpeedTreeMaterialInspector"
}
