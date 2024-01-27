## SIMPLE
fit_model_linreg <- function(df, sigma2 = NULL, anova = TRUE, confAnova = 95, calcCIB0 = TRUE, confB0 = 95,
                             calcCIB1 = TRUE, confB1 = 95, calcCISigma2 = TRUE, confSigma2 = 95,
                             calcCIMeanResp = TRUE, confMeanResp = 95, x0Mean = 0,
                             calcCINewObs = TRUE, confNewObs = 95, x0New = 0) {
  
  # calculate sxx, sxy, and sxy
  sxx = linreg::calculateSXX(df)
  sxy = linreg::calculateSXY(df)
  syy = linreg::calculateSYY(df)
  
  # calculate b1 and b0
  b1 = linreg::calculateB1(df,sxx=sxx,sxy=sxy)
  b0 = linreg::calculateB0(df,B1=b1)
  
  model = list(b0 = b0, b1 = b1)
  
  # calculate correlation coefficient
  r2 = linreg::calculateRSQUARED(df, SST=syy, B1=b1, SXX=sxx, SXY=sxy)
  
  r = linreg::calculateCORRELATIONCOEFF(df, B1 = b1, RSQUARED = r2)
  
  model = c(model, r2 = r2, r = r)
  
  # calculate anova table and evaluate results
  if(anova){
    anovaTable = linreg::calculateANOVATABLE(df, B1=b1, SXX=sxx, SXY=sxy, SYY=syy)
    alpha = 1 - (confAnova/100)
    fc = qf(alpha,1,length_df(df)-1,lower.tail = FALSE)
    
    model = c(model, anova_table = list(anovaTable), fc = fc, reject_h0 = as.numeric(anovaTable[1,4]) > fc)
    
  }
  
  sigma_known = !gtools::invalid(sigma2) 
  
  # calculate MSE
  MSE = linreg::calculateMSE(df)
  model = c(model, mse = MSE)
  
  # calculate B0 CI
  if(calcCIB0){
    b0_ci = linreg::calculateCI_B0(data=df, known=sigma_known, sigma=sigma2, alpha=(1-confB0/100),
                                   B0=b0,MSE=MSE,SXX=sxx)
    model = c(model, b0_ci = b0_ci)
  }
  
  # calculate B1 CI
  if(calcCIB1){
    b1_ci = linreg::calculateCI_B1(data=df, known=sigma_known, sigma=sigma2, alpha=(1-confB1/100),
                                   B1=b1,MSE=MSE,SXX=sxx)
    model = c(model, b1_ci = b1_ci)
  }
  
  # calculate Sigma Square CI
  if(calcCISigma2){
    sigma2_ci = linreg::calculateCI_SigmaSquare(df=df, alpha=(1-confSigma2/100),MSE=MSE)
    model = c(model, sigma2_ci = sigma2_ci)
  }
  
  # calculate Mean Response CI
  if(calcCIMeanResp){
    mean_response_ci = linreg::calculateCI_mean_response(df=df, known=sigma_known, sigma=sigma2,
                                                         a=(1-confMeanResp/100), xo = x0Mean,
                                                         Bo=b0, B1=b1, MSE=MSE,Sxx=sxx)
    model = c(model, mean_response_ci = mean_response_ci)
  }
  
  # calculate New Observation CI
  if(calcCINewObs){
    new_observation_ci = linreg::calculateCI_new_observation(df=df, known=sigma_known, sigma=sigma2,
                                                             a=(1-confNewObs/100), xo = x0New,
                                                             Bo=b0, B1=b1, MSE=MSE,Sxx=sxx)
    model = c(model, new_observation_ci = new_observation_ci)
  }
  
  
  return(model)
  
}


## MULTIPLE
fit_model_cvreg <- function(dfX, dfY, sigma2 = NULL, anova = TRUE, confAnova = 95, confB = 95, indexB,
                            calcCIMeanResp = TRUE, confMean = 95, numbers,
                            calcCINewObs = TRUE, confNew = 95,numbers_new) {
  
  #dfX = cvreg::new_dataframe_x()
  #dfY = cvreg::new_dataframe_y()
  
  X = cvreg::constructX(dfX)
  Y = cvreg::constructY(dfY)
  
  XT_X = cvreg::constructXT_X(X)
  Inv_XT_X = cvreg::constructinverseXT_X(X, XT_X)
  
  XT_Y = cvreg::constructXT_Y(X, Y)
  YT_Y = cvreg::constructYT_Y(Y)
  
  
  B = cvreg::computeB(X,Y,XT_Y=XT_Y,Inv_XT_X=Inv_XT_X)
  
  
  #R2= cvreg::calculateRSQUARED(df)
  
  model2= list( X= X, Y=Y,XT_X= XT_X, Inv_XT_X= Inv_XT_X, XT_Y= XT_Y, YT_Y= YT_Y, B= B)
  
  R2Adj = cvreg::calculateRSQUAREDADJUSTED(X=X,Y=Y)
  model2= c(model2, R2Adj = R2Adj)
  
  if(anova){
    anovaTable = cvreg::calculateANOVATABLE(X,Y,YT_Y=YT_Y,B=B,XT_Y= XT_Y)
    
    alpha = 1 - (confAnova/100)
    k = cvreg::calculateDFR(X)
    n_p=cvreg::calculateDFE(X)
    fc = qf(alpha,k,n_p,lower.tail = FALSE)
    
    model2 = c(model2, anova_table = list(anovaTable), fc = fc, reject_h0 = as.numeric(anovaTable[1,4]) > fc)
  }
  
  
  if(!is.null(indexB)){
    vec=c()
    for (i in indexB){
      CI= cvreg::calculateCI_B(X,Y,alpha = (1-confB/100),index=i,B=B,inverseXT_X=Inv_XT_X,sigma = NULL,known = FALSE)
      vec=cbind(vec,CI)
    }
    
    model2= c(model2, ciB = list(vec))
  }
  
  if(calcCIMeanResp){
    CI_mean = cvreg::computeCI_mean_response (X,Y, X0 = numbers,sigma = NULL, alpha=(1-confMean/100), known = F,inverse_XTX=Inv_XT_X)
    model2= c(model2, ciMean = CI_mean)
    }
  if(calcCINewObs){
    CI_new = computeCI_new_observation (X,Y, X0 = numbers_new,sigma = NULL, alpha=(1-confMean/100), known = F,inverse_XTX=Inv_XT_X)
    model2= c(model2, ciNew = CI_new)
  }
  
  
  return(model2)
  
}
