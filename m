From: John Kacur <jkacur@redhat.com>
Subject: Re: Calculate average latencies on the fly
Date: Tue, 22 Nov 2016 10:43:27 -0500 (EST)
Message-ID: <477381688.1371680.1479829407972.JavaMail.zimbra@redhat.com>
References: <CAK+oA4V8yFDnieAa4tsCQKTapNe6gA_VLJvvEh6_u_jgWpyahQ@mail.gmail.com> <CAK+oA4WFAaT4DmR=8nKqTsyKe9imDYCu5p6DG4kqbhoBPD=LXw@mail.gmail.com> <alpine.LFD.2.20.1611161525280.12617@riemann.fritz.box> <CAK+oA4UTKEazEFZ9+H6xWT7yNw50LNLe+e_DpfwKFvnwaYe1xQ@mail.gmail.com> <alpine.LFD.2.20.1611211928160.8986@riemann> <CAChUvXOj_D2N3o7BoEUjt1A1O0fXZnvGSz5ba=O55h12ns___A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Piotr Gregor <piotrgregor@rsyncme.org>,
        Clark Williams <williams@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
To: Tracy Smith <tlsmith3777@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:49291 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755131AbcKVPnf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 Nov 2016 10:43:35 -0500
In-Reply-To: <CAChUvXOj_D2N3o7BoEUjt1A1O0fXZnvGSz5ba=O55h12ns___A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



----- Original Message -----
> John,
> 
> Latency of 100,000 seems to me to be a bug when doing floating point long
> division, which potentially accumulates small errors.
> 
> Is the issue in the cyclictest calculation or in the kernel?  Or, the FPU?
> 
> If in the kernel, where do we need to trace to check for increased latency
> when doing floating point long division?
> 
> Piotr, needs to trace where the latency is occurring and fix.  Any
> recommendations on a possible fix at this stage?
> 
> Thx, Tracy
> 

Sure, you make some good points, it could be a cyclictest bug, it could be in the kernel, 
he also said he was doing this in a virtualized system, it could be somewhere in that stack.
The first step of course is to see if you can come up with a way to reliably reproduce it.

Thanks

John
