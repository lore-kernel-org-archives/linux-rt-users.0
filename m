Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B6BC77B7A
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 11:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjESLlu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjESLls (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 07:41:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85BA191
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 04:41:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso1446923a12.1
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmn-com-au.20221208.gappssmtp.com; s=20221208; t=1684496503; x=1687088503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlkOHYkIbbOK0JmllvBuLHn0hh9L6aHQht1qHyvjOJo=;
        b=puZWAZcSTIhCsA6JZL4t+C7LgAPtvXAddByM7yfmhPOpfQ+HoWZfC8eNvFJNhoehzx
         ZtrIItCG70WMZroboZ9V8qzV+o5YeaNnWGxJyMIKH7chKdhELBzYRa5hEhmw+Fu5Gysj
         /0NgX+7JIQgvyaY6epJrgSq1f1DaWKE5s8D+o/Q2PwHVBZ1+EdFAomIZD1/aJRrFC1Qe
         OSYY2MtDS9I50raWF7d7sPszSk3Ip2vQDxVARa1nO0ZljZm9idoCOdd6qp73NDNlLMEb
         7FEMbb2fpLeGRhHGTmr8lZe3JhS1y8euLMYnR8G6J59GFWbFPADIs7hUq5gRP/e92y+d
         DxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684496503; x=1687088503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlkOHYkIbbOK0JmllvBuLHn0hh9L6aHQht1qHyvjOJo=;
        b=XzBBhlz4wBw99K7ZBNAXcelKOBiKNcZp3hid7VHdHEPPeNbTu67Qerc5sduJCSPLX4
         RuysQ1cq4V6WOgQdZiZDGxEnDPUTMifqSdD8tjWyqPm+L4IACrRYd3Y+jvH4axjmr9ub
         sV8XyPPKa27qaRVUMExdcO2uEQmLT+sI7Yrs+Fzx23uOxPXcO1Pcs+qhi6RKbVrxVNaZ
         r+7bm0iW9ba9hIJdnhO0i9Z8N67GgIVJBcCvrWTFF7AGByuIOj+urKVUJoIThZgd2u6M
         pbdILppVhOcui7UOuyEQQjl+AAVJ7QKjuacR1NscgV+tR7W4+wInHwqoVccIIQXNWbQt
         0ZYA==
X-Gm-Message-State: AC+VfDwub+QMGWdQAIaE6clIR/AM4PyGN27o8h7OszfeHt8YDeqrly52
        9exMQJjEIZK7BmOzo9TcZ3KLPVyJnSlMGaEF5wg0tSo9atTJc8x1
X-Google-Smtp-Source: ACHHUZ6LhRq0kB43UWFGECbj1wDe4ruL4cqLinzEAoGQ/lOTKxxrPRd/OqUbAaafGRwQw7dB1i2oDJxtxjlSNz12BJY=
X-Received: by 2002:a05:6402:1603:b0:4ad:738b:6706 with SMTP id
 f3-20020a056402160300b004ad738b6706mr2260141edv.2.1684496503031; Fri, 19 May
 2023 04:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
 <20230428085123.HX02J4Ym@linutronix.de> <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
 <20230428131236.9MfVxN3s@linutronix.de> <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
 <20230516105950.kSgA5y-v@linutronix.de> <CANV1gkftrZvhUhXV-mJ-mYmsue3ER33cXCNmVD1bGAc6TmTHuA@mail.gmail.com>
 <CANV1gkfsAfDt76=STFrekQA4M6sfVKyq7bujA=Tu+S6k+EGYcg@mail.gmail.com> <20230519083745.AB0-5kD9@linutronix.de>
In-Reply-To: <20230519083745.AB0-5kD9@linutronix.de>
From:   Rod Webster <rod@vmn.com.au>
Date:   Fri, 19 May 2023 21:41:30 +1000
Message-ID: <CANV1gkcah59yVOMZ-s_0TMeMEgpwOaDKSWbdL3Y2Y86RQ+UsKA@mail.gmail.com>
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al NIC
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is something weird going on, I have an i5 PC with R8111 NIC
which was problematic until I installed the R8168-dkms driver and the
6.3 kernel I compiled. It regularly threw packet errors on a RT thread
that fires every 1 ms.
I wanted to revert it so I could do these tests.
So I purged  the R8168-dkms driver to revert to the R8169 and rolled
back to a Debian 6.1 RT kernel. It's still running isolcpus=3D2,3
The darn thing refused to generate a packet error until I dropped the
thread timing to fire every 0.15 ms.
So it seems the process of installing and uninstalling has changed the
driver environment.
I do recall having something similar accidentally happen to another PC
once before.  I think it was related to the install and uninstall of
the 8168-dkms driver.
Any ideas what could be going on?

I will do some testing tomorrow now I know what's going on but I
wonder how relevant it will be given this turnaround?


Rod Webster





Rod Webster

VMN=C2=AE

www.vmn.com.au

Ph: 1300 896 832

Mob: +61 435 765 611




On Fri, 19 May 2023 at 18:37, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-05-18 20:15:20 [+1000], Rod Webster wrote:
> > Sebastian,
> Hi Rod,
>
> > I have cc'd Marcelo here as he has offered to help.
> >
> > I am attaching the last 1000 lines or so of our trace (I hope
> > attachments are allowed)
> >
> > Our bash script to terminate the trace was called PacketErrorTest. It
> > loops until the hardware reports a packet error.
> > The script contains:
> > #!/usr/bin/bash
> > stat=3D0
> > while (($stat < 1))
> > do
> > stat=3D`halcmd getp hm2_7i96s.0.packet-error-total`
> > done
> > trace-cmd stop
> >
> > I must say we have no idea what we are looking at but can't see
> > anything obvious to a layperson.
> > Please advise next steps
>
> I don't see much wrong here. Maybe the trace isn't long enough.
> However what I saw is that your networking interrupt isn't threaded and
> then all networking is outsourced to ksoftirqrd which might get less
> processing time if there is much going on.
> It would help if you enable NAPI threads: As root, please do
>
>         echo 1 > /sys/class/net/enp2s0/threaded
>
> This will spawn a few threads named "napi/enp2s0-$napi_id. The
> actual number of threads depends on the number of NAPI instances
> (usually queues) used by the driver.
> Once you identified them, please pin them the right CPU and adjust the
> priority:
>         taskset -pc 2 $pid
>         chrt -p -f 50 $pid
>
> The taskset command will pin the NAPI thread to CPU2. This is what I see
> in your trace where the interrupt is active. It is good to have them
> (the interrupt and the interrupt thread or the NAPI thread in your
> case) running on the same CPU. The chrt will adjust the priority of the
> thread from SCHED_OTHER to a SCHED_FIFO priority 50.
>
> By default all interrupt threads run at priority 50 (middle priority).
> They get preferred over all tasks with lower priority including
> SCHED_OTHER tasks. SCHED_OTHER (the default scheduling class) tasks get
> preempted once they used their time slice so that they don't lock up the
> system. This isn't the case with SCHED_FIFO.
>
> This realtek/r8169 driver is not using interrupts threads in your
> configuration. While I don't see any API breakage I am rethinking the
> whole softirq concept and moving to NAPI threads might not be that bad.
> Be aware that _now_ you don't have any "overloading" concept. I.e. what
> should be done if the system is receiving a lot of packages that it
> didn't ask for (say ping flood or so). Before this change, the NAPI
> would hand over to ksoftirqd running at SCHED_OTHER so it would be
> balanced with other tasks within the system.
>
> An explanation of the trace you sent:
> |  PacketErrorTest-2552  [002]   191.050337: irq_handler_entry:    irq=3D=
125 name=3Denp2s0
>    Running Task          <CPU>               Interrupt occurred    networ=
k card
>
> |  PacketErrorTest-2552  [002]   191.050339: softirq_raise:        vec=3D=
3 [action=3DNET_RX]
> |  PacketErrorTest-2552  [002]   191.050339: irq_handler_exit:     irq=3D=
125 ret=3Dhandled
> |  PacketErrorTest-2552  [002]   191.050340: sched_waking:         comm=
=3Dksoftirqd/2 pid=3D37 prio=3D120 target_cpu=3D002
> |  PacketErrorTest-2552  [002]   191.050343: sched_wakeup:         ksofti=
rqd/2:37 [120] CPU:002
>
> It scheduled NAPI (NET_RX) which is processed in softirq. Since this
> happened in hardirq context ("trace-cmd report -l" would reveal that) it
> wakes ksoftirqd for the processing.
>
> |  PacketErrorTest-2552  [002]   191.050344: sched_stat_runtime:   comm=
=3DPacketErrorTest pid=3D2552 runtime=3D587973 [ns] vruntime=3D15925574432 =
[ns]
> |  PacketErrorTest-2552  [002]   191.050346: sched_switch:         Packet=
ErrorTest:2552 [120] R =3D=3D> ksoftirqd/2:37 [120]
> |      ksoftirqd/2-37    [002]   191.050347: softirq_entry:        vec=3D=
3 [action=3DNET_RX]
> |      ksoftirqd/2-37    [002]   191.050351: softirq_exit:         vec=3D=
3 [action=3DNET_RX]
>
> Here receiving of network packets is completed. Timing wise,
> 191.050351 - 191.050337 =3D 14us after the interrupt triggered. Looking
> through the whole file, it ranges from 6us to 14us (17 samples).
> So it doesn't look bad. If processing would get preempted and would need
> a few millisecond then it would be bad.
>
> > Rod Webster
> >
> > VMN=C2=AE
> >
> > www.vmn.com.au
>
> Sebastian
