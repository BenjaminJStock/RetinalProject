using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace WebApplication6
{
//   %*********************************************************
//function Result = GetStatisticalFeatures(GS, Im, mask )
//    % Evaluate segment map performance against a ground-truth image
//    % TP : True Positive; Correct Foreground
//    % FP : False Positive; Incorrect Foreground
//    % TN : True Negative; Coreect Background
//    % FN : False Negative; Incorrect Background
//    %Bashir Al-Diri
//    %*********************************************************
    
//    % Count pixels in the ground truth
//    noPxlGT = sum(GS(:)); % = TP + FN
 
//    % Count pixels in the Segment map
//    noPxlSM = sum(Im(:)); % = TP + FP
    
//    %some other researcher used FOV only like stare and drive
//    %only pixels inside the field of view are taken into account(the mask images supplied in the DRIVE database provide the field of view for each image).
//    if nargin< 3
//        %hoover used all image for comparizon
//        TP = Im & GS;
//        FN = ~Im & GS;
//        TN = ~Im & ~GS;
//    FP = Im & ~GS;
//    else
//        TP = mask & Im & GS;
//        FN = mask & ~Im & GS;
//        TN = mask & ~Im & ~GS;
//    FP = mask & Im & ~GS;
//    end
 
    
//%     figure; imshow(TP); title('TP');
//%     figure; imshow(FN); title('FN');
//%     figure; imshow(FP); title('FP');

//    noTP = sum(TP(:) );
//    noFP = sum(FP(:) );
//    noTN = sum(TN(:) );
//    noFN = sum(FN(:) );
 
//    TPFP = noTP+noFP; %positiveResponse(TP+FP)
//    TPFN = noTP+noFN; %positiveReference(TP+FN)
//    FPTN = noFP+noTN; %negativeReference(FP+TN)
//    FNTN = noFN+noTN; %negativeResponse(FN+TN)
//    FPFN = noFP+noFN; %Error(FP+FN)
//    TPTN = noTP+noTN; %Correct(TP+TN)
//    Total = noTP+noTN+noFP+noFN;
 
 
//    Sensitivity = noTP/TPFN;
//    Specificity = noTN/FPTN;
//    Precision = noTP/TPFP;
//    JaccardCoefficient = noTP/(noTP+noFP+noFN);
//    AndrewFailer = noFP/TPFN;
//    Accuracy = TPTN/Total;
//    TPRate = noTP/TPFN;
//    FPRate = noFP/FPTN;
 
//    referenceLikelihood = TPFN/Total;   
//    responseLikelihood =  TPFP/Total;   
//    randomAccuracy = referenceLikelihood* responseLikelihood + (1 - referenceLikelihood) * (1 - responseLikelihood);
//    kappa = (Accuracy-randomAccuracy)/(1-randomAccuracy); %(p - e) / (1 - e)
 
//    %Dice Coefficinet
//    DiceCoeff = (2* noTP)/(2* noTP+noFP+noFN);
    
//    Result = [noPxlGT noPxlSM noTP noFP noTN noFN FPFN Sensitivity Specificity Precision JaccardCoefficient AndrewFailer Accuracy kappa TPRate FPRate, DiceCoeff];
//    %Result = [Sensitivity Specificity Accuracy kappa];
//end

}