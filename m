Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EADC77B61
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Apr 2023 13:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbjD1NNJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 09:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346206AbjD1NMx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Apr 2023 09:12:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F32B12B
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Apr 2023 06:12:39 -0700 (PDT)
Date:   Fri, 28 Apr 2023 15:12:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682687558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMx3eHriFjpRdgd6QDc2JrcmF7LYfm7fJQXB6FORXpA=;
        b=Q0Bbw5oJ1zBHL5UhS23gRz5Kxx6/qw/ETXo1KshD02U3O9X6S8OEe+ViXJkqPEpMdEEL1k
        gTQEMsB9HOmRFnk/3HjHhbPvDE2js6FeSi8eI+VtMzyLLUC2oSyq5IV+U2K0u7u69XDj9U
        zBRvz+0Hfmc1UALS8gHyZmO9YcPVGuuiW+nnZPVeetL+b6j9huHw2M//KAX6/HmjB0gTWE
        5/OP4YwY2Hi3voOHiAULEWeUVFCxYhVh38uu+6eYZyNwlEwzmfRje/St2/vXLRXHSb/khh
        FjEweJklBWAYXQhfQYiyayEOuk7E6Tw1m+SQ4tCP42W0fhfeFyyWjTtYPh4KQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682687558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMx3eHriFjpRdgd6QDc2JrcmF7LYfm7fJQXB6FORXpA=;
        b=fNe8H4xtAIMtBuG5D13MebL3l2tKKrDF23epV+sBPwBnUOldXc1k0+LmOnjcmfzAWssgdT
        OmQWfvuv1h4IIKBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rod Webster <rod@vmn.com.au>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
 NIC
Message-ID: <20230428131236.9MfVxN3s@linutronix.de>
References: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
 <20230428085123.HX02J4Ym@linutronix.de>
 <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-04-28 20:46:17 [+1000], Rod Webster wrote:
> Sebastian
Hi Rod,

please keep list in Cc: Avoiding top-posting is a quite nice.

> Thanks, the Real TIme PREEMPT_RT kernel is a prerequisite for
> Linuxcnc. Note in this discussion, I am only referring to X86 machines

Okay. Then it could be related to softirq rework which started in
v5.0.19-rt11 and updated in v5.9-rc6-rt9.=20

Are you able to recompile a kernel?

> although we also install our software on ARM and others.
> linuxcnc-uspace is included in the debian Bookworm repositories and
> linux-image-rt  is one of its dependencies..
> There are really two issues we have experienced. These have only
> become a factor since the 5.X kernels. Only one seems to be relevant
> to the RT project.
> 1. Excessive real time latency/jitter in the Debian RT images. I have
> escalated this to them on their Bug 1034550. Ref
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1034550

As mentioned, the images are provided for convince. Depending one the
problem, the bugs are forwarded sometimes here.

However as per you Debian bug report v4.19-RT is fine, v5.10-RT isn't
and v6.1-RT is better or is it fine?

> 2. Excessive real time network latency/jitter when using the
> PREEMPT_RT kernel when communicating with Intel ethernet hardware in
> an RT environment.

Where is the Intel ethernet coming from? You were saying it is the
realtek nic.

> It is the second issue I wish to bring to your attention.  eg.
> Excessive network latency. This appears to be more prevalent on
> Realtek hardware.
> Note that we document setting hardware-irq-coalesce-rx-usecs 0 on
> Intel NIC's is required. This setting has no effect on other makes of
> NIC's.
>=20
> In relation to Realtek NIC's, I can only speak for Debian but by
> default they use the R8169 Kernel module. (CONFIG_R8169?) They also
> offer the R8168-dkms and R8125-dkms drivers. We have many data points
> from our users that the R8169 driver offers very poor  RT performance.
> But just installing a dkms driver is not enough on Debian to resolve
> the issue.

Is the vendor driver better than in the tree? This is not obvious from
what you are writing.

> We need to also build a RT kernel from the upstream sources and apply
> your RT patches.
>=20
> So aside from the awful high latency/jitter implementation of  RT by
> Debian since the 5.10 kernel (Bookworm), the current strategy to use
> the R8169 as a generic driver is flawed. Debian says to report any use
> of the R8168-dkms driver and they will fix it.
>=20
> A lot of small industrial PC's use Realtek NIC and with the pending
> release of Bookworm now Linuxcnc is in its repos, there will be a wide
> ranging impact.
>=20
> Our FGPA ethernet hardware is capable of reporting maximum ethernet
> read and write times in timer ticks and is used in a point to point
> connection (no routers).
>=20
> I hope you can investigate this matter.

I am surprised to hear the vendor driver is doing fine while the in-tree
driver is bad.

Two things you could do:
- enabling tracing to see what is causing the delays/ latency spike. You
  will need a trigger to notice the latency and then stop the trace at
  this point. If so, I could provide additional steps unless you can do
  it yourself.

- You could try to isolate the realtek driver on one CPU and moving
  everything else to another.

> end
> -Rod Webster
>=20
>=20
>=20
> Rod Webster
>=20
> VMN=C2=AE
>=20
> www.vmn.com.au

Sebastian
