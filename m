Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD368C433FE
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Nov 2022 14:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiKOOOO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 09:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKOOON (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Nov 2022 09:14:13 -0500
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09DE93;
        Tue, 15 Nov 2022 06:14:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15A67E2FE4;
        Tue, 15 Nov 2022 15:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1668521650; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=nSGz13j1+sOReITv81Luepc/Qt1sJb/py2yAKou24VQ=;
        b=ybW99bBVn2Ijff6yiH36OlPP0NsQ2SSrun64555tANVifCqwjanlYMOu6WkpHTDZpgr9sF
        sK8/H0/HsJNcuTkCQ2scfD5HQxB08AfZzkb1VHP92nvzZsbxXSRr5AWqqqV1EBh/4nERNM
        a8gDgBTjpNBzu7XTuj3lwPD2B79ab+aJjZkuuQlgICrhhxhSru0fmSoxLGFxOSTexwX7pa
        FJmyi9Nk/uWbpzBNqfDthcfZBHK18lM+Toh7FpjhbJhVEMN1X1K6uBiJv344QPxISIrw0d
        C2pXekNcqJmGT3ZR4I4KHrU2Kwcf6j1+5emkraKwiH0UHYtKv7rboK4fOqekYA==
Date:   Tue, 15 Nov 2022 15:14:08 +0100
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
Message-ID: <20221115141408.nmdicdl6g66yfxkr@carbon.lan>
References: <166845241635.12044.11510831858945534704@beryllium.lan>
 <Y3KSiYf2WAct0Oks@duo.ucw.cz>
 <Y3KXHRz9qzzok/yH@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3KXHRz9qzzok/yH@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Nov 14, 2022 at 08:29:33PM +0100, Pavel Machek wrote:
> I see the -rt115 in git. I guess 4.19.265-based -rt release can be
> expected soon?

It seems I missed to update my local git tree before starting with the
update... /me goes back to do another update
