Shader "Custom/Reflections"
{
  Properties
  {
    _MainTex ("Daytime", CUBE) = ""{}
    _DecalTex ("Nighttime", CUBE) = ""{}
    _Blending ("Blend Factor", Range(0,1)) = 1.0
    _Transparency ("Min Transparency", Range(0,1)) = 1.0
    _Glossiness ("Silhouette enhancement", Range(1,10)) = 1.0
  }
  SubShader {
    Tags {"Queue"="Transparent"  }
    
    Pass {
      ZWrite Off
      Blend SrcAlpha OneMinusSrcAlpha

      CGPROGRAM

      #pragma vertex vert
      #pragma fragment frag

      uniform samplerCUBE _MainTex;
      uniform samplerCUBE _DecalTex;
      uniform float _Blending;
      uniform float _Transparency;
      uniform float _Glossiness;

      struct vertexInput {
        float4 pos : POSITION;
        float3 normal : NORMAL;
      };

      struct vertexOutput {
        float4 screenPos : SV_POSITION;
        float3 normalDir : TEXCOORD0;
        float3 viewDir : TEXCOORD1;
      };

      vertexOutput vert(vertexInput input){
        vertexOutput output;

        output.viewDir = mul(unity_ObjectToWorld, input.pos).xyz - _WorldSpaceCameraPos;
        output.normalDir = normalize(mul(float4(input.normal, 0.0), unity_WorldToObject).xyz); //Convert normals from Object Coords to World Coords (modelMatrixInverse).
        output.screenPos = UnityObjectToClipPos(input.pos);

        return output;
      }

      float4 frag(vertexOutput input) : COLOR{

        float3 reflected = reflect(input.viewDir, input.normalDir);

        float3 mainTexPoint = texCUBE(_MainTex, reflected);
        float3 decalTexPoint = texCUBE(_DecalTex, reflected);
        //Blending between mainTex and decalTex depending on _blending.
        float3 color = (1-_Blending) * mainTexPoint + _Blending * decalTexPoint;
        //Calcultes alpha based on brightness of reflection taking into account the minimum Transparency
        float alpha = (1-_Transparency) + _Transparency * (0.2126*color.r + 0.7152*color.g + 0.0722*color.b);
        float enhancement = abs(dot(normalize(input.viewDir), input.normalDir)) * _Glossiness; //https://en.wikibooks.org/wiki/Cg_Programming/Unity/Silhouette_Enhancement
        alpha = min(1.0, alpha / enhancement); 

        //!!! == !!!
        //Alpha looks kinda crappy with jagged edges. Maybe use a different luminocity function?
        //Could be combined with a fresnell effect. Stronger reflection towards the "edges"


        return float4(color, alpha);
      }

      ENDCG
    }
  }

  //FallBack "Diffuse"
}
