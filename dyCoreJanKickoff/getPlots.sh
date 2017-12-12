#!/bin/bash -e

pdfFiles=(
shallowWater/WilliSteady/cube12_eq/constant/mesh_30.eps
shallowWater/WilliSteadyMeshAdapt/48x96_V/0/mesh.eps

shallowWater/WilliSpike/Voronoi4/save/dt_100_RTSK_APVM/864000/hU.eps
shallowWater/WilliSpike/Voronoi4/save/dt_100_RTSK_APVM/864000/hDiff.eps
shallowWater/WilliSpike/Voronoi4/save/dt_100_RTSK_APVM/864000/vorticityDual.eps

shallowWater/WilliSteady/Voronoi4_refine/save/dt_100_RTSK_APVM/864000/hU.eps
shallowWater/WilliSteady/Voronoi4_refine/save/dt_100_RTSK_APVM/864000/hDiff.eps
shallowWater/WilliSteady/Voronoi4_refine/save/dt_100_RTSK_APVM/864000/vorticityDual.eps

shallowWater/WilliBaffle/Voronoi4/save/dt_100_RTSK_APVM/864000/hU.eps
shallowWater/WilliBaffle/Voronoi4/save/dt_100_RTSK_APVM/864000/hDiff.eps
shallowWater/WilliBaffle/Voronoi4/save/dt_100_RTSK_APVM/864000/vorticityDual.eps
shallowWater/WilliBaffle/Voronoi4/legends/hU_h.eps
shallowWater/WilliBaffle/Voronoi4/legends/hDiff.eps
shallowWater/WilliBaffle/Voronoi4/legends/vorticityDual_vorticity.eps
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
