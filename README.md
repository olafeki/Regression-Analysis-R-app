# regression-analysis-application

App deployed to [shinyapps.io](https://7qa8yk-verina-michel.shinyapps.io/reg_run/)

This was our final project for the Regression Analysis course taught by Prof. Amr Amin.<br/>
The project requested initially was to implement simple and multiple regression from scratch using R. We decided to bundle our implementation into a package, and create a simple UI that uses this implementation for performing Linear Regression Analysis.<br/><br/>

Here are the two packages we implemented:
- [linreg](https://github.com/verinak/linreg) : for Simple Linear Regression
- [cvreg](https://github.com/verinak/cvreg) : for Multiple Linear Regression

## Application Overview

The application starts with a written introduction to linear regression.<br/><br/>
<img width="800px" src="media/1.png" alt="help page">
<br/><br/>

From the tabs at the top left, the user can pick to perform either simple or multiple regression analysis.<br/>
The user can then upload data (allowed file formats: csv, txt, json, xls/xlsx, psv, tsv, rds, fwf, sas7bdat, sav, dta) into the application, and specify the X and Y variables. They can customize the type of calculations they would like to perform (ANOVA, Confidence Intervals). Then, they can fit the model, view the output, and return to change any of their previous choices then recalculate again.
<br/><br/>

The Simple tab (uses linreg package): <br/><br/>
<img width="800px" src="media/5.png" alt="select y in simple tab">
<img width="800px" src="media/7.png" alt="example of available calculations in simple tab">
<img width="800px" src="media/9.png" alt="fitted model in simple tab">
<br/><br/>

The Multiple tab (uses cvreg package): <br/><br/>
<img width="800px" src="media/11.png" alt="selected x and y in multiple tab">
<img width="800px" src="media/14.png" alt="fitted model in multiple tab pt1">
<img width="800px" src="media/17.png" alt="fitted model in multiple tab pt2">
<br/><br/>


## Contributors
[Ola Mamdouh](https://github.com/olamahdi)<br>
[Verina Michel](https://github.com/verinak)<br>
[Marly Magdy](https://github.com/marlymagdy)<br>
[Maria Anwar](https://github.com/Maria1516)<br>
[Mirna Tarek](https://github.com/Mirna-tarek)<br>
[Mariem Nasr](https://github.com/MariemNasr)<br>
