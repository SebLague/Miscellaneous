using UnityEngine;
using System.Collections;

public class RotateMesh : MonoBehaviour {

	const float quadScale = 3;
	Vector3[] offsets;

	public MeshFilter meshRenderer;
	Mesh mesh;
	Transform cam;

	void Start() {
		CreateOffsetsArray ();

		cam = Camera.main.transform;
		mesh = meshRenderer.mesh;
		meshRenderer.transform.localScale = Vector3.one;
	}

	void CreateOffsetsArray() {
		float length = quadScale * .5f;
		offsets = new Vector3[]{new Vector3(-length,-length), new Vector3(length,length),new Vector3(length,-length),new Vector3(-length,length)};
	}

	void Update () {

		Vector3[] vertices = new Vector3[mesh.vertices.Length];
		for (int i = 0; i < mesh.vertices.Length; i+=4) {

			Vector3 a = mesh.vertices [i + 0];
			Vector3 b = mesh.vertices [i + 1];
			Vector3 c = mesh.vertices [i + 2];
			Vector3 d = mesh.vertices [i + 3];

			Vector3 centre = (a+b+c+d)*.25f;

			vertices [i] = centre + cam.rotation * offsets [0];
			vertices [i+1] = centre + cam.rotation * offsets [1];
			vertices [i+2] = centre + cam.rotation * offsets [2];
			vertices [i+3] = centre + cam.rotation * offsets [3];
		}

		mesh.vertices = vertices;
		meshRenderer.mesh = mesh;
	}
}
