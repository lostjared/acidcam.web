#ifndef _ANI_H__
#define _ANI_H__
#ifndef __EMSCRIPTEN__
#include"config.h"
#else
#include"config.hpp"
#endif
#include"mx.hpp"
#include"gl.hpp"
#include<vector>
#include<fstream>
#include<sstream>
#include<unordered_map>
#ifdef __EMSCRIPTEN__
#include<emscripten/emscripten.h>
#include<emscripten/bind.h>
using namespace emscripten;
#endif
extern const char *vSource;
extern const char *fSource;
extern const char *anifSource;
extern const char *anifSource2;
extern const char *anifSource3;
extern const char *anifSource4;
extern const char *anifSource5;
extern const char *anifSource6;
extern const char *anifSource7;
extern const char *anifSource8;
extern const char *anifSource9;
extern const char *anifSource10;
extern float the_time;
extern gl::GLSprite sprite;
static constexpr int MAX_SHADER = 11;
extern gl::ShaderProgram shader[MAX_SHADER];
extern std::vector<gl::ShaderProgram> shaders;
extern size_t shader_index;
extern bool playing;
extern std::unordered_map<GLuint, std::string> shader_map;

class Animation : public gl::GLObject {
public:
    
     Animation() = default;
    ~Animation() override {}

    void load(gl::GLWindow *win) override {
        font.loadFont(win->util.getFilePath("data/font.ttf"), 24);
        if(!shader[0].loadProgramFromText(vSource, anifSource)) {
            throw mx::Exception("Could not load shader");
        }
        if(!shader[1].loadProgramFromText(vSource, anifSource2)) {
            throw mx::Exception("Could not load shader");
        }
        if(!shader[2].loadProgramFromText(vSource, anifSource4)) {
            throw mx::Exception("Could not load shader");
        }
        if(!shader[3].loadProgramFromText(vSource, anifSource5)) {
            throw mx::Exception("Could not load shader");
        }
        if(!shader[4].loadProgramFromText(vSource, anifSource3)) {
            throw mx::Exception("Could not load shader");
        }
        if(!shader[5].loadProgramFromText(vSource, anifSource6)) {
            throw mx::Exception("Could not load shader");
        }
        if(!shader[6].loadProgramFromText(vSource, anifSource7)) {
            throw mx::Exception("Could not load shader");
        }
        if(!shader[7].loadProgramFromText(vSource, anifSource8)) {
            throw mx::Exception("Could not load shader");
        }
        if(!shader[8].loadProgramFromText(vSource, anifSource8)) {
            throw mx::Exception("Could not load shader");
        }
        if(!shader[9].loadProgramFromText(vSource, anifSource9)) {
            throw mx::Exception("Could not load shader");
        }
        
        if(!shader[10].loadProgramFromText(vSource, anifSource10)) {
            throw mx::Exception("Could not load shader");
        }
    
        for(int i = 0; i < MAX_SHADER-1; ++i) {
            shader[i].useProgram();
            shader[i].setUniform("iResolution", glm::vec2(win->w, win->h));
            shader[i].setUniform("time_f", static_cast<float>(SDL_GetTicks()));
            shader_map[shader[i].id()] = "Built-in";
            shaders.push_back(shader[i]);
        }
        loadShaders(win);
        sprite.initSize(win->w, win->h);
        sprite.loadTexture(&shaders[shader_index], win->util.getFilePath("data/bg.png"), 0, 0, win->w, win->h);
    }

    void loadShaders(gl::GLWindow *win) {
        std::fstream file;
        file.open(win->util.getFilePath("data/shaders/shaders.txt"), std::ios::in);
        if(!file.is_open())  {
            std::cerr << "Error could not open shader index...\n";
            exit(EXIT_FAILURE);
        }        
        while(!file.eof()) {
            std::string line;
            std::getline(file, line);
            if(file) {
                std::ostringstream stream;
                stream << "data/shaders/" << line;
                std::cout << "Loading: " << stream.str() << "\n";
                gl::ShaderProgram program;
                if(!program.loadProgram(win->util.getFilePath("data/shader.vert"), win->util.getFilePath(stream.str()))) {
                    std::cerr << "Error loading file: " << line << "\n";
                }
                program.useProgram();
                program.setUniform("iResolution", glm::vec2(win->w, win->h));
                program.setUniform("time_f", static_cast<float>(SDL_GetTicks()));
                program.setUniform("alpha", 1.0f);

                GLint linkStatus;
                glGetProgramiv(program.id(), GL_LINK_STATUS, &linkStatus);
                if (linkStatus != GL_TRUE) {
                    char log[512];
                    glGetProgramInfoLog(program.id(), 512, NULL, log);
                    std::cerr << "Shader Program Link Error: " << log << std::endl;
                }
                shader_map[program.id()] = line;
                shaders.push_back(program);
                std::cout << "Loaded shader: " << stream.str() << "\n";
                static int counter = 0;
                ++counter;
                if(counter > 100)
                    return;
            }
        }
   }

    void draw(gl::GLWindow *win) override {
        Uint32 currentTime = SDL_GetTicks();
        float deltaTime = (currentTime - lastUpdateTime) / 1000.0f; // Convert to seconds
        lastUpdateTime = currentTime;
        update(deltaTime);
        sprite.setShader(&shaders[shader_index]);
        shaders[shader_index].useProgram();
    
        if(playing)
            the_time = static_cast<float>(SDL_GetTicks() / 1000.0f);

        shaders[shader_index].setUniform("time_f", the_time);
        sprite.draw();
        win->text.setColor({255,255,255,255});
        win->text.printText_Solid(font, 25, 25, "Acid Cam Shaders Early Demo: https://lostsidedead.biz");
    }
    void event(gl::GLWindow *win, SDL_Event &e) override {
        
        
    }
    void update(float deltaTime) {}
private:
    Uint32 lastUpdateTime = SDL_GetTicks();
    mx::Font font;
    
};

#endif