/*
 * Copyright (C) 2004 - 2016 TopCoder Inc., All Rights Reserved.
 */
package com.topcoder.utilities.dwload.tcsredshift;

import com.topcoder.shared.util.DBMS;
import com.topcoder.shared.util.logging.Logger;
import com.topcoder.utilities.dwload.TCLoadTCSRedshift;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;


public class TCLoad_ConnectProjects extends TCLoadTCSRedshift {

    private static Logger log = Logger.getLogger(TCLoad_ConnectProjects.class);

    @Override
    public void performLoad() throws Exception {
        doLoadProjects();
    }

    public void doLoadProjects() throws Exception {
        log.info("load connect projects");
        PreparedStatement select = null;
        PreparedStatement insert = null;
        PreparedStatement update = null;
        ResultSet rs = null;

        try {
            long start = System.currentTimeMillis();
            final String SELECT = "select id, name, description, details " +
                    "from projects";
            final String UPDATE = "update connect_project set name = ?,  description = ?, details = ?" +
                    " where id = ? ";
            final String INSERT = "insert into connect_project (id, name, description, details) " +
                    "values (?, ?, ?, ?) ";

            select = prepareStatement(SELECT, SOURCE_DB);
            // select.setTimestamp(1, java.sql.Timestamp.valueOf("2006-11-11 00:00:00"));
            update = prepareStatement(UPDATE, TARGET_DB);
            insert = prepareStatement(INSERT, TARGET_DB);
            rs = select.executeQuery();

            int count = 0;
            while (rs.next()) {
                count++;
                log.debug("PROCESSING project " + rs.getLong("id"));

                //update record, if 0 rows affected, insert record
                update.clearParameters();
                update.setObject(1, rs.getObject("name"));
                update.setObject(2, rs.getObject("description"));
                update.setObject(3, rs.getObject("details").toString());
                update.setLong(4, rs.getLong("id"));

                int retVal = update.executeUpdate();

                if (retVal == 0) {
                    //need to insert
                    insert.clearParameters();
                    insert.setLong(1, rs.getLong("id"));
                    insert.setObject(2, rs.getObject("name"));
                    insert.setObject(3, rs.getObject("description"));
                    insert.setObject(4, rs.getObject("details").toString());

                    insert.executeUpdate();
                }

            }
            log.info("loaded " + count + " records in " + (System.currentTimeMillis() - start) / 1000 + " seconds");


        } catch (SQLException sqle) {
            DBMS.printSqlException(true, sqle);
            throw new Exception("Load of 'contest' table failed.\n" +
                    sqle.getMessage());
        } finally {
            close(rs);
            close(select);
            close(insert);
            close(update);
        }
    }

}