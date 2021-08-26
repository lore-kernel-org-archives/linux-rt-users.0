Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44C3C432BE
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 08:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A2D60FD7
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 08:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbhHZIm4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 04:42:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53762 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhHZIm4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Aug 2021 04:42:56 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE8B321E4D;
        Thu, 26 Aug 2021 08:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629967324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZgR+1O6XWssyOYsYbXTDPR6fPO26fOilqbVed3JReY=;
        b=C7b5xhZu9EbLS45AEfY/HNfUMROlwapmxOhVCC+ARu92Q3jEst9XMcoqD0gsphRd8ErdmW
        0CF0aSb5FMeebYZYYDz5xbGHbwwImtvsPLI2crVH7xwUgdgVPAy9AloLWO8yPHQnO31lCf
        fTetcCO6kwvu3PA7QF83fnLO6coUphQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629967324;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZgR+1O6XWssyOYsYbXTDPR6fPO26fOilqbVed3JReY=;
        b=nhYydRLfzI99QvT43QjU1HdPsfHsA5nbAUektEvC8WmDxIsaHtMEBD8VXKpuX4VUy00dja
        +NcBzIhBpT0l1hAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AED6313A0F;
        Thu, 26 Aug 2021 08:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id /hyjKtxTJ2EFEAAAGKfGzw
        (envelope-from <dwagner@suse.de>); Thu, 26 Aug 2021 08:42:04 +0000
Date:   Thu, 26 Aug 2021 10:42:04 +0200
From:   Daniel Wagner <dwagner@suse.de>
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
Subject: Re: [ANNOUNCE] 4.4.277-rt224
Message-ID: <20210826084204.gr7i5vundenqmmnb@carbon.lan>
References: <162762714720.5121.4789079771844033633@beryllium.lan>
 <20210820104328.GA30359@amd>
 <20210820110716.zmh7te5dvmndssgm@carbon.lan>
 <20210820175301.GA4791@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820175301.GA4791@amd>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Pavel,

On Fri, Aug 20, 2021 at 07:53:01PM +0200, Pavel Machek wrote:
> FYI we are on 2 month cycle for -cip-rt, so we are still fine for a
> while. We had trouble coordinating matching -cip and -rt releases, but
> we decided to adjust -cip cycle to match -rt, so that should be solved.

Oh, my bad. I was aiming for about a release per month but I didn't
really pay attention on my own schedule.

> > BTW, as you certainly are aware, the v4.4 kernel is EOL soon. As I
> > understand the CIP is going to take over the maintenance. So I assume
> > you are going to care of the -rt version as well?
> 
> We are aware, but I don't think we decided what will happen at that
> point (and I can't really speak for the project). We plan to maintain
> -cip and -cip-rt variants till 2027:
> 
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/start

Understood.

> Taking over -stable and -stable-rt maintainance, too, is something
> that may make sense (and we probably will be considered), but it is
> likely CIP Technical Steering Committee's (“TSC”) decision.
> 
> https://www.cip-project.org/about/charter
> 
> Actually, your input may be important here. If you (or SuSE or someone
> else) can put some resources into 4.4-rt after February 2022, that
> would be good to know.

Speaking with my upstream hat on: I don't think this likely to
happen. The stable-rt maintainers are happy to get rid of the older
releases as it gets harder over time to keep it alive. That's why we
stop maintaining the -rt variant as soon the matching stable branch hits
EOL.

With my SUSE hat on: we maintain our own version of rt on top of our
SLES kernel. Our v4.4 based kernels (which has significant changes
compared to the upstream stable v4.4 tree) have entered the long time
support period (LTTS). So I fear there is little interest from our side
to keep the upstream v4.4-rt branch alive. Obviously, the CIP project
could talk to our business people :)

Daniel
