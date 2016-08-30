From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: nvidia 370.23 not compiling against rt-patched kernel
Date: Tue, 30 Aug 2016 12:44:16 +0200
Message-ID: <20160830104416.ub7mcxhrgcrmp74x@linutronix.de>
References: <4b0c04a5-82c8-dc36-8503-c2f7defafb12@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Bernhard Landauer <oberon@manjaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44922 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbcH3KoS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 30 Aug 2016 06:44:18 -0400
Content-Disposition: inline
In-Reply-To: <4b0c04a5-82c8-dc36-8503-c2f7defafb12@manjaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-08-18 20:57:34 [+0200], Bernhard Landauer wrote:
> Latest nvidia 370.23 driver is unhappy with 'rt_mutex_destroy' and the
> extramodule fails to build with
> 
> FATAL: modpost: GPL-incompatible module nvidia-drm.ko uses GPL-only symbol
> 'rt_mutex_destroy'
> 
> This concerns 4.6.5_rt10 aswell as 4.4.17_rt25 at least
> What can we do about that?

This is not -RT only related. An unpatched kernel should have the same
problem. The EXPORT_SYMBOL_GPL(mutex_destroy) is here since commit
408894ee4dd4 ("[PATCH] mutex subsystem, debugging code") / v2.6.16 by
Ingo Molnar.

You could disable CONFIG_DEBUG_MUTEXES or look for alternatives for this
driver.

> kind regards
> Bernhard Landauer

Sebastian
