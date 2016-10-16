/*
 * Copyright (C) 2004 - 2016 TopCoder Inc., All Rights Reserved.
 */
package com.topcoder.utilities.dwload.salesforce;

import com.topcoder.shared.util.logging.Logger;
import com.topcoder.utilities.dwload.TCLoadTCS;

public class TCLoadTCSPost extends TCLoadTCS {

    private static Logger log = Logger.getLogger(TCLoadTCSPost.class);

    @Override
    public void performLoad() throws Exception {
        log.info("[TCS LOAD] SUCCESS: TCS load ran successfully.");
    }
}
