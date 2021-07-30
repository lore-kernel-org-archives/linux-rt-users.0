Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3935AC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 01:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184F960F46
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 01:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhG3BPJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 21:15:09 -0400
Received: from afk.unpythonic.net ([138.68.55.246]:44724 "EHLO
        afk.unpythonic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhG3BPI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jul 2021 21:15:08 -0400
X-Greylist: delayed 1206 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jul 2021 21:15:08 EDT
Received: from jepler by afk.unpythonic.net with local (Exim 4.92)
        (envelope-from <jepler@unpythonic.net>)
        id 1m9Gnh-00066P-C6; Thu, 29 Jul 2021 19:54:57 -0500
Date:   Thu, 29 Jul 2021 19:54:57 -0500
From:   Jeff Epler <jepler@unpythonic.net>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Subject: Re: [PATCH] rteval: Add __contains__ in rtevalConfig
Message-ID: <20210730005457.c5kog456adkun4bd@unpythonic.net>
References: <20210729220713.822137-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729220713.822137-1-jkacur@redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jul 29, 2021 at 06:07:13PM -0400, John Kacur wrote:
> Add the __contains__ function to the rtevalCfgSection class  to make "in"
> function correctly.

Thank you.  A possible correction:

I believe the correct implementation (to delegate the 'in' operation to
the dictionary-like object self.__cfgdata) is

    def __contains__(self, key):
        return key in self.__cfgdata

I mocked a bit of rtevalCfgSection with your implementation:
	class rtevalCfgSection:
	    def __init__(self, cfgdata):
		self.__cfgdata = cfgdata

	    def __contains__(self, key):
		if key in self.__cfgdata.keys():
		    return self.__cfgdata[key]
		return None

and then tried it with some carefully chosen values

>>> d = {1: 'x', 2: 'y', 3: None, 4: False}
>>> r = rtevalConfig.rtevalCfgSection(d)
>>> 1 in d, 1 in r
(True, True)
>>> 9 in d, 9 in r
(False, False)
>>> 3 in d, 3 in r
(True, False)

With the corrected implementation, the results would always be the same,
not different in the '3' case.

Additionally, my version avoids extra operation on the underlying
dictionary.

Jeff
