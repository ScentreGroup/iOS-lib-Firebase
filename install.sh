
#!/bin/bash

set -euo pipefail

echo "===== Cleaning previous install"
rm -rf Release-iphoneos Release-iphonesimulator
echo "===== Installing dependencies"
pod install
echo "===== Generating device variants"
pushd Rome > /dev/null

mkdir -p Release-iphoneos
mkdir -p Release-iphonesimulator

for d in *.framework/ ; do
    frameworkName=`echo "${d}" | cut -d'/' -f 1`
    libName=`echo "${frameworkName}" | cut -d'.' -f 1`
    echo "-> ${frameworkName}"
    cp -r ${frameworkName} Release-iphoneos/
    mv ${frameworkName} Release-iphonesimulator/

    pushd Release-iphoneos/${frameworkName} > /dev/null

    mv ${libName} ${libName}.old
    echo "   thinning for iOS"
    lipo ${libName}.old -extract_family arm -extract_family arm64 -o ${libName}
    rm ${libName}.old

    dsym=../../../dSYM/iphoneos/${frameworkName}.dSYM
    if [ -d ${dsym} ]; then
        mv -f ${dsym} ../
    fi

    popd > /dev/null


    pushd Release-iphonesimulator/${frameworkName} > /dev/null

    mv ${libName} ${libName}.old
    echo "   thinning for simulator"
    lipo ${libName}.old -extract_family x86_64 -extract_family i386 -o ${libName}
    rm ${libName}.old

    dsym=../../../dSYM/iphonesimulator/${frameworkName}.dSYM
    if [ -d ${dsym} ]; then
        mv -f ${dsym} ../
    fi

    popd > /dev/null
done
popd > /dev/null

mv Rome/Release-iphoneos .
mv Rome/Release-iphonesimulator .

rm -rf dSYM
rm -rf Rome
echo "==== Success"