Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAF6C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 11:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CD16103D
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 11:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhIJL4z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:56:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38102 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhIJL4y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Sep 2021 07:56:54 -0400
Date:   Fri, 10 Sep 2021 13:55:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631274942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lwd+DOAdiJN95wYFWWA7tKQ1/DoKlDnps57FX4LuBuo=;
        b=cDuYZVTcrePLwRM8gH4aatMHEoD34ixvoJxD7Tg4n3L0PyLsqNskmjKUi63Gub4w+rbglM
        lsjO0nPuYUopHOL1/R8b0SaQewKiei0qNwXDP4QLloNdwWWsU74LvCbW7QoqPRBSGsHbvY
        scNYSytoog3oLF564TTHQHCuDxi0mPZ+1U692L4ZLWJQ32fyym7BNZmucWw+AFoGfWwkT9
        qLWu8f5Mj082S+z/okIx8KOnNFTE6+G654U3rUJ3JEmjI60KmT+FfCuWV+QEBlduRpCcEr
        snnFFp+V9VpAKupb2azVNFQOPXs78huMVCxlBqdkR3Yt+OPopi2/WTZRv9imOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631274942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lwd+DOAdiJN95wYFWWA7tKQ1/DoKlDnps57FX4LuBuo=;
        b=wTC922689fmqE3/HsQL4F+7jQSuZpCrAVA8CwVCmYPpxvl3j/F7Vw+eQnhQ4O2a8j22DtN
        u03OEbtZYRSt7lDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Runge <dave@sleepmap.de>,
        Kristian Hoegsberg <krh@bitplanet.net>,
        linux1394-devel@lists.sourceforge.net,
        linux-rt-users@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <20210910115541.jjf3fovv4v3etvde@linutronix.de>
References: <YB3TLNN39/XhUyUY@hmbx>
 <YB+5tdIpbTfnDnIi@hmbx>
 <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx>
 <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
 <20210218092751.ahn262llcpp2loz7@linutronix.de>
 <20210308141210.yoa37dsc26p4jsim@linutronix.de>
 <YEkMvjJt/Vu9Jbgu@hmbx>
 <YTfy7pLhWkTOn+aI@hmbx>
 <YTgdLkTs7wEmj8fh@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTgdLkTs7wEmj8fh@workstation>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-08 11:17:18 [+0900], Takashi Sakamoto wrote:
> Hi,
Hi,

> According to the log, the task of 'pipewire-media-:2554' is blocked during
> 122 seconds by call of 'wait_for_completion()' in code of
> 'fw_run_transaction()'. This is odd in two points of transaction service
> programmed in Linux FireWire subsystem:
> 
> 1. The process context should be awakened by softIRQ context, which should
>    be scheduled by hwIRQ context for hardware interrupt of OHCI 1394
>    controller.
> 2. Even if the softIRQ context is not invoked, the process context
>    should be awakened by wheel timer context, which is scheduled to finish
>    the transaction several jiffies later (originally prepared for the case
>    of split-transaction). In the case, the result of transaction is
>    'RCODE_CANCELLED'.


Side note: David is using PREEMPT_RT and his problem can be reduced to
plain vanilla with `threadirqs' boot option. Back in February I sent him
a patch [0] which inlines the tasklet job as I assumed it is not good
reset the IRQ-event in the tasklet/workqueue. It seemed to improve the
situtation as it recognized the device attached to the bus but ended
then in the same timeout behaviour as now.

[0] https://https://lkml.kernel.org/r/.kernel.org/all/20210218083849.iitcrhdgv2oajfhv@linutronix.de/

> Thanks
> 
> Takashi Sakamoto

Sebastian
