Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF50C433FE
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Nov 2022 14:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiKOORC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 09:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbiKOOMA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Nov 2022 09:12:00 -0500
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EBD2C12A;
        Tue, 15 Nov 2022 06:11:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC007E2FE4;
        Tue, 15 Nov 2022 15:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1668521491; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=ne/3jyKom2lQgAwFtGJahNfk2KHgoEcNBV8FpjNoqQA=;
        b=eg1mQnSp8xi85FB5eF74hbLK3fWVSjEIj22zzqoFHhS+yQGwIFtxu4l/Wlrv14tsITCfdJ
        z7niA7GAjvHimTjtufde39MWszonuGg4VXRDoDv23lhWoruTvKY0WdR7lCBC+ZPL8iC2iX
        ZyrWkPsDi3lHKpeTekpqMibChBupLU/nDjM0AYD4suOgFWyHWMjBKqr97GcKK2nkeIACI6
        eqqT5PwwpTk04IXFJdLAjfZuJS4UDNwDlFnMWlQSEih+b7W0X1kojsWmFJC+AxIvutHXPx
        owATplBs0194k3DauXBGdUX7+Tq1fOp2SRmNGXwUChxCt/xHAs0iyOByWgc/MQ==
Date:   Tue, 15 Nov 2022 15:11:27 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] 4.19.261-rt116
Message-ID: <20221115141127.afwm534e47yj2ybb@carbon.lan>
References: <166845241635.12044.11510831858945534704@beryllium.lan>
 <Y3KSiYf2WAct0Oks@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3KSiYf2WAct0Oks@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Nov 14, 2022 at 08:10:01PM +0100, Pavel Machek wrote:
> https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.261-rt116.patch.xz
> 
> Thank you, I'll take a look.
> 
> Just out of curiosity, what happened to -rt115? I see announcements
> for -rt114 and then -rt116.

When we (stable-rt maintainers) do the updates we tag all merges which
had a conflict. So in this case when I updated from 4.19.255 to
4.19.261, there was merge conflict in 4.19.257:

  Merge tag 'v4.19.257' into v4.19-rt

  This is the 4.19.257 stable release

  Conflicts:
	net/core/dev.c

We do this to make it more obvious when we need to touch code by hand
which makes any verification later on simpler. But these intermediated
steps are not separately announced/released. There are available in the
git tree but not as tar files.
