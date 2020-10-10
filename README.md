# MyCleanning_project

- This is my final coursera project in : Getting and Cleaning Data .
- I include in my repository the *run_analysis.R* script  where i made the project following the steps descrives in the *CodeBOOK.md* file.

# Transformations
**1.** *Merges the training and the test sets to create one data set.*


 - Create a *x_data* variable where  can put *x_train* and *x_test*  objects using *rbind()*. 
 
- Create a *y_data* variable where  can put *y_train* and *y_test*  objects using *rbind()*. 

- Create a *subject* variable where  can put *subject_train* and *subject_test*  objects using *rbind()*. 

- Create a *Marged* variable where  can put *subject* and *x_data*  objects using *cbind()*. 

**2.** *Extracts only the measurements on the mean and standard deviation for each measurement.*

- Select only the colums *subject* and *code*  with *mean* and *std* , for each variable.

**3.** *Uses descriptive activity names to name the activities in the data set*
- Remplace code for activities variable

**4.** *Appropriately labels the data set with descriptive variable names.*
- In this step we only have to change the names of the variables, using the gsub() function ( ?gsub)

**5.** *From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject*
- Save all in *tidy_dataset.txt*.



