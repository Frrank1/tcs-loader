/*
 * Copyright (C) 2004 - 2016 TopCoder Inc., All Rights Reserved.
 */
package com.topcoder.utilities.dwload.salesforce;

import com.topcoder.shared.util.logging.Logger;
import com.topcoder.utilities.dwload.TCLoadSalesForce;

public class TCLoadTCSPre extends TCLoadSalesForce {

	private static Logger log = Logger.getLogger(TCLoadTCSPre.class);

	@Override
	public void performLoad() throws Exception {
		log.info("[TCS LOAD] TCS load running");
	}
}
