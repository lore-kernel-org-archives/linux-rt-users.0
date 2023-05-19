Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDBFC77B75
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 08:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjESIhx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 04:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESIhw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 04:37:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7BFC2
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 01:37:50 -0700 (PDT)
Date:   Fri, 19 May 2023 10:37:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684485468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAOprV7iQ4WQtOMTvE1k8T4xlRwiVsbBLVJ7tcFT97w=;
        b=eSO8T8yWRbaKJE08D8k/82Xzq7v4hrxGxtFHkLw00WRoe86dV3chHNM07uFGXVA7d6rphX
        Smn669g+WZkjvAhTt/cUBtlU/hqj221X0Qs92C1comO/A/+KRFLBjeGZ39gDhQr8L4FWTq
        vX8wzFhieM0GEfzOLX1w23k8T3Nk0M4bx9ie1c107mCP+QIX9kRAUuUYDR/N73trKu5Tou
        T5sYVj4ORYq3HLhUL3LcuyvNeE/8vBa9nEd9rpJkwrBcn1dPwj30pkUYUXrMbwrD2NKKfY
        dLAILcfjBUYSKtOS23cHy0HfcrW/KZcyxNqGu46PRc+kXWA/by+P5xiQKgJk/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684485468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAOprV7iQ4WQtOMTvE1k8T4xlRwiVsbBLVJ7tcFT97w=;
        b=SaXHfZvZxqomQnc/4IgVeprLdegYQbaGANFYLgwL+pz9afxNtrK8Ztj77je9MKQvqdE6t6
        rvM/WjDRLtaV/bBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rod Webster <rod@vmn.com.au>
Cc:     linux-rt-users@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
 NIC
Message-ID: <20230519083745.AB0-5kD9@linutronix.de>
References: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
 <20230428085123.HX02J4Ym@linutronix.de>
 <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
 <20230428131236.9MfVxN3s@linutronix.de>
 <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
 <20230516105950.kSgA5y-v@linutronix.de>
 <CANV1gkftrZvhUhXV-mJ-mYmsue3ER33cXCNmVD1bGAc6TmTHuA@mail.gmail.com>
 <CANV1gkfsAfDt76=STFrekQA4M6sfVKyq7bujA=Tu+S6k+EGYcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANV1gkfsAfDt76=STFrekQA4M6sfVKyq7bujA=Tu+S6k+EGYcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-05-18 20:15:20 [+1000], Rod Webster wrote:
> Sebastian,
Hi Rod,

> I have cc'd Marcelo here as he has offered to help.
>=20
> I am attaching the last 1000 lines or so of our trace (I hope
> attachments are allowed)
>=20
> Our bash script to terminate the trace was called PacketErrorTest. It
> loops until the hardware reports a packet error.
> The script contains:
> #!/usr/bin/bash
> stat=3D0
> while (($stat < 1))
> do
> stat=3D`halcmd getp hm2_7i96s.0.packet-error-total`
> done
> trace-cmd stop
>=20
> I must say we have no idea what we are looking at but can't see
> anything obvious to a layperson.
> Please advise next steps

I don't see much wrong here. Maybe the trace isn't long enough.
However what I saw is that your networking interrupt isn't threaded and
then all networking is outsourced to ksoftirqrd which might get less
processing time if there is much going on.
It would help if you enable NAPI threads: As root, please do

	echo 1 > /sys/class/net/enp2s0/threaded

This will spawn a few threads named "napi/enp2s0-$napi_id. The
actual number of threads depends on the number of NAPI instances
(usually queues) used by the driver.
Once you identified them, please pin them the right CPU and adjust the
priority:
	taskset -pc 2 $pid
	chrt -p -f 50 $pid

The taskset command will pin the NAPI thread to CPU2. This is what I see
in your trace where the interrupt is active. It is good to have them
(the interrupt and the interrupt thread or the NAPI thread in your
case) running on the same CPU. The chrt will adjust the priority of the
thread from SCHED_OTHER to a SCHED_FIFO priority 50.

By default all interrupt threads run at priority 50 (middle priority).
They get preferred over all tasks with lower priority including
SCHED_OTHER tasks. SCHED_OTHER (the default scheduling class) tasks get
preempted once they used their time slice so that they don't lock up the
system. This isn't the case with SCHED_FIFO.

This realtek/r8169 driver is not using interrupts threads in your
configuration. While I don't see any API breakage I am rethinking the
whole softirq concept and moving to NAPI threads might not be that bad.
Be aware that _now_ you don't have any "overloading" concept. I.e. what
should be done if the system is receiving a lot of packages that it
didn't ask for (say ping flood or so). Before this change, the NAPI
would hand over to ksoftirqd running at SCHED_OTHER so it would be
balanced with other tasks within the system.

An explanation of the trace you sent:
|  PacketErrorTest-2552  [002]   191.050337: irq_handler_entry:    irq=3D12=
5 name=3Denp2s0
   Running Task          <CPU>               Interrupt occurred    network =
card

|  PacketErrorTest-2552  [002]   191.050339: softirq_raise:        vec=3D3 =
[action=3DNET_RX]
|  PacketErrorTest-2552  [002]   191.050339: irq_handler_exit:     irq=3D12=
5 ret=3Dhandled
|  PacketErrorTest-2552  [002]   191.050340: sched_waking:         comm=3Dk=
softirqd/2 pid=3D37 prio=3D120 target_cpu=3D002
|  PacketErrorTest-2552  [002]   191.050343: sched_wakeup:         ksoftirq=
d/2:37 [120] CPU:002

It scheduled NAPI (NET_RX) which is processed in softirq. Since this
happened in hardirq context ("trace-cmd report -l" would reveal that) it
wakes ksoftirqd for the processing.

|  PacketErrorTest-2552  [002]   191.050344: sched_stat_runtime:   comm=3DP=
acketErrorTest pid=3D2552 runtime=3D587973 [ns] vruntime=3D15925574432 [ns]
|  PacketErrorTest-2552  [002]   191.050346: sched_switch:         PacketEr=
rorTest:2552 [120] R =3D=3D> ksoftirqd/2:37 [120]
|      ksoftirqd/2-37    [002]   191.050347: softirq_entry:        vec=3D3 =
[action=3DNET_RX]
|      ksoftirqd/2-37    [002]   191.050351: softirq_exit:         vec=3D3 =
[action=3DNET_RX]

Here receiving of network packets is completed. Timing wise,
191.050351 - 191.050337 =3D 14us after the interrupt triggered. Looking
through the whole file, it ranges from 6us to 14us (17 samples).
So it doesn't look bad. If processing would get preempted and would need
a few millisecond then it would be bad.

> Rod Webster
>=20
> VMN=C2=AE
>=20
> www.vmn.com.au

Sebastian
