Return-Path: <SRS0=mgec=B3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920F8C433E1
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 11:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695CF20674
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 11:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qg7MPqCZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aU2XoWuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHQLNY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgHQLNX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Aug 2020 07:13:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089ACC061389
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Aug 2020 04:13:16 -0700 (PDT)
Date:   Mon, 17 Aug 2020 13:13:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597662793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bC3mA4F5q/xXTF9Q3+3pp3zhtUrEAPuelVH3Xf9TSM=;
        b=qg7MPqCZXSG/NOn/t3faCgx8GMj/xjw4NvB8HY7HpFMsl+LhpsIVsU5tfA+oYYK7bzgUcX
        ui5LMklzPBAP1bbagAsUJkiDqufRSJSCul8gt2Dh1vEqv+Y3P/KYmJs0ePk/gtvEnvqjk7
        sc/drMkfCDpUIKAf1dDvAMHMRAStE6CzQKOe39db8a3nu4/i1o27DEgGBN6Ie5AUhHVB9p
        sIlhTHUEuesVYNpOdGCg/OWODmzHMjMqwBv7ZVHBK5TUQFsHrscuiEJkYRCI60BFL98cw7
        weupnBJBdWYNk3luOB9Sw/qLqqK4uLR/ilOBexDHR0H1udSZTPmyDLekUeXQ2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597662793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bC3mA4F5q/xXTF9Q3+3pp3zhtUrEAPuelVH3Xf9TSM=;
        b=aU2XoWuLSOMZyndfpiXZ/xHy9ZUKnrlJXPytmhqMz0Mb3r4DfOo0iHRm3heBda/J6zVzYN
        wYmxARGjDfIXjvAQ==
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     Roosen Henri <Henri.Roosen@ginzinger.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: Re: RT kernel v4.14 NULL pointer dereferences
Message-ID: <20200817111311.zyqjznhferoqqxkh@linutronix.de>
References: <fd9d435b3f6a5f4ffd7ef93763e78c087871d565.camel@ginzinger.com>
 <20200814115848.w4m2bfqttkid6woi@linutronix.de>
 <25412beffb96ab8c2b8f869bdac5a66c49faa5ca.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25412beffb96ab8c2b8f869bdac5a66c49faa5ca.camel@ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-17 08:12:31 [+0000], Roosen Henri wrote:
> > Is the 4.14 series the only one that is affected?
> 
> No, unfortunately not.
> 
> I ended up testing the v4.14.184-rt84 on two systems and the v5.4.45-
> rt27 on another system, all iMX6Q. Only one of the v4.14 systems is
> still running, the other v4.14 system dumping backtraces until
> eventually reset, the v5.4 system endlessly dumping backtraces:
> 
> v4.14: https://paste.ubuntu.com/p/ZdFYhs4pjx/
> v5.4: https://paste.ubuntu.com/p/wZPCQv8KjX/

So the 5.4 has an uptime of 45 days until this start?

> If the backtraces don't point to a root-cause, are there any kernel
> configuration options which are usefull to track this issue down?

The 5.4 is not complete, it started earlier and this might be a
follow-up problem (it seems to originate in die()).
You could send me the config, I have an imx6q somewhere so I might be
able to take a look. However I want sort another ppc issue first.

> Thanks!

Sebastian
