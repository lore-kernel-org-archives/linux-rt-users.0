From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: System hung for a few minutes on rt kernel
Date: Mon, 7 Aug 2017 15:51:04 +0200
Message-ID: <20170807135104.nt5tsatjwcvttvve@linutronix.de>
References: <b9015e55-85fa-9e1c-736a-746c439e635d@jajcus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Jacek Konieczny <jajcus@jajcus.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44431 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbdHGNvG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Aug 2017 09:51:06 -0400
Content-Disposition: inline
In-Reply-To: <b9015e55-85fa-9e1c-736a-746c439e635d@jajcus.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-07-30 19:37:41 [+0200], Jacek Konieczny wrote:
> Hi,
Hi,

> 
> Jul 30 19:12:22 lolek kernel: [drm:intel_pipe_update_end [i915]] *ERROR*
> Atomic update failure on pipe A (start=40468 end=40469) time 173 us, min
> 1073, max 1079, scanline start 1068, end 1081
> [...]
> Jul 30 19:18:46 lolek kernel: [drm:intel_pipe_update_end [i915]] *ERROR*
> Atomic update failure on pipe A (start=63501 end=63502) time 249 us, min
> 1073, max 1079, scanline start 1065, end 1081
> Jul 30 19:19:58 lolek kernel: [drm:intel_pipe_update_end [i915]] *ERROR*
> Atomic update failure on pipe A (start=67818 end=67819) time 100 us, min
> 1073, max 1079, scanline start 1072, end 1080
> Jul 30 19:21:33 lolek kernel: [drm:intel_pipe_update_end [i915]] *ERROR*
> Atomic update failure on pipe A (start=73522 end=73523) time 127 us, min
> 1073, max 1079, scanline start 1071, end 1080
> 
> System seems to be working correctly after the lockup.
> 
> Any ideas what is going on?

It is possible, that the task doing i915 hung for some reason and
blocked other tasks while doing so. I can't answer why. But it looks
like once i915 recovered, it released some locks and the remaining part
of the system continued to work.

One thing: You could if the number of your problems decrease if you
switch from CONFIG_NOHZ_FULL to CONFIG_HZ_PERIODIC.

> Jacek

Sebastian
