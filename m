Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:43158 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKHT2q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Nov 2018 14:28:46 -0500
Date: Thu, 8 Nov 2018 10:53:57 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: system() instruction creates latency peaks
Message-ID: <20181108095356.mou6ymmmsde5mepq@linutronix.de>
References: <trinity-d772b31d-ea20-4c6d-92d9-387f0952bf76-1540308456962@3c-app-mailcom-lxa13>
 <20181023214812.3sqxq7w7xtnh6b2h@unpythonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181023214812.3sqxq7w7xtnh6b2h@unpythonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Jeff Epler <jepler@unpythonic.net>
Cc: verrodj@uymail.com, linux-rt-users@vger.kernel.org

On 2018-10-23 16:48:12 [-0500], Jeff Epler wrote:
> Hi, I have experienced similar symptoms in realtime programs (LinuxCNC).
> We have a control thread which sometimes does operations like system(),
> and one or more realtime threads.
> 
> There, we changed from using system() to using posix_spawn and it
> appears to have resolved the problem.
> 
> However, I don't have any explanation as to why this is the case.  On
> the specific version of glibc I have, posix_spawn uses vfork and system
> uses clone; other syscalls like rt_sigaction are taken in the system
> case but not the posix_spawn case.

The fork() makes the whole memory COW (every write access will cause a
page fault, see mlock(2) man page).

> Jeff

Sebastian
