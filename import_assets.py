from importlib.resources import path
import PIL.Image
import pathlib
import os

SCALE = 0.25

TEMPLATE_RES = '[ext_resource path="res://Assets/Tiles/{name}" type="Texture" id={i1}]\n'

TEMPLATE = """
{i}/name = "{name}"
{i}/texture = ExtResource( {i1} )
{i}/tex_offset = Vector2( 0, 0 )
{i}/modulate = Color( 1, 1, 1, 1 )
{i}/region = Rect2( 0, 0, {img.size[0]}, {img.size[1]} )
{i}/tile_mode = 0
{i}/occluder_offset = Vector2( 128, 64 )
{i}/navigation_offset = Vector2( 128, 64 )
{i}/shape_offset = Vector2( -10, 0 )
{i}/shape_transform = Transform2D( 1, 0, 0, 1, 0, 0 )
{i}/shape_one_way = false
{i}/shape_one_way_margin = 0.0
{i}/shapes = [  ]
{i}/z_index = 0
"""


def importer(assets, dst, scale=1):
    tiles = open(dst / "tiles.tres", "w")
    tiles.write('[gd_resource type="TileSet" load_steps=4 format=2]\n\n')
    tiles_resources = []

    for i, asset in enumerate(sorted(assets.glob("*.png"))):
        img = PIL.Image.open(asset)
        new_size = map(lambda x: int(x * scale), img.size)
        resized_img = img.resize(new_size, PIL.Image.LANCZOS)
        resized_img.save(dst / asset.name)
        os.system(f"optipng {dst / asset.name}")

        data = {
            "i": i,
            "i1": i + 1,
            "name": asset.name,
            "img": resized_img,
        }

        tiles.write(
            

            TEMPLATE_RES.format(**data)
        )

        tiles_resources.append(
            TEMPLATE.format(**data)
        )

    tiles.write("\n[resource]\n")
    tiles.write("".join(tiles_resources))


def main():
    src = pathlib.Path("Assets")
    dst = pathlib.Path("nom-nom-skyscraper/Assets")
    importer(src / "Tiles", dst / "Tiles", 0.25)
    importer(src / "Toppings/Nature", dst / "Toppings/Nature", 0.25)


if __name__ == "__main__":
    main()

    
    