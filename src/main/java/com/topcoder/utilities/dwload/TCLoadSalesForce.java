/*
 * Copyright (C) 2004 - 2015 TopCoder Inc., All Rights Reserved.
 */
package com.topcoder.utilities.dwload;

import com.topcoder.shared.util.dwload.TCLoad;
import com.topcoder.shared.util.logging.Logger;

import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Hashtable;
import java.util.Locale;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

/**
 * <p>
 * <strong>Purpose</strong>: A modified version of <strong>TCLoadTCS</strong>
 * where the source database is on salesforce.
 * </p>
 * <p>
 * Derived from version 1.4.3 of <strong>TCLoadTCS</strong>, see the original
 * class documentation for a full change log.
 * </p>
 * 
 * @author suisl
 * @version 1.0.0
 */
public abstract class TCLoadSalesForce extends TCLoad {

	private static Logger log = Logger.getLogger(TCLoadSalesForce.class);

	public TCLoadSalesForce() {
		DEBUG = false;
	}

	protected String clientId = null;
	protected String clientSecret = null;
	protected String username = null;
	protected String password = null;
	protected String grant_type = null;
	protected String loginURL = null;

	protected String auth_type = null;

	protected String accessToken = null;
	protected String instanceUrl = null;

	protected String report_url_account = null;

	protected Boolean Login() throws Exception {
		if ("oauth2".equals(auth_type)) {
			LoginWithOAuth2();
			return true;
		} else if (auth_type.equals("none")) {
			return false;
		} else {
			log.error("Unsupported auth type found. auth_type = " + auth_type);
			return false;
		}
	}

	private void LoginWithOAuth2() throws Exception {
		log.debug("Getting a token");
		HttpClient httpclient = new HttpClient();
		PostMethod post = new PostMethod(loginURL);
		post.addParameter("grant_type", "password");
		post.addParameter("client_id", clientId);
		post.addParameter("client_secret", clientSecret);
		post.addParameter("username", username);
		post.addParameter("password", password);

		try {
			httpclient.executeMethod(post);
			JSONObject authResponse = new JSONObject(
					new JSONTokener(new InputStreamReader(post.getResponseBodyAsStream())));
			log.info("Auth response: " + authResponse.toString(2));

			accessToken = authResponse.getString("access_token");
			instanceUrl = authResponse.getString("instance_url");
		} catch (HttpException e1) {
			throw e1;
		} catch (IOException e1) {
			throw e1;
		} finally {
			post.releaseConnection();
		}
		log.debug("We have an access token: " + accessToken + "\n" + "Using instance " + instanceUrl + "\n\n");
	}

	/**
	 * This method is passed any parameters passed to this load
	 */
	public boolean setParameters(Hashtable params) {
		if (params.containsKey("auth_type")) {
			auth_type = (String) params.get("auth_type");

			if (auth_type.equals("oauth2")) {
				// oauth2
				clientId = (String) params.get("clientId");
				clientSecret = (String) params.get("clientSecret");
				username = (String) params.get("username");
				password = (String) params.get("password");
				grant_type = (String) params.get("grant_type");
				loginURL = (String) params.get("loginURL");
			} else if (auth_type.equals("none")) {
				// no auth required.
			} else {
				log.error("Unsupported auth type found. auth_type = " + auth_type);
			}
		}

		report_url_account = (String) params.get("report_url_account");

		return true;
	}

	/**
	 * Helper method that deletes all accounts.
	 */
	protected void deleteAll() throws SQLException {
		PreparedStatement delete = prepareStatement("delete from sf_account", TARGET_DB);
		long count = delete.executeUpdate();
		log.info("" + count + " records deleted in sf_account table");
	}
}
