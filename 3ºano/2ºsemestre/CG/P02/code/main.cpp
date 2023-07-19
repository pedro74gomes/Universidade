#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#include <math.h>

float angle = 0.0f, angle2 = 0.0f, scale = 1.0f;

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


void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(5.0,5.0,5.0, 
		      0.0,0.0,0.0,
			  0.0f,1.0f,0.0f);

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

// put the geometric transformations here
	glTranslatef(0.0f, 0.0f, 0.0f); // moves the object
	glRotatef(angle, 0.0f, 1.0f, 0.0f); // angle is in degrees
	glRotatef(angle2, 1.0f, 0.0f, 0.0f);
	glScalef(1.0f, scale, 1.0f); // scale factors for each axis
	
// put pyramid drawing instructions here
	glBegin(GL_TRIANGLES);
	// Base da pirâmide (quadrado amarelo)
		glColor3f(1.0f, 1.0f, 0.0f);// amarelo
		glVertex3f(-1.0f, 0.0f, 1.0f);
		glVertex3f(-1.0f, 0.0f, -1.0f);
		glVertex3f(1.0f, 0.0f, 1.0f);

		glColor3f(1.0f, 1.0f, 0.0f); // amarelo
		glVertex3f(1.0f, 0.0f, 1.0f);
		glVertex3f(-1.0f, 0.0f, -1.0f);
		glVertex3f(1.0f, 0.0f, -1.0f);

		// Lado 1 (triângulo vermelho)
		glColor3f(1.0f, 0.0f, 0.0f); // vermelho
		glVertex3f(-1.0f, 0.0f, -1.0f);
		glVertex3f(-1.0f, 0.0f, 1.0f);
		glVertex3f(0.0f, 1.0f, 0.0f);

		// Lado 2 (triângulo verde)
		glColor3f(0.0f, 1.0f, 0.0f); // verde
		glVertex3f(1.0f, 0.0f, -1.0f);
		glVertex3f(-1.0f, 0.0f, -1.0f);
		glVertex3f(0.0f, 1.0f, 0.0f);

		// Lado 3 (triângulo azul)
		glColor3f(0.0f, 0.0f, 1.0f); // azul
		glVertex3f(1.0f, 0.0f, 1.0f);
		glVertex3f(1.0f, 0.0f, -1.0f);
		glVertex3f(0.0f, 1.0f, 0.0f);

		// Lado 4 (triângulo roxo)
		glColor3f(1.0f, 0.0f, 1.0f); // roxo
		glVertex3f(-1.0f, 0.0f, 1.0f);
		glVertex3f(1.0f, 0.0f, 1.0f);
		glVertex3f(0.0f, 1.0f, 0.0f);

	glEnd();

	// End of frame
	glutSwapBuffers();
}


// write function to process keyboard events
void keyboard(unsigned char key, int x, int y) {
	switch (key) {
		case '+':
			scale += 0.5f;  // aumenta a escala em 50%
			break;
		case '-':
			scale -= 0.5f;  // diminui a escala em 50%
			break;
	}
	glutPostRedisplay();  // redesenha a cena para exibir a nova escala
}

void teclado(int key, int x, int y) {
	switch (key){
		case GLUT_KEY_LEFT:
			angle -= 10.0f;
			break;
		case GLUT_KEY_RIGHT:
			angle += 10.0f;
			break;
		case GLUT_KEY_DOWN:
			angle2 -= 10.0f;
			break;
		case GLUT_KEY_UP:
			angle2 += 10.0f;
			break;
	}
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

// put here the registration of the keyboard callbacks
	glutKeyboardFunc(keyboard);
	glutSpecialFunc(teclado);
	
//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	
// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}
