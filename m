Return-Path: <SRS0=JPb9=DF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D82DC2D0A8
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Sep 2020 23:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B232076B
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Sep 2020 23:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1XRh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:17:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:47568 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgI1XRh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Sep 2020 19:17:37 -0400
IronPort-SDR: XfbPz8Kv9yBocNnwIpZlu9PfecZKVBlEqtwgDTrzkZWnihoZpzMVVrFkBAJYGJ2uvoAA+Ccs0E
 euj5pTcV06Zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="162133485"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="162133485"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 15:14:25 -0700
IronPort-SDR: epYtWamIwdTIV0k9UY6kE0eivROMRgLRieeCzo6wLrwEbITDpzPWLhqQOPRZ2agf5Ufx+uTr7l
 /IeW4rUTFHjg==
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="345042420"
Received: from wraymatt-mobl1.amr.corp.intel.com ([10.251.18.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 15:14:24 -0700
To:     linux-rt-users@vger.kernel.org
From:   Randy Witt <randy.e.witt@linux.intel.com>
Subject: rt-tests v1.9 fails to compile on architectures that aren't x86_64,
 i386 or PPC64
Message-ID: <62cb6195-7116-db1d-2af2-264dbd854ddb@linux.intel.com>
Date:   Mon, 28 Sep 2020 15:14:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

With the addition of the oslat test in v1.9, "make" with no arguments will fail 
on any architecture that isn't x86_64, i386 or PPC64. This is due to the #error 
added here 
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/oslat/oslat.c?h=v1.9#n72.

Since there is no build time configuration to turn off particular tests, is the 
expected workflow to specify the set of desired tests as make arguments?

In the absence of some sort of configure script, should there be a variable that 
allows for tests to be removed from the set of TARGETS?
