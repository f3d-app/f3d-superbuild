import f3d
print(f3d.__file__)

def test_text_distance():
    assert f3d.Utils.text_distance("modle", "model") == 2
