Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D646C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 11:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F813604AC
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 11:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhHTLH4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 07:07:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41276 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhHTLHz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Aug 2021 07:07:55 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5113722176;
        Fri, 20 Aug 2021 11:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629457637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iUeY0/Jx0gf5IEWcoYEkxJYX/Fu1Jh0sshObrM7GDEs=;
        b=u9Yx8KfwyqLORMaVEEYoQcCFz4FHcNy2HJSrQ85J4EBdhCqStcznwh6SgGS2KkiGwNMeV2
        JUWJcoOOtH6E4kLLlYMzyDsdNoXXSmvBBpbJ9OPsFiAyknkjVV34N98J34RBwo11tOfYF3
        B3OuQ7+ZvehTglUw4GA44FrDB8vYvG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629457637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iUeY0/Jx0gf5IEWcoYEkxJYX/Fu1Jh0sshObrM7GDEs=;
        b=WhfDachJuoxE3D/Wl0du0pqHCORRGgadW/lUXQKklauTJuXqNGCSlwmhsBe7hUbB+1D6Xr
        nGSY6rpNDCD2cHCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4218113AC4;
        Fri, 20 Aug 2021 11:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id I48cEOWMH2FJcgAAGKfGzw
        (envelope-from <dwagner@suse.de>); Fri, 20 Aug 2021 11:07:17 +0000
Date:   Fri, 20 Aug 2021 13:07:16 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.277-rt224
Message-ID: <20210820110716.zmh7te5dvmndssgm@carbon.lan>
References: <162762714720.5121.4789079771844033633@beryllium.lan>
 <20210820104328.GA30359@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820104328.GA30359@amd>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Aug 20, 2021 at 12:43:28PM +0200, Pavel Machek wrote:
> > Sorry for the long delay. I was refactoring and improving my test
> > setup which took a bit longer than I expected. I switched from a
> > Debian based rootfs to an Tumbleweed based one, for obvious
> > reasons. Anyway, this should not matter at all.
> 
> A bit late thanks for the release, BTW. We are maintaining -cip-rt
> based kernels, and were getting worried :-).

Sorry about that. I should have send out a note earlier. Anyway, I'll
plan to work on the next update soon. There are a few futex changes
which collide. It's going to be interesting.

BTW, as you certainly are aware, the v4.4 kernel is EOL soon. As I
understand the CIP is going to take over the maintenance. So I assume
you are going to care of the -rt version as well?
