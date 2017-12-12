#!/bin/bash -e

FOAM_RUN='/home/hilary/OpenFOAM/hilary*-dev/run'

pdfFiles=(
shallowWaterTRiSK/WilliSteady/24x48_V2/constant/mesh.eps
shallowWaterTRiSK/WilliSteady/bucky4/constant/mesh.eps
shallowWaterTRiSK/WilliSteady/tri4/constant/mesh.eps
shallowWaterTRiSK/WilliSteady/cube12_Voronoi/constant/meshBlack.eps
shallowWaterTRiSK/WilliSteady/kite4/constant/mesh.eps

#shallowWater/WilliMountain/Voronoi7/legends/vorticityDual_vorticity_v.eps

#shallowWaterTRiSK/WilliSteady/bucky4/legends/hDiff.eps

#shallowWaterTRiSK/linearModes/7x14/modeFreqs.eps
#shallowWaterTRiSK/linearModes/12x24_V/modeFreqs.eps
#shallowWaterTRiSK/linearModes/bucky3/modeFreqs.eps
#shallowWaterTRiSK/linearModes/tri3/modeFreqs.eps
#shallowWaterTRiSK/linearModes/kite2/modeFreqs.eps
#shallowWaterTRiSK/linearModes/cube5_Voronoi/modeFreqs.eps
#shallowWaterTRiSK/linearModes/diamondCube4/modeFreqs.eps
#shallowWaterTRiSK/linearModes/diamondBucky3/modeFreqs.eps

#shallowWaterTRiSK/baroJet/bucky7/legends/vorticityDual_vorticity_v.eps
)

png1Files=(
#shallowWater/WilliMountain/Voronoi7/save/nonLin_En_APVM_sph_dt100/4320000/vorticity.eps
#shallowWater/WilliMountain/Voronoi7/save/nonLin_En_APVM_sph_dt100/4320000/vorticityDual.eps
)

png2Files=(
#shallowWaterTRiSK/WilliSteady/18x36/save/linear_balanceInit_dt_900_fe/864000/hDiff.eps
#shallowWaterTRiSK/WilliSteady/24x48_V2/save/linear_balanceInit_dt_1hr_midPoint/864000/hDiff.eps
#shallowWaterTRiSK/WilliSteady/24x48_V_90/save/linear_balanceInit_dt_1hr_midPoint/864000/hDiff.eps
#shallowWaterTRiSK/WilliSteady/bucky4/save/linear_balanceInit_dt_1hr_fe/864000/hDiff.eps
#shallowWaterTRiSK/WilliSteady/cube12_Voronoi/save/linear_balanceInit_dt_1hr_fe/864000/hDiff.eps
#shallowWaterTRiSK/WilliSteady/diamondBucky4/save/linear_balanceInit_dt_30m_fe/864000/hDiff.eps
#shallowWaterTRiSK/WilliSteady/diamondCube4/save/linear_balanceInit_dt_30m_fe/864000/hDiff.eps
#shallowWaterTRiSK/WilliSteady/kite4/save/linear_balanceInit_dt_30m_fe/864000/hDiff.eps
#shallowWaterTRiSK/WilliSteady/tri4/save/linear_balanceInit_dt_1hr_fe/864000/hDiff.eps

#shallowWaterTRiSK/WilliSteady/bucky4/legends/hDiff.eps
#shallowWaterTRiSK/WilliSteady/bucky4/legends/hDiff_U10.eps

#shallowWaterTRiSK/WilliSteady/18x36/save/linear_balanceInit_dt_900_fe/864000/vorticityDual.eps
#shallowWaterTRiSK/WilliSteady/24x48_V2/save/linear_balanceInit_dt_1hr_midPoint/864000/vorticityDual.eps
#shallowWaterTRiSK/WilliSteady/24x48_V_90/save/linear_balanceInit_dt_1hr_midPoint/864000/vorticityDual.eps
#shallowWaterTRiSK/WilliSteady/bucky4/save/linear_balanceInit_dt_1hr_fe/864000/vorticityDual.eps
#shallowWaterTRiSK/WilliSteady/cube12_Voronoi/save/linear_balanceInit_dt_1hr_fe/864000/vorticityDual.eps
#shallowWaterTRiSK/WilliSteady/diamondBucky4/save/linear_balanceInit_dt_30m_fe/864000/vorticityDual.eps
#shallowWaterTRiSK/WilliSteady/diamondCube4/save/linear_balanceInit_dt_30m_fe/864000/vorticityDual.eps
#shallowWaterTRiSK/WilliSteady/kite4/save/linear_balanceInit_dt_30m_fe/864000/vorticityDual.eps
#shallowWaterTRiSK/WilliSteady/tri4/save/linear_balanceInit_dt_1hr_fe/864000/vorticityDual.eps

#shallowWaterTRiSK/WilliSteady/bucky4/legends/vorticityDual_vorticity.eps

shallowWaterSphereMesh/WilliSteady/48x96_V_45/save/CN_dt1hr_midPointpv_balance/432000/hDiff.eps
shallowWaterSphereMesh/WilliSteady/bucky5/save/CN_dt1hr_midPointpv_balance/432000/hDiff.eps
shallowWaterSphereMesh/WilliSteady/tri5/save/CN_dt1hr_midPointpv_balance/432000/hDiff.eps
shallowWaterSphereMesh/WilliSteady/kite4/save/CN_dt1hr_midPointpv_balance/432000/hDiff50.eps

shallowWaterSphereMesh/WilliSteady/48x96_V_45/save/CN_dt1hr_midPointpv_sample/432000/hDiff.eps
shallowWaterSphereMesh/WilliSteady/bucky5/save/CN_dt1hr_midPointpv_sample/432000/hDiff.eps
shallowWaterSphereMesh/WilliSteady/tri5/save/CN_dt1hr_midPointpv_sample/432000/hDiff.eps
shallowWaterSphereMesh/WilliSteady/kite4/save/CN_dt1hr_midPointpv_sample/432000/hDiff50.eps

shallowWaterSphereMesh/WilliSteady/bucky5/legends/hDiff_v.eps
shallowWaterSphereMesh/WilliSteady/kite4/legends/hDiff50_hDiff_v.eps

#shallowWaterTRiSK/baroJet/bucky8/518400/vorticityC.eps
#shallowWaterTRiSK/baroJet/192x384_V_90/save/APVM_dt100/518400/vorticityDual.eps
#shallowWaterTRiSK/baroJet/192x384_V_45/save/APVM_dt100/518400/vorticityDual.eps
#shallowWaterTRiSK/baroJet/192x384_V/save/APVM_dt100/518400/vorticitySkips.eps
#shallowWaterTRiSK/baroJet/bucky7/save/APVM_dt100/518400/vorticityDual.eps
#shallowWaterTRiSK/baroJet/diamondCube85/save/APVM_dt100/518400/vorticityDual.eps
#shallowWaterTRiSK/baroJet/tri7/save/APVM_dt100/518400/vorticityDual.eps

)

gifFiles=(
#shallowWaterTRiSK/linearModes/7x14/geosG.gif
#shallowWaterTRiSK/linearModes/12x24_V/geosG.gif
#shallowWaterTRiSK/linearModes/bucky3/geosG.gif
#shallowWaterTRiSK/linearModes/tri3/geosG.gif
#shallowWaterTRiSK/linearModes/kite2/geosG.gif
#shallowWaterTRiSK/linearModes/cube5_Voronoi/geosG.gif

#shallowWaterTRiSK/linearModes/7x14/vslowG.gif
#shallowWaterTRiSK/linearModes/12x24_V/vslowG.gif
#shallowWaterTRiSK/linearModes/bucky3/vslowG.gif
#shallowWaterTRiSK/linearModes/tri3/vslowG.gif
#shallowWaterTRiSK/linearModes/kite2/vslowG.gif
#shallowWaterTRiSK/linearModes/cube5_Voronoi/vslowG.gif

#shallowWaterTRiSK/linearModes/7x14/RossbyG.gif
#shallowWaterTRiSK/linearModes/12x24_V/RossbyG.gif
#shallowWaterTRiSK/linearModes/bucky3/RossbyG.gif
#shallowWaterTRiSK/linearModes/tri3/RossbyG.gif
#shallowWaterTRiSK/linearModes/kite2/RossbyG.gif
#shallowWaterTRiSK/linearModes/cube5_Voronoi/RossbyG.gif

#shallowWaterTRiSK/linearModes/7x14/gridDiv1G.gif
#shallowWaterTRiSK/linearModes/12x24_V/gridDiv1G.gif
#shallowWaterTRiSK/linearModes/bucky3/gridDiv1G.gif
#shallowWaterTRiSK/linearModes/tri3/gridDiv1G.gif
#shallowWaterTRiSK/linearModes/kite2/gridDiv1G.gif
#shallowWaterTRiSK/linearModes/cube5_Voronoi/gridDiv1G.gif

#shallowWaterTRiSK/linearModes/7x14/gridDiv2G.gif
#shallowWaterTRiSK/linearModes/12x24_V/gridDiv2G.gif
#shallowWaterTRiSK/linearModes/bucky3/gridDiv2G.gif
#shallowWaterTRiSK/linearModes/tri3/gridDiv2G.gif
#shallowWaterTRiSK/linearModes/kite2/gridDiv2G.gif
#shallowWaterTRiSK/linearModes/cube5_Voronoi/gridDiv2G.gif

)

cpFiles=(
#shallowWaterTRiSK/linearModes/bucky3/legends/h_v.png
)

for file in ${pdfFiles[*]}
do
    f=$FOAM_RUN/$file
    fRoot=`dirname $f`/`basename $f .eps`
    pdfFile=$fRoot.pdf
    fileNew=graphics/`echo $file |sed 's/\//+/g' | sed 's/\./p/g' | sed 's/peps/\.pdf/g'`

    if [ -e $f ]; then
        if [ ! -e $pdfFile ]; then
            echo converting $file
            echo to  $fileNew
            makebb $f > /dev/null 2>&1
            epstopdf $f
        elif [ `stat -c "%Z" $f` -gt `stat -c "%Z" $pdfFile` ]; then
            echo converting $file
            echo to  $fileNew
            makebb $f > /dev/null 2>&1
            epstopdf $f
    #    else
    #        echo $pdfFile is newer
        fi
        
        if [ ! -e $fileNew ]; then ln -s $pdfFile $fileNew; fi
    else
        echo Error, no $f
        exit
    fi
done

for file in ${png1Files[*]}
do
    f=$FOAM_RUN/$file
    fRoot=`dirname $f`/`basename $f .eps`
    pngFile=$fRoot.png
    fileNew=graphics/`echo $file |sed 's/\//+/g' | sed 's/\./p/g' | sed 's/peps/\.png/g'`

    if [ -e $f ]; then
        if [ ! -e $pngFile ]; then
            echo converting $file
            echo to  $fileNew
            eps2png $f
        elif [ `stat -c "%Z" $f` -gt `stat -c "%Z" $pngFile` ]; then
            echo converting $file 
            echo to  $fileNew
            eps2png $f
      #  else
     #       echo $pngFile is newer
    #        eps2png $f
        fi
        
        if [ ! -e $fileNew ]; then ln -s $pngFile $fileNew; fi
    else
        echo Error, no $f
        exit
   fi
done

for file in ${png2Files[*]}
do
    f=$FOAM_RUN/$file
    fRoot=`dirname $f`/`basename $f .eps`
    pngFile=$fRoot.png
    fileNew=graphics/`echo $file |sed 's/\//+/g' | sed 's/\./p/g' | sed 's/peps/\.png/g'`

    if [ -e $f ]; then
        if [ ! -e $pngFile ]; then
            echo converting $file
            echo to  $fileNew
            eps2png2 $f
        elif [ `stat -c "%Z" $f` -gt `stat -c "%Z" $pngFile` ]; then
            echo converting $file 
            echo to  $fileNew
            eps2png2 $f
     #   else
     #       echo $pngFile is newer
    #        eps2png2 $f
        fi
        
        if [ ! -e $fileNew ]; then ln -s $pngFile $fileNew; fi
    else
        echo Error, no $f
        exit
   fi
done

for file in ${gifFiles[*]}
do
    f=$FOAM_RUN/$file
    fRoot=`dirname $f`/`basename $f .gif`
    pngFile=$fRoot.png
    fileNew=graphics/`echo $file |sed 's/\//+/g' | sed 's/\./p/g' | sed 's/pgif/\.png/g'`

    if [ -e $f ]; then
        if [ ! -e $pngFile ]; then
            echo converting $file
            echo to  $fileNew
            convert -crop 0x0 $f $pngFile
        elif [ `stat -c "%Z" $f` -gt `stat -c "%Z" $pngFile` ]; then
            echo converting $file 
            echo to  $fileNew
            convert -crop 0x0 $f $pngFile
        #else
        #    echo $pngFile is newer
        fi
        
        if [ ! -e $fileNew ]; then ln -s $pngFile $fileNew; fi
    else
        echo Error, no $f
        exit
   fi
done

for file in ${cpFiles[*]}
do
    f=$FOAM_RUN/$file
    fileNew=graphics/`echo $file | sed 's/\//+/g'`
    if [ -e $f ]; then
        if [ ! -e $fileNew ]; then ln -s $f $fileNew; fi
    else
        echo Error, no $f
        exit
    fi
done

