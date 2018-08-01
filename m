Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from goliath.siemens.de ([192.35.17.28]:56349 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388930AbeHAOwW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Aug 2018 10:52:22 -0400
Date: Wed, 1 Aug 2018 14:52:38 +0200
From: Henning Schild <henning.schild@siemens.com>
Subject: CONFIG_RT_GROUP_SCHED on RT
Message-ID: <20180801145238.777d71a7@md1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <cbe@osadl.org>
Cc: linux-rt-users@vger.kernel.org

Hi,

i just wanted to have a look at RT_GROUP_SCHED as a way to prevent
crashing real-time applications from starving other rt application, in
the case of prio based scheduling.
I had to find out that the feature is not compatible with PREEMPT_RT
and quickly traced it down to the following commit:

"sched: Disable CONFIG_RT_GROUP_SCHED on RT"

https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulg/3.4-rt-patches/+/1b19454df58db731fa9ca09b34909d28d4eef968/patches/0133-sched-Disable-CONFIG_RT_GROUP_SCHED-on-RT.patch

My current theory is that there never was a problem with the two not
being compatible ... it was more likely a broken userland, more
specific a broken cgroups setup.
Further my theory is, if you set cgroups up correctly both featues can
most likely be combined without a problem ... 
But maybe i am totally wrong and there are some reasons, in that case
the commit should be a little more verbose. And i would be happy to
hear about it.

On newer systems ... systemd is the reason ... fits the "works in ssh
but not in rc.local"

https://www.freedesktop.org/wiki/Software/systemd/MyServiceCantGetRealtime/

> Note that this all only applies to services.
> ...

On older systems it might have been libcgroup/cgconfig like explained
here:
https://github.com/jackaudio/jackaudio.github.com/wiki/Cgroups
http://jackaudio.org/faq/linux_group_sched.html

regards,
Henning
