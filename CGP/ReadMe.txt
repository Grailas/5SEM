To use the shader:
- Copy the file into your Unity Project
- Create a new material in Unity using the shader
- In the material, apply two different cubemaps
- Apply the material to objects

Included in the folder is UglyPanorama.jpg, which can be used as a cubemap. To use it:
- Copy/import it into your Unity Project
- In the textures import settings:
-- Set Texture Shape to Cube
-- Set Mapping to Latitude-Longtitude
-- Apply changes
- The texture now works as a cubemap

For checking efficiency, a simple FPS counter script has been included. To use it:
- Copy/import it into your Unity Project
- In your scene, ensure you have an UI Canvas object with an UI Text child object
-- If you have neither, the quickest way to add them is Create->UI->Text. Unity will automatically create both the Canvas and Text elements in the correct order
- Make sure the Text element has a functional site and placement. The following is a suggestion:
-- Use the bottom-right Anchor preset, where it covers the entire canvas
-- Set its Left, Top, Right and Bottom margin values to 10
- The default font size of the Text element may be small on a phone, so increase it to something like 42
- Add the FPS Counter script to the Text object