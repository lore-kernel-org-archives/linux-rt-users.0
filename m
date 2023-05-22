Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB0CC77B73
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 May 2023 20:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjEVUz7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 May 2023 16:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjEVUz5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2023 16:55:57 -0400
X-Greylist: delayed 1069 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 13:55:52 PDT
Received: from freeby.mesanet.com (freeby.mesanet.com [108.95.56.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07203C1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2023 13:55:51 -0700 (PDT)
Received: from localhost (IDENT:pcw@localhost [127.0.0.1])
        by freeby.mesanet.com (8.14.3/8.11.0) with ESMTP id 34MKbJPt026896;
        Mon, 22 May 2023 13:37:20 -0700 (PDT)
Date:   Mon, 22 May 2023 13:37:19 -0700 (PDT)
From:   Peter Wallace <pcw@mesanet.com>
To:     Rod Webster <rod@vmn.com.au>
cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
 NIC
In-Reply-To: <CANV1gkcuPVZz6=BrNxWBd9SqB4ydNmJOge6Tir2xG9C050oH1w@mail.gmail.com>
Message-ID: <Pine.NEB.4.64.2305221323260.9144@freeby.mesanet.com>
References: <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
 <20230428131236.9MfVxN3s@linutronix.de> <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
 <20230516105950.kSgA5y-v@linutronix.de> <CANV1gkftrZvhUhXV-mJ-mYmsue3ER33cXCNmVD1bGAc6TmTHuA@mail.gmail.com>
 <CANV1gkfsAfDt76=STFrekQA4M6sfVKyq7bujA=Tu+S6k+EGYcg@mail.gmail.com>
 <20230519083745.AB0-5kD9@linutronix.de> <CANV1gkcah59yVOMZ-s_0TMeMEgpwOaDKSWbdL3Y2Y86RQ+UsKA@mail.gmail.com>
 <20230522093208.NtKNYiYn@linutronix.de> <CANV1gkf+m1n3bLdBg3vP3pzSxiQ1Na53TSbUvLrNNqmKVZvgQQ@mail.gmail.com>
 <ZGuAJu32i1Hf3awN@tpad> <CANV1gkcuPVZz6=BrNxWBd9SqB4ydNmJOge6Tir2xG9C050oH1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 23 May 2023, Rod Webster wrote:

> Date: Tue, 23 May 2023 06:02:13 +1000
> From: Rod Webster <rod@vmn.com.au>
> To: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
>     linux-rt-users@vger.kernel.org
> Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
>     NIC
> 
> This stuff is hard! I just realised that rtapi_app is a red herring!
> rtapi_app is Linuxcnc and there is nothing wrong with it. Its thread
> is on a 1000us cycle so it seems it gets all its jobs done in 200us
> and then sleeps for 800us which makes perfect sense!
>
> The issue we have is deeper than that. I think we should be looking at
> the NIC interrupt (but don't trust the novice!).
> The network communication is consuming more than the 800us slack from
> time to time. When that happens, our hardware sees the timing overrun
> and increments an internal packet error count. If too many of these
> happen in succession, the hardware decides the RT environment can't be
> relied on, disables further communication and returns an "error
> finishing read" to Linuxcnc to say it's given up.
>
> Marcelo, we didn't resort to C. We were able to use a bash script and
> use a linuxcnc tool called halcmd to query the hardware as shown here.
> #!/usr/bin/bash
> stat=0
> while (($stat < 1))
> do
> stat=`halcmd getp hm2_7i96s.0.packet-error-total`
> done
> trace-cmd stop
>
> I think we need to increase the stat threshold  so we get more samples
> in our trace before stopping it. The current trace will only have one
> instance.
> Thanks for letting me see the issue more clearly.
>
>
> Rod Webster
>


I should note that at least for Intel MACs, the 6.3.1-rt13 and 6.4.0-rc2-rt1 
kernels seem to solve the issue. Not sure what changed but maximum read time 
is now in the 200.. 250 usec peak region (about 100 usec more than average) 
This is the peak read latency after about 3 days of videos, compiling and 
local network activity.

Sadly 6.4.0-rc3-rt2 has regressed slightly in network latency on my test 
systems

My test systems were all Intel CPUs with 4 cores, isolcpus=3 and the Ethernet
IRQ pinned to CPU3


Peter Wallace
