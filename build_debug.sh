# arg1 workspaceFolder
# arg2 relative dirname
# arg3 relative file Path
# arg4 file Base Name
cd $1
g++ -IOpenGL/include -LOpenGL/dll $3  -o ./bin/$4.exe -lfreeglut -lOPENGL32 -lgdi32
for file in OpenGL/dll/*.dll
do
    cp $file ./bin
done
./bin/$4.exe