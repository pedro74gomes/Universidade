#include <stdio.h>
#include <stdlib.h>

#define _USE_MATH_DEFINES
#include <math.h>
#include <vector>

#include <IL/il.h>

#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#include <iostream>

float alfa = 0.0f, beta = 0.5f, radius = 200.0f;
float camX, camY, camZ;
int tree_number = 300;
float desvios[300];
float desvio_angulos[300];
float color[300];
int time_diff = -1;
float time_angle_diff = (2 * M_PI) / 175;
float time_angle_diff_2 = 360.0f / 175.0f;

float timebase, time_passed;
float frames = 0, fps;

unsigned int t, tw, th;
unsigned char* imageData;


void spherical2Cartesian() {
	camX = radius * cos(beta) * sin(alfa);
	camY = radius * sin(beta);
	camZ = radius * cos(beta) * cos(alfa);
}


void changeSize(int w, int h) {
	// Prevent a divide by zero, when window is too short
	// (you cant make a window with zero width).
	if(h == 0)
		h = 1;

	// compute window's aspect ratio 
	float ratio = w * 1.0 / h;

	// Set the projection matrix as current
	glMatrixMode(GL_PROJECTION);
	// Load Identity Matrix
	glLoadIdentity();
	
	// Set the viewport to be the entire window
    glViewport(0, 0, w, h);

	// Set perspective
	gluPerspective(45.0f ,ratio, 1.0f ,1000.0f);

	// return to the model view matrix mode
	glMatrixMode(GL_MODELVIEW);
}

float h(int i, int j) {
	return (imageData[j * tw + i] * 30) / 255;
}

float hf(float x, float z) {
	// h(z, x)
	float x1 = floor(x);
	float x2 = x1 + 1;
	float z1 = floor(z);
	float z2 = z1 + 1;

	float fz = z - z1;
	float h_x1_z = h(x1, z1) * (1 - fz) + h(x1, z2) * fz;
	float h_x2_z = h(x2, z1) * (1 - fz) + h(x2, z2) * fz;

	float fx = x - x1;
	float height_xz = h_x1_z * (1 - fx) + h_x2_z * fx;

	return height_xz;
}


void arvore(float x, float y, float z, float color) {
	glPushMatrix();
		glColor3f(0.64f, 0.45f, 0.28f);
		glTranslatef(x, y, z);
		glRotatef(-90, 1.0f, 0.0f, 0.0f);
		glutSolidCone(1, 8, 20, 20);
	glPopMatrix();
	glPushMatrix();
		glColor3f(0.0f, color, 0.0f);
		glTranslatef(x, 2.5+y, z);
		glRotatef(-90, 1.0f, 0.0f, 0.0f);
		glutSolidCone(3, 10, 20, 20);
	glPopMatrix();
}

void drawTerrain() {
	float imageWidth = tw / 2;
	float imageHeight = th / 2;

	for (float z = 0; z < th - 1; z++) {
		glBegin(GL_TRIANGLE_STRIP);
		for (float x = 0; x < tw; x++) {
			
			glVertex3f(-imageWidth + x, h(z, x), -imageHeight + z);

			glVertex3f(-imageWidth + x, h(z + 1, x), -imageHeight + z + 1);
		}
		glEnd();
	}
}

void renderScene(void) {
	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(camX, camY, camZ,
		0.0, 0.0, 0.0,
		0.0f, 1.0f, 0.0f);

	glColor3f(0.2f, 0.8f, 0.2f);
	glBegin(GL_TRIANGLES);
		glVertex3f(100.0f, 0, -100.0f);
		glVertex3f(-100.0f, 0, -100.0f);
		glVertex3f(-100.0f, 0, 100.0f);

		glVertex3f(100.0f, 0, -100.0f);
		glVertex3f(-100.0f, 0, 100.0f);
		glVertex3f(100.0f, 0, 100.0f);
	glEnd();

	// End of frame

	time_diff += 1;

	glColor3f(1.0, 0, 1.0);
	glutSolidTorus(1, 3, 20, 20);
	glPushMatrix();

	float alpha_arch = (M_PI * 2) / 8;
	float rotation_angle = 360 / 8;
	float rc = 15;

	glColor3f(0, 0, 1.0f);
	for (int i = 0; i < 8; i++) {
		glPushMatrix();
		float alpha = alpha_arch * i - time_angle_diff * time_diff;

		float x = rc * cos(alpha);
		float z = rc * sin(alpha);

		glTranslatef(x, 1.0, z);
		glRotatef(-rotation_angle * i, 0, 1.0f, 0);
		glRotatef(time_angle_diff_2 * time_diff, 0, 1.0f, 0);
		glutSolidTeapot(2);

		glPopMatrix();
	}

	glColor3f(1.0f, 0, 0);

	alpha_arch = (2 * M_PI) / 16;
	rotation_angle = 360 / 16;
	float ri = 35;
	for (int i = 0; i < 16; i++) {
		glPushMatrix();
		float alpha = alpha_arch * i + time_angle_diff * time_diff;

		float x = ri * cos(alpha);
		float z = ri * sin(alpha);

		glTranslatef(x, 1.0, z);
		glRotatef(90-rotation_angle * i, 0, 1.0f, 0);
		glRotatef(360-time_angle_diff_2 * time_diff, 0, 1.0f, 0);
		glutSolidTeapot(2);

		glPopMatrix();
	}

	float r = 50;
	alpha_arch = (2 * M_PI) / tree_number;

	for (int i = 0; i < tree_number; i++) {
		float radius = r + desvios[i];
		float x = radius * cos(alpha_arch * (i + desvio_angulos[i]));
		float z = radius * sin(alpha_arch * (i + desvio_angulos[i]));

		arvore(x, hf(x,z), z, color[i]);
	}

	// FPS Counter
	frames++;
	time_passed = glutGet(GLUT_ELAPSED_TIME);
	if (time_passed - timebase > 1000) {
		fps = frames*1000.0/(time_passed - timebase);
		timebase = time_passed;
		frames = 0;
	}

	char fps_buffer[50];

	sprintf(fps_buffer, "%d", (int) fps);

	glutSetWindowTitle(fps_buffer);

	drawTerrain();
	
	glutSwapBuffers();
}

void processSpecialKeys(int key, int xx, int yy) {
	switch (key) {
		case GLUT_KEY_RIGHT:
			alfa -= 0.1; break;

		case GLUT_KEY_LEFT:
			alfa += 0.1; break;

		case GLUT_KEY_UP:
			beta += 0.1f;
			if (beta > 1.5f)
				beta = 1.5f;
			break;

		case GLUT_KEY_DOWN:
			beta -= 0.1f;
			if (beta < -1.5f)
				beta = -1.5f;
			break;

		case GLUT_KEY_PAGE_DOWN: radius -= 1.0f;
			if (radius < 1.0f)
				radius = 1.0f;
			break;

		case GLUT_KEY_PAGE_UP: radius += 1.0f; break;
	}
	spherical2Cartesian();
	glutPostRedisplay();
}

void init() {

	// 	Load the height map "terreno.jpg"
	ilGenImages(1, &t);
	ilBindImage(t);
	// terreno.jpg is the image containing our height map
	ilLoadImage((ILstring)"terreno.jpg");
	// convert the image to single channel per pixel
	// with values ranging between 0 and 255
	ilConvertImage(IL_LUMINANCE, IL_UNSIGNED_BYTE);
	// important: check tw and th values
	// both should be equal to 256
	// if not there was an error loading the image
	// most likely the image could not be found
	tw = ilGetInteger(IL_IMAGE_WIDTH);
	th = ilGetInteger(IL_IMAGE_HEIGHT);

	// imageData is a LINEAR array with the pixel values
	imageData = ilGetData();
	// 	Build the vertex arrays

	// 	OpenGL settings
	glEnable(GL_DEPTH_TEST);
	//glEnable(GL_CULL_FACE);
}

void printInfo() {
	printf("Vendor: %s\n", glGetString(GL_VENDOR));
	printf("Renderer: %s\n", glGetString(GL_RENDERER));
	printf("Version: %s\n", glGetString(GL_VERSION));

	printf("\nUse Arrows to move the camera up/down and left/right\n");
	printf("Home and End control the distance from the camera to the origin\n");
}

int main(int argc, char **argv) {
	for(int i = 0; i < tree_number; i++) {
		desvios[i] = rand() % 50;
		desvio_angulos[i] = rand() % tree_number;
		color[i] = (rand() % 3);
		color[i] /= 10;
		color[i] += 0.4f;
	}

	// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(800,800);
	glutCreateWindow("CG@DI-UM");
		
	// Required callback registry 
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);
	glutIdleFunc(renderScene);

	timebase = glutGet(GLUT_ELAPSED_TIME);
	
	// Callback registration for keyboard processing
	glutSpecialFunc(processSpecialKeys);

	//  OpenGL settings
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnable(GL_DEPTH_TEST);
	//glEnable(GL_CULL_FACE);

	spherical2Cartesian();

	ilInit();
	init();

	printInfo();

	// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}