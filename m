Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1645AC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Oct 2022 15:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJGPGf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJGPGe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Oct 2022 11:06:34 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9A1DD8A7;
        Fri,  7 Oct 2022 08:06:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bn8so6035462ljb.6;
        Fri, 07 Oct 2022 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvetpNMt4A2GE+wgaRh9E9I38lKPBGEwG8dnPxelXng=;
        b=YgY8AGuy34MS3Jk/VqePmRKNG7ELuNSUExbNe01puHXG1ygTkDXyHTpMhq0nwDejy0
         B24b/O+zAlixrCK4uORirH6A6izNRUyWQg6epuryHi7NAptUEbv7bqAKumjm/1oLrdAw
         +f4zGHikac6T7drHFq+RGh1AuIMcfr9y8PbU6Y0kTS+NZh0zGvZGg6SFoaGlLdOyEh+e
         eYCtAmR7+/DDpX2HGeOZlG9OTnGWeX5442jUg8LarXibOgRqljA2QrAM+rihSDI4hTp6
         wmJTjZVS+cOqlGXg5sQuulU0m5gVbmmUBoQn4r2CVUL2Uu5mukE8ONS98MArE1kOrOHl
         SA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvetpNMt4A2GE+wgaRh9E9I38lKPBGEwG8dnPxelXng=;
        b=7FM+5IF8AHozg/+wlG05o5ExvEXH+Py1FQ6Ubh6E/xB1YaDoD/2t7JhVkwER2iiSQs
         PDPKy42VSJG1AIF+1RrXGfUcGEX1Ta9FXK1H2CJQ3r3bCJSfvTQcaByHAHFgWiYKCsLF
         s6tTcJod7NNuhX5WU1lavKNgcqsVK7FSkNhkp7MIMAU7d6M7MNXQ6rCWeYh3ePvZp0FV
         QABkRiSlst/D/2hD9ZWmKSeGsd9hZdmnjdOMskMz0IKtBpQRgXbsq+PDMeo+QCBHus8d
         7zANSnLeCoZ5nPmWjHLOU9USw2kk8/IR50a/m92wFGRRsCkrUAE3DQDrGyJMYPytaMvP
         xtOQ==
X-Gm-Message-State: ACrzQf1oXdZbtkMIQ3+U0IIgf2Jm7htTgPEvup/Gzjwaq7Wiv9T2oIq4
        VxodW3npT725/Uywgk8h7u+mQHiYzl9GfjGsiJc=
X-Google-Smtp-Source: AMsMyM5DBkabI6V5uUbXJNDW5jgdIQpKljR43oP0GxKxAdlXl6j0W392Z+ljV5/rba1tf1wtE4l4A3w5CNabUo/EM00=
X-Received: by 2002:a05:651c:98e:b0:26a:c93b:18dd with SMTP id
 b14-20020a05651c098e00b0026ac93b18ddmr1950279ljq.487.1665155190598; Fri, 07
 Oct 2022 08:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <e86930e4-4b9c-cf18-5119-50c6910b76dd@redhat.com>
 <Yz7Yv6d3v3oETZYI@google.com> <20221006141302.GW4196@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221006141302.GW4196@paulmck-ThinkPad-P17-Gen-1>
From:   Florent Carli <fcarli@gmail.com>
Date:   Fri, 7 Oct 2022 17:06:19 +0200
Message-ID: <CAJuRqcDeJu6Szo5iUOXMi407CcYyh-3sB1BQA2zFP7GU05h-FA@mail.gmail.com>
Subject: Re: RCU stall warnings even with rcu_nocbs and rcu_nocb_poll
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        rcu@vger.kernel.org, frederic@kernel.org,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thank you all.

I make sure the rcu_preempt kthread affinity was set on a non-isolated
core (as well as all unbounded rcu* threads) so I guess it is not a
competing issue.

What I=E2=80=99m running on those isolated cores are qemu/kvm vcpu tasks, a=
nd
I guess they might spend some time in the kernel=E2=80=A6 in which case I
understand it=E2=80=99s completely normal to see some rcuc activity.
And so I conclude that using isolcpus + nohz_full (which includes
rcu_nocbs) + rcu_nocb_poll + rcutree.kthread_prio is the way to go.

Thanks everyone.

On Thu, Oct 6, 2022 at 4:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Oct 06, 2022 at 01:31:43PM +0000, Joel Fernandes wrote:
> > On Wed, Oct 05, 2022 at 06:03:39PM +0200, Daniel Bristot de Oliveira wr=
ote:
> > > On 10/5/22 18:01, Florent Carli wrote:
> > > > Hello,
> > > >
> > > > I'm trying to isolate some cores to run a CPU-bound real-time task =
and
> > > > even though I'm using rcu_nocbs and rcu_nocb_poll, I can see the rc=
uc
> > > > threads wake up, and I get RCU stall warnings on the isolated core.
> >
> > Isolating a CPU does not mean that RCU activity is forbidden on it, eve=
n with
> > nohz_full, if the CPU enters the kernel (say syscall or interrupt), the=
n it
> > may enter a read-side critical section so RCU will be watching it, and =
such
> > CPU will have to report quiescent state.
>
> What Joel said!
>
> Plus, if you keep that CPU out of the kernel (including avoiding it ever
> taking any interrupts), you won't see rcuc activity on that CPU.
>
> > > > As per the documentation, if I use rcutree.kthread_prio with a
> > > > priority > my RT task, then the rcu stall does not happen.
> >
> > Yes, it sounds like the main RCU GP thread (mostly called rcu_preempt t=
hread)
> > in your system is competing with your RT task. Increase kthread_prio is
> > standard procedure to resolve this issue, as you did.
>
> Or affinity the rcu_preempt kthread elsewhere so that it is not competing
> with your real-time workload.
>
> > > > However I find it confusing: why are the rcuc threads woken up on t=
he
> > > > isolated cores despite using rcu_nocbs and rcu_nocb_poll? In my (ve=
ry
> > > > likely erroneous) understanding, I shouldn't have to fiddle with rc=
u
> > > > priority... In other words, how come I get rcu stalls on cores that
> > > > have no rcu callbacks?
> >
> > It is not possible to provide further help without more info, in partic=
ular
> > are you using nohz_full and isolcpus options? Can you provide kernel
> > and #CPU configuration?
> >
> > Happy to look further! Also adding some more folks who know a lot about=
 this
> > stuff and +rcu list for archives.
>
> The rcuc kthreads communicate between the corresponding CPU and the
> rcu_preempt kthread (AKA RCU GP kthread).  They wake up only when there
> is something for them to do, and letting your nohz_full/rcu_nocbs CPUs
> execute in the kernel is an excellent way to give them something to do.
>
> In particular, if that CPU runs in the kernel, it might have executed
> an RCU read-side critical section.  Because RCU grace periods are not
> permitted to complete until all pre-existing RCU read-side critical
> sections finish, communication is required.
>
> So, yes, that rcuc kthread will need to execute if its CPU queues an
> RCU callback.  But it might also need to execute if some other CPU queues
> an RCU callback -and- its CPU spends significant time in the kernel.
>
>                                                         Thanx, Paul
>
> > thanks,
> >
> >  - Joel
> >
> > >
> > > Adding Joel because we had a chat about it during lpc...
> > >
> > > > Thanks.
> > > >
> > > -- Daniel
> > >
