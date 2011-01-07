From: David Peverley <pev@sketchymonkey.com>
Subject: Use of CONFIG_PROVE_LOCKING With RT patch
Date: Fri, 7 Jan 2011 14:15:10 +0000
Message-ID: <AANLkTiksy5ULN_gas0DOXYpu8gcbAOVwN__7KCQuUHcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34370 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab1AGOPL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jan 2011 09:15:11 -0500
Received: by gyb11 with SMTP id 11so6576965gyb.19
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Jan 2011 06:15:11 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I'm working with (a modified) linux-2.6.31.12-rt21 and have been
trying to enable CONFIG_PROVE_LOCKING but for my build this
comepletely stops the kernel coming up. Doing a bit of reading through
the config, it seems that when I select PROVE_LOCKING my .config has
the following added :
  CONFIG_DEBUG_MUTEXES=y
  CONFIG_DEBUG_LOCK_ALLOC=y
  CONFIG_PROVE_LOCKING=y
  CONFIG_LOCKDEP=y
  CONFIG_TRACE_IRQFLAGS=y

So one of them is likely to be the individual cause. However, reading
through the config I'm confused... If you read lib/Kconfig.debug you
see that DEBUG_LOCK_ALLOC selects DEBUG_MUTEXES. However DEBUG_MUTEXES
has :
        depends on DEBUG_KERNEL && !PREEMPT_RT
BUT this kernel has PREEMPT_RT set.... Should the config system have
actually set it? The real question of course is that if
CONFIG_DEBUG_MUTEXES shouldn't be included for a PREEMPT_RT kernel,
could this be part of the issue I'm seeing, i.e. its causing the
lockup?

Cheers,

~Pev
