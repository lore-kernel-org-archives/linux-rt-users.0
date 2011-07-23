From: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Sat, 23 Jul 2011 03:05:57 +0200
Message-ID: <4E2A1E75.4070709@gmail.com>
References: <alpine.LFD.2.02.1107222203400.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40898 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab1GWBGA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 21:06:00 -0400
In-Reply-To: <alpine.LFD.2.02.1107222203400.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/22/2011 10:37 PM, Thomas Gleixner wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.0-rt1 release.
>
> Changes versus 3.0-rc7-rt0:
>
>   * Update to Linus final 3.0 release
>
>   * RTC bugfixes (scheduled for mainline/stable)
>
>   * Long standing (rt only) timer_list bug (see
>     timers-avoid-the-base-null-otptimization-on-rt.patch in the split
>     out quilt queue)
>
>   * Minor non exciting fixes all over the place
>
> Known issues:
>
>   * Some weird "console=..." commandline + config dependent
>     interactions which have been not yet investigated down to their
>     root cause. Result in a boot hang. YMMV
Sweet, works here :)

Only the nvidia driver fails to build because of rtmutex and migrate enable/disable being GPL only, you might want to reconsider the GPL only status of them.

~Maarten
