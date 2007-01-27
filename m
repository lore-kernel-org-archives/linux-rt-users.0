From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Clockevent API change
Date: Sat, 27 Jan 2007 08:12:44 +0100
Message-ID: <45BAFB6C.9070703@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:55189 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbXA0HMs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Jan 2007 02:12:48 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1377651nfa
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Jan 2007 23:12:46 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

it looks to me from patch-2.6.20-rc5-rt2 to 
patch-2.6.20-rc6-rt2 (the versions I tested ;) ) the 
clockevent interface changed?

At least arch/arm/plat-omap/timer32k.c int rc6-rt2 won't 
compile any more.

Changes I noticed:

- CLOCK_EVT_xxx moved to CLOCK_EVT_MODE_xxx

- register_global_clockevent() is replaced by 
clockevents_register_device() and something like

extern struct clock_event_device *global_clock_event

(from arch/i386/kernel/hpet.c)

- .capabilities is switched to .features

- .is_continuous is switched to .flags (clocksource)

Any more changes necessary I not found yet? Any small 
examples what to consider while moving to rc6-rt2? At least 
how to replace register_global_clockevent() correctly?

Many thanks

Dirk
