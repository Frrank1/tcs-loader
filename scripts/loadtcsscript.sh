CP=$BASE_DIR/target/tcs-loader-1.0.0.jar

echo $CP

java -cp $CP com.topcoder.shared.util.dwload.TCLoadUtility -xmlfile $BASE_DIR/scripts/loadredshift.xml

# java -cp $CP com.topcoder.shared.util.dwload.CacheClearer
