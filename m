Return-Path: <SRS0=KcY/=CQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783BBC43461
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Sep 2020 08:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4A8208C7
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Sep 2020 08:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgIGINU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:13:20 -0400
Received: from mail.monom.org ([188.138.9.77]:35786 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbgIGINR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Sep 2020 04:13:17 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 42C07500658;
        Mon,  7 Sep 2020 10:13:14 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 124DA50029E;
        Mon,  7 Sep 2020 10:13:14 +0200 (CEST)
Date:   Mon, 7 Sep 2020 10:13:13 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests 0/4] Streamlining code base?
Message-ID: <20200907081313.vyw2ykaio6abfxfx@beryllium.lan>
References: <20200902082725.20037-1-dwagner@suse.de>
 <20200903203948.4d2e5370@tagon>
 <20200904063123.uu37gp4ipom64ao6@beryllium.lan>
 <alpine.LFD.2.23.451.2009041112370.4562@fionn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.23.451.2009041112370.4562@fionn>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Sep 04, 2020 at 11:40:06AM -0400, John Kacur wrote:
> I'm not saying this is the only legitimate approach, but I would like to 
> keep the individual tools lightweight in rt-tests, so that you could run 
> them individually in the embedded space as well as on large machines.

Sure, though I still think it would make sense to keep it flexible and
have a compile switch if needed. I'd like to avoid additional steps
between the measurement and interpretation. Any time we want to
add/change a thing, we need to touch more places.

Furthermore, if you look at my implementation for the JSON output of
jitterdebugger is really small:

https://github.com/igaw/jitterdebugger/blob/master/jitterdebugger.c#L158

Adding a XML version for this should be in the same size.

If you insist on a single format (XML) that's also okay for me. Python
ships all the necessary libraries these days. Though the JSON format is
simpler to transform into native data types such as dictionaries and
lists, IMO.

Anyway, I don't have any strong feeling and have no real problem with
one format and a transform script.

> So one way to start would be to make sure that the other tools in the 
> rt-tests suite are capable of generating a similar kind of output, that 
> could then be processed by other tools.

Yes, I'd like to get consistent output from all tools.

Though I think we should start from the beginning and getting all
command line arguments parser, help texts and man pages consistent.
