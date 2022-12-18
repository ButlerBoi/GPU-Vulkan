#ifndef GLOBALLIGHTING_H
#define GLOBALLIGHTING_H

#include "Matrix.h"

using namespace MATH;

struct GlobalLighting {
	Vec4 position[3];
	Vec4 diffuse[3];
};

#endif
