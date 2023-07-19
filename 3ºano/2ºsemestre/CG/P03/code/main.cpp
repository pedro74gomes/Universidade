#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#define _USE_MATH_DEFINES
#include <math.h>

float pi = M_PI;
float px=0, py=0, pz=5.0f, alpha=pi, beta=0, r=10;
float dx = 0, dy = 0, dz = 0;

void spherical2Cartesian() {
	px = r * cos(beta) * sin(alpha);
	py = r * sin(beta);
	pz = r * cos(beta) * cos(alpha);
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


void drawCylinder(float radius, float height, int slices) {

// put code to draw cylinder in here
	float alpha = (2*pi)/slices;

	// put the geometric transformations here
	glTranslatef(0.0f, height / 2.0f, 0.0f); // moves the object
	glRotatef(90.0f, 1.0f, 0.0f, 0.0f); // angle is in degrees

	glPolygonMode(GL_FRONT, GL_FILL);
	glBegin(GL_TRIANGLES);
		for (int i = 0; i < slices; i++) {
			float angle1 = i * alpha;
			float angle2 = (i + 1) * alpha;
			float x1 = radius * cos(angle1);
			float y1 = radius * sin(angle1);
			float x2 = radius * cos(angle2);
			float y2 = radius * sin(angle2);

			if (i%2 == 0) glColor3f(1.0f, 1.0f, 1.0f);
			else glColor3f(1.0f, 0.0f, 0.0f);

			// Define os vértices do triângulo lateral do cilindro
			glVertex3f(x1, y1, 0.0f);
			glVertex3f(x2, y2, 0.0f);
			glVertex3f(x1, y1, height);

			glVertex3f(x1, y1, height);
			glVertex3f(x2, y2, 0.0f);
			glVertex3f(x2, y2, height);

			// Define os vértices do triângulo inferior do cilindro
			glVertex3f(x1, y1, 0.0f);
			glVertex3f(0.0f, 0.0f, 0.0f);
			glVertex3f(x2, y2, 0.0f);

			// Define os vértices do triângulo superior do cilindro
			glVertex3f(0.0f, 0.0f, height);
			glVertex3f(x1, y1, height);
			glVertex3f(x2, y2, height);
		}
	glEnd();
}


void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(px, py, pz,
			  0.0f, 0.0f, 0.0f,
			  0.0f, 1.0f, 0.0f);

	// put axis drawing in here
	glBegin(GL_LINES);
		// X axis in red
		glColor3f(1.0f, 0.0f, 0.0f);
		glVertex3f(-100.0f, 0.0f, 0.0f);
		glVertex3f(100.0f, 0.0f, 0.0f);
		// Y Axis in Green
		glColor3f(0.0f, 1.0f, 0.0f);
		glVertex3f(0.0f, -100.0f, 0.0f);
		glVertex3f(0.0f, 100.0f, 0.0f);
		// Z Axis in Blue
		glColor3f(0.0f, 0.0f, 1.0f);
		glVertex3f(0.0f, 0.0f, -100.0f);
		glVertex3f(0.0f, 0.0f, 100.0f);
	glEnd();

	drawCylinder(1,2,30);

	// End of frame
	glutSwapBuffers();
}


// write function to process keyboard events
void teclado(int key, int x, int y) {
	switch (key) {
	case GLUT_KEY_RIGHT:
		alpha -= 0.1; 
		break;

	case GLUT_KEY_LEFT:
		alpha += 0.1; 
		break;

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

	case GLUT_KEY_PAGE_DOWN: 
		r -= 1.0f;
		if (r < 1.0f)
			r = 1.0f;
		break;

	case GLUT_KEY_PAGE_UP: 
		r += 1.0f; 
		break;
	}

	spherical2Cartesian();
	glutPostRedisplay();
}


int main(int argc, char **argv) {

// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(800,800);
	glutCreateWindow("CG@DI-UM");
		
// Required callback registry 
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);
	
// Callback registration for keyboard processing
	glutSpecialFunc(teclado);

//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	
// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}
