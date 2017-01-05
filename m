From: Julia Cartwright <julia@ni.com>
Subject: Re: NO_HZ and ktimersoftd
Date: Thu, 5 Jan 2017 10:32:10 -0600
Message-ID: <20170105163210.GJ1335@jcartwri.amer.corp.natinst.com>
References: <CACKey4zmx_=k6r8BY3B7K9ZuR6x5=11U25-st4oK8WAgo1WgQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>
To: Federico Reghenzani <federico.reghenzani@polimi.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:59789 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1761257AbdAEQcQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Jan 2017 11:32:16 -0500
Content-Disposition: inline
In-Reply-To: <CACKey4zmx_=k6r8BY3B7K9ZuR6x5=11U25-st4oK8WAgo1WgQQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 05, 2017 at 10:29:57AM +0100, Federico Reghenzani wrote:
> Hi all,
>

Hello-

> I'm trying to setup a RT Linux system (currently on 4.8.2 PREEMPT_RT
> patched), and I enabled he NO_HZ_FULL flag in order to reduce the
> scheduling interrupts jitter. Trying to isolate one core, I also moved
> all interrupts and threads to other CPUs.
> 
> This works fine, however when I run my RT application, the thread
> kimersoftd is always in "running" state, thus the scheduling interrupt
> triggers (because there exists more than 1 task available to run).
> Consequently, the advantages of NO_HZ_FULL are vanished.

This sounds like the same problem that Haris (cc'd) has looked into and
has put together a proposed solution.  See the thread here:

   http://www.spinics.net/lists/linux-rt-users/msg16113.html

   Julia
