Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD02FC48BE6
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 08:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA0061375
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 08:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhFPIC6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Jun 2021 04:02:58 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:36596 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhFPICW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Jun 2021 04:02:22 -0400
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 8433AADC21B;
        Wed, 16 Jun 2021 10:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1623830408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pIhPm5+gNPaQ3LxsxJGoYaJL+rmiFeAqfh2R5NiqU8o=;
        b=bf3YFHSeNOPxLuTWNSjiiKocLTXV2e9iRB9O8zAqRKzAX8l0bNj/BJQby2LmRIhVb7EH4X
        NaW9XtAnt2B5seB46WvrbMxwVZXGkMHb0VvmHHS7Fc1g4XWdH3ZPxyi1HslWTEWay+zFlF
        Qz2SMesoj1SHbfY8WJuq1V+pskrJT40=
Date:   Wed, 16 Jun 2021 10:00:06 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Esben Haabendal <esben@geanix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carlos Jimenez <javashin1986@gmail.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: commit 3d5bfbd97163 versus -rt
Message-ID: <20210616080006.rrv3kdmuozqzchv6@spock.localdomain>
References: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
 <20210615113312.0dad32bb@oasis.local.home>
 <b66ff695-7f75-2a70-7feb-0df4f5ea0608@prevas.dk>
 <37e28373-c6ec-2602-ec5c-cb0b65ce6697@prevas.dk>
 <20210615130959.1de1f52a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615130959.1de1f52a@gandalf.local.home>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello.

On Tue, Jun 15, 2021 at 01:09:59PM -0400, Steven Rostedt wrote:
> On Tue, 15 Jun 2021 18:24:20 +0200
> Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> 
> > > ~ # uname -r
> > > 5.10.42-00001-g10216cf63a12
> > > ~ # grep -ow threadirqs /proc/cmdline
> > > threadirqs
> > > ~ # zcat /proc/config.gz | grep FORCED_THREADING
> > > CONFIG_IRQ_FORCED_THREADING=y
> > > ~ # dmesg | grep WARNING
> > > ~ #  
> > 
> > And as an extra data point, it also doesn't trigger on 5.10.41-rt42
> > configured without PREEMPT_RT but with threadirqs on the command line.
> 
> Sounds to me that there's a "spin_lock_irq*" somewhere in the path, because
> from what I can see, there's not much difference with the IRQ code between
> 5.10.41 and 5.10.41-rt42. But if you are seeing it only with PREEMPT_RT
> set, that tells me that without PREEMPT_RT, interrupts are disabled at that
> point, but not with PREEMPT_RT. The only thing I can think of that would do
> that is a spin_lock_irq*() taken (not a raw_spin_lock_irq*()).

This reminds me [1] and [2].

I'm carrying forward [3] in my domestic kernel build to cope with that.

/cc'ing people involved back then.

[1] https://lore.kernel.org/lkml/20201204201930.vtvitsq6xcftjj3o@spock.localdomain/
[2] https://bugzilla.kernel.org/show_bug.cgi?id=202453
[3] https://gitlab.com/post-factum/pf-kernel/-/commit/f7c99d74cca99d71179d63e827811f0df51bd8fc

-- 
  Oleksandr Natalenko (post-factum)
