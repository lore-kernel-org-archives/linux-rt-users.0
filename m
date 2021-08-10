Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358C9C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 07:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187DE6101E
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 07:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhHJHl7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhHJHl6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 03:41:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C80C061796
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Aug 2021 00:41:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id a93so34591250ybi.1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Aug 2021 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qp943ub0jldWVZ9owaEyqZgHjINwL7xyZe5IOsCcsGY=;
        b=n9M7FsEJvDq2yAv/s67IT0zyZ7aCAbsIg+hWP63pl+V82z+N+hhkiX2BHgPcxkZipz
         DFz8lQ4gdslXwTRwNR4IDMlnxxkHONYpy4l9UOEL+9UMzG9mR+y1oSH+4jFzb+InqtCF
         3+nwHajkLJcNA5xptY5d7Tz8gB/wVb2iWaQi5sZfetaHWO8Gq3F0rJ/B3s+KkyKpCUmm
         y5AIf88hKampfPHdwuZM+Or1mIDEcRxVQ0v5r68p7lqoaIXHxBvpGFZLRFWAL5MPSCgp
         2EjSVOJrsKnmUXCEGL95723lt/UOqHgu3ryoWIV4yWtSQHxKVTNF4nKf1OrmOZa0c1XP
         nW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qp943ub0jldWVZ9owaEyqZgHjINwL7xyZe5IOsCcsGY=;
        b=FzGZReE74h/bWZdqqGNZ4FuGa2IezkEYJxP28G6R4j5OJcvRwc2yMcej4uzfjA/ewC
         7//6EMxpbxEhXTMxa++9fD6534/KDKsuuLeKlmVg+pxUZRbyM5vuCEzy0cyhq+nWWlpi
         EQxbwLRf8KurUDnguhLpyjppPihCReJUY7CrOYlJn7nZkQAuq9XDzIBGaJe0TjvLzoM7
         2RoQuvmadEDgm7HHbHGdj9rQ5HOW5LpEExH64+70QWssC3lFTsI3XaWmBw9znHkYTkoG
         D82UV79arx+e5jqzE+psTK0ExJkv5BAQouIpM7wRHEKIpsU7FREEATTygdGDQ+liVhpl
         4cwg==
X-Gm-Message-State: AOAM5338bllLoEddmfSkcsMkqistljehgPDRmNwt387IXrMt+LP2sBiD
        KGRI/xB+GC/hxDoOg5g/Tx8BCtx/JHkEM2pMTYY=
X-Google-Smtp-Source: ABdhPJxugScn/RXqDLM/qLitvbYjpci7MgXZoRjr313gSXxsOUowz3+F4pAVjn9NjClMuXSy+MJfyj7KUjIz0r/UGek=
X-Received: by 2002:a25:1805:: with SMTP id 5mr34310633yby.77.1628581296334;
 Tue, 10 Aug 2021 00:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAFzL-7sj+Y79UC-CnB+6qDRe7EgPnjb0be63CwEJOfkdCvJYVw@mail.gmail.com>
 <002901d78da6$129f8250$37de86f0$@gmail.com>
In-Reply-To: <002901d78da6$129f8250$37de86f0$@gmail.com>
From:   Jack Winch <sunt.un.morcov@gmail.com>
Date:   Tue, 10 Aug 2021 08:41:25 +0100
Message-ID: <CAFhCfDZybPqmWK2=HSTDOBT-hswkqEPUUbs428x8TBsKbLybKg@mail.gmail.com>
Subject: Re: hyperthreading and RT latency
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
Cc:     Alison Chaiken <achaiken@aurora.tech>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Alison,

You've already had a number of answers to your query already, but I'll
chime in with my two cents anyhow.

Although I am no longer in a position to provide actual data (having
left my previous employer a few weeks back, where I ran some
experiments for myself), my findings were similar in nature to those
of Jonathan (on a Gen 10 HPE ProLiant server, with a 5.x-rt kernel).

For our application, the 'random' latencies induced by the enabling of
hyper-threading were deemed acceptable and, given our overall
configuration of the target system, allowed for more satisfactory
performance across the range of applications and tasks running on the
system overall.  Hence, we kept it enabled despite the additional
latency noise.  So it all comes down to your use-case, the
configuration and particulars of your target system, and your system
performance requirements.

As John has pointed out already, the best thing to do is to try to
quantify any effects of enabling / disabling hyper-threading on your
system and to evaluate the effects with respect to your system
performance requirements.  This advice applies across the board when
trying to determine what impact certain system configuration changes
have on the real-time performance of your system.  The rt-tests suite
of tools may help you to do so.  If you've not used them already, I
*strongly* recommend you get familiar with these tools and their use,
as they are a crucial component of the RT Linux developer toolkit.
The following Wiki page links to some useful information regarding the
use of these tools, as well as other tools useful for RT Linux
development: https://wiki.linuxfoundation.org/realtime/documentation/howto/=
tools/start.

Jack

On Tue, Aug 10, 2021 at 7:54 AM Jonathan Schwender
<schwenderjonathan@gmail.com> wrote:
>
> Hi Alison,
>
> > Is the advice still current?   Should we RT-users all still turn hypert=
hreading off?
>
> I ran some tests as a part of my master's thesis in the beginning of this=
 year with the 5.10-rt kernel on an Intel Broadwell-EP 2-socket server.
> If you are interested, I can dig up the graphs I made, but the jist regar=
ding wake-up latencies measured by _cyclictest_ (24 hours each) is:
> 1. Task-isolation (placing the RT-task on a dedicated core) + Cache alloc=
ation + disabled Hyperthreading yields the best latencies. Something around=
 4-5us worst-case latencies were possibly with some optimizations.
> 2. Placing a load (rteval) together with cyclictest increases the latenci=
es, but worst-case latencies of I think 16us are still okay for many applic=
ations
> 3. Isolating a task on a dedicated CPU and placing a load (rteval) on the=
 neighbor CPU sharing the same core yields strictly worse latencies compare=
d to 2). I think it was around 50us worst-case.
> 4. Isolating a task on a dedicated core (hyperthreading disabled), but en=
abling hyperthreading for the non-critical cores seems to have a rather sma=
ll negative impact, as long as CAT is used to reserve cache for the isolate=
d core. I'd have to look up the details though.
>
> I don't think the situation has improved on more modern hardware, since A=
FAIK the SMT hardware has no knowledge of your tasks priority.
>
> >Thanks,
> >Alison Chaiken
>
> Best Regards,
>
> Jonathan Schwender
>
