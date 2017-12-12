#!/bin/bash

pngFiles=(

)

pdfFiles=(
shallowWater/WilliSteady/legends/hDiff40_hDiff.eps
shallowWater/WilliSteady/24x48/save/alpha_45_cubUpCFCNew/345600/hDiff40.eps
shallowWater/WilliSteady/24x48/save/alpha_45_cubUpCFCNew/3456000/hDiff40.eps
shallowWater/WilliSteady/cube12/save/alpha_45_cubUpCFCNew/345600/hDiff40.eps
shallowWater/WilliSteady/cube12/save/alpha_45_cubUpCFCNew/3456000/hDiff40.eps
shallowWater/WilliSteady/bucky4/save/alpha_45_cubUpCFCNew/345600/hDiff40.eps
shallowWater/WilliSteady/bucky4/save/alpha_45_cubUpCFCNew/3456000/hDiff40.eps

shallowWater/WilliSteady/24x48_refine/save/alpha_0_cubUpCFCNew/900/hDiff1.eps
shallowWater/WilliSteady/legends/hDiff1_hDiff_v.eps
shallowWater/WilliSteady/legends/hDiff1_hDiff.eps
shallowWater/WilliSteady/24x48_refine/save/alpha_0_cubUpCFCNew/345600/hDiff40.eps
shallowWater/WilliSteady/24x48_refine/save/alpha_0_cubUpCFCNew/3456000/hDiff40.eps
shallowWater/WilliSteady/cube12_refine/save/alpha_0_cubUpCFCNew/900/hDiff1.eps
shallowWater/WilliSteady/cube12_refine/save/alpha_0_cubUpCFCNew/345600/hDiff40.eps
shallowWater/WilliSteady/cube12_refine/save/alpha_0_cubUpCFCNew/3456000/hDiff40.eps
shallowWater/WilliSteady/bucky4_refine/save/alpha_0_cubUpCFCNew/900/hDiff1.eps
shallowWater/WilliSteady/bucky4_refine/save/alpha_0_cubUpCFCNew/345600/hDiff40.eps
shallowWater/WilliSteady/bucky4_refine/save/alpha_0_cubUpCFCNew/3456000/hDiff40.eps

shallowWater/WilliSteady/Voronoi4_refine/saveOld/dt_100_RTSK_APVM/100/hDiff1.eps
shallowWater/WilliSteady/Voronoi4_refine/saveOld/dt_100_RTSK_APVM/345600/hDiff40.eps
shallowWater/WilliSteady/Voronoi4_refine/saveOld/dt_100_RTSK_APVM/3456000/hDiff40.eps
shallowWater/WilliSteady/Voronoi4_refine/saveOld/dt_100_RTSK_APVM/5184000/hU.eps
shallowWater/WilliSteady/Voronoi4_refine/saveOld/dt_100_RTSK_C/100/hDiff1.eps
shallowWater/WilliSteady/Voronoi4_refine/saveOld/dt_100_RTSK_C/345600/hDiff40.eps
shallowWater/WilliSteady/Voronoi4_refine/saveOld/dt_100_RTSK_C/3456000/hDiff40.eps
shallowWater/WilliSteady/Voronoi4_refine/saveOld/dt_100_RTSK_C/5184000/hU.eps

shallowWater/WilliSteady/plotWerrors/energy.eps

)

for file in ${pngFiles[*]}
do
    f=$FOAM_RUN/$file
    fRoot=`dirname $f`/`basename $f .eps`
    pngFile=$fRoot.png
    fileNew=graphics/`echo $file |sed 's/\//+/g' | sed 's/\./p/g' | sed 's/peps/\.png/g'`

    if [ ! -e $pngFile ]; then
        echo converting $file to png
        eps2png $f
    elif [ `stat -c "%Z" $f` -gt `stat -c "%Z" $pngFile` ]; then
        echo re-converting $file to png
        eps2png $f
#    else
#        echo $pngFile is newer
    fi

    rsync -ut $pngFile $fileNew
done

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
