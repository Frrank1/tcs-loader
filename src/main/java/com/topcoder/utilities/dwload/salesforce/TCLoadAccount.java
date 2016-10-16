/*
 * Copyright (C) 2004 - 2016 TopCoder Inc., All Rights Reserved.
 */
package com.topcoder.utilities.dwload.salesforce;

import com.topcoder.shared.util.DBMS;
import com.topcoder.shared.util.logging.Logger;
import com.topcoder.utilities.dwload.TCLoadSalesForce;

import java.io.InputStreamReader;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

public class TCLoadAccount extends TCLoadSalesForce {

	private static Logger log = Logger.getLogger(TCLoadAccount.class);

	@Override
	public void performLoad() throws Exception {
		doLoadAccount();
	}

	public void doLoadAccount() throws Exception {
		ArrayList<SFAccount> accounts = new ArrayList<SFAccount>();
		GetMethod get = null;

		try {
			Boolean isLogin = Login();

			HttpClient httpclient = new HttpClient();
			get = new GetMethod(instanceUrl + report_url_account);

			if (isLogin) {
				// set the token in the header
				get.setRequestHeader("Authorization", "Bearer " + accessToken);
			}

			httpclient.executeMethod(get);
			if (get.getStatusCode() == HttpStatus.SC_OK) {
				JSONObject response = new JSONObject(
						new JSONTokener(new InputStreamReader(get.getResponseBodyAsStream())));

				JSONArray rows = response.getJSONObject("factMap").getJSONObject("T!T").getJSONArray("rows");

				for (int i = 0; i < rows.length(); ++i) {
					JSONObject row = (JSONObject) rows.get(i);

					JSONArray dataCells = (JSONArray) row.getJSONArray("dataCells");

					SFAccount account = new SFAccount();
					account.username = ((JSONObject) dataCells.get(0)).getString("label");
					account.accountName = ((JSONObject) dataCells.get(1)).getString("label");
					account.type = ((JSONObject) dataCells.get(2)).getString("label");
					account.rating = ((JSONObject) dataCells.get(3)).getString("label");
					account.dueDate = ((JSONObject) dataCells.get(4)).getString("label");
					account.lastUpdate = ((JSONObject) dataCells.get(5)).getString("label");
					account.address1State = ((JSONObject) dataCells.get(6)).getString("label");

					accounts.add(account);
				}
			}
		} catch (Exception e) {
			DBMS.printException(e);
			throw new Exception("Load of 'salesforce account' report failed.\n" + e.getMessage());
		} finally {
			get.releaseConnection();
		}

		log.info("load account report");
		PreparedStatement update = null;
		PreparedStatement insert = null;
		ResultSet rs = null;

		try {
			long start = System.currentTimeMillis();

			deleteAll();
			
			final String INSERT = "insert into sf_account (user_name, account_name, account_type, rating, due_date, last_update, address_state) "
					+ "values (?, ?, ?, ?, ?, ?, ?) ";

			insert = prepareStatement(INSERT, TARGET_DB);

			int count = 0;
			for (int i = 0; i < accounts.size(); ++i) {
				SFAccount account = accounts.get(i);

				count++;

				insert.clearParameters();
				insert.setObject(1, account.username);
				insert.setObject(2, account.accountName);
				insert.setObject(3, account.type);
				insert.setObject(4, account.rating);
				insert.setObject(5, account.dueDate);
				insert.setObject(6, account.lastUpdate);
				insert.setObject(7, account.address1State);

				insert.executeUpdate();
			}
			log.info("loaded " + count + " accounts in " + (System.currentTimeMillis() - start) / 1000 + " seconds");

		} catch (SQLException sqle) {
			DBMS.printSqlException(true, sqle);
			throw new Exception("Save of 'salesforce account' report failed.\n" + sqle.getMessage());
		} finally {
			close(rs);
			close(insert);
			close(update);
		}
	}

}

class SFAccount {
	public String username;
	public String accountName;
	public String type;
	public String rating;
	public String dueDate;
	public String lastUpdate;
	public String address1State;
}
