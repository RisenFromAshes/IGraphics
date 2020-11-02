# arg1 workspaceFolder
# arg2 relative dirname
# arg3 relative file Path
# arg4 file Base Name
cd $1
if [[ "$OSTYPE" == "linux-gnu"* ]]
then 
    g++ -IOpenGL/include -LOpenGL/dll $3  -o ./bin/$4 -O3 -static-libgcc -static-libstdc++ -lGL -lglut
    cd bin
    7z a -tzip $4_linux_x64.zip $4
    mv $4_linux_x64.zip ../release
else 
    if [[ -f $2/$4.rc ]]
    then 
        windres $2/$4.rc -O coff -o $2/$4.res
        g++ -IOpenGL/include -LOpenGL/dll $3  -o ./bin/$4.exe ./$2/$4.res -mwindows -O3 -static-libgcc -static-libstdc++ -lfreeglut -lOPENGL32 -lgdi32
        rm $2/$4.res
    else
        g++ -IOpenGL/include -LOpenGL/dll $3  -o ./bin/$4.exe -mwindows -O3 -static-libgcc -static-libstdc++ -lfreeglut -lOPENGL32 -lgdi32
    fi
    for file in OpenGL/dll/*.dll
    do
        cp $file ./bin
    done
    cd bin
    7z a -tzip $4_win_x64.zip $4 ./*.dll
    mv $4_win_x64.zip ../release
fi