
# Caminhos para GLFW
GLFW_BASE_DIR = libs/glfw-3.4.bin.WIN64
GLFW_INCLUDE_PATH = $(GLFW_BASE_DIR)/include
GLFW_LIB_PATH = $(GLFW_BASE_DIR)/lib-mingw-w64

# Caminhos para GLAD
GLAD_BASE_DIR = libs/glad
GLAD_INCLUDE_PATH = $(GLAD_BASE_DIR)/include

CXX = g++

TARGET = main.exe

#lista de todos os arquivos .cpp do seu projeto, acredito que tem q adicionar mais arquivos conforme o projeto crescer
SRCS = main.cpp

# lista de todos os arquivos .c (como glad.c)
C_SRCS_NAMES = glad.c

# Obter nomes dos objetos (.o) a partir dos .cpp e .c
OBJS = $(SRCS:.cpp=.o) $(C_SRCS:.c=.o)

GLAD_OBJECT = $(GLAD_BASE_DIR)/src/glad.o

# OBJS agora inclui main.o e glad.o
OBJS += $(GLAD_OBJECT)

# Flags para o compilador (cabeçalhos, otimização, etc.)
# -Wall: Habilita todos os warnings comuns
# -g: Inclui informações de debug
# ADICIONE AQUI: -std=c++23 ou -std=gnu++23
CXXFLAGS = -I$(GLFW_INCLUDE_PATH) -I$(GLAD_INCLUDE_PATH) -Wall -g -std=c++23 # Ou -std=gnu++23

# Flags para o linker (caminhos de biblioteca, bibliotecas para vincular)
LDFLAGS = -L$(GLFW_LIB_PATH) -lglfw3 -lgdi32 -lopengl32 -static-libgcc -static-libstdc++ # -Wl,--subsystem,windows


# Regra padrão: Compila tudo para criar o TARGET
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $(TARGET) $(LDFLAGS)

# Regra para linkar o executável
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Regra ESPECÍFICA para compilar glad.c para glad.o
# Esta regra sobrepõe a regra genérica para glad.c devido ao caminho
$(GLAD_OBJECT): $(GLAD_BASE_DIR)/src/glad.c
	$(CXX) $(CXXFLAGS) -c $< -o $@

#comando para limpar os arquivos de compilação geradod
#usar o comando "make clean"
clean:
	-rm $(TARGET) $(OBJS)