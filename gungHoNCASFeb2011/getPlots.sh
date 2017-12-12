#!/bin/bash -e

pdfFiles=(
shallowWaterTRiSK/WilliSteady/18x36/constant/mesh.eps
shallowWaterTRiSK/WilliSteady/bucky4/constant/mesh.eps
shallowWaterTRiSK/WilliSteady/cube12_Voronoi/constant/cubeMesh.eps
shallowWaterTRiSK/WilliSteady/kite4/constant/mesh.eps

shallowWaterTRiSK/WilliSteady/bucky4/save/dt_400/864000/hDiff.eps
shallowWaterTRiSK/WilliSteady/cube12_Voronoi/save/dt_400/864000/hDiff.eps
shallowWaterTRiSK/WilliSteady/kite4/save/dt_100/864000/hDiff.eps
)

for file in ${pdfFiles[*]}
do
    f=$FOAM_RUN/$file
    fRoot=`dirname $f`/`basename $f .eps`
    pdfFile=$fRoot.pdf
    fileNew=graphics/`echo $file |sed 's/\//+/g' | sed 's/\./p/g' | sed 's/peps/\.pdf/g'`

    if [ -e $f ]; then
        echo converting
        echo     $file
        echo to  $fileNew
        if [ ! -e $pdfFile ]; then
            makebb $f > /dev/null 2>&1
            epstopdf $f
        elif [ `stat -c "%Z" $f` -gt `stat -c "%Z" $pdfFile` ]; then
            makebb $f > /dev/null 2>&1
            epstopdf $f
    #    else
    #        echo $pdfFile is newer
        fi
        
        rsync -ut $pdfFile $fileNew
    else
        echo no $f
    fi
done
