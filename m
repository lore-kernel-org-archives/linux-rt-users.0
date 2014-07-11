From: Daniel Wagner <daniel.wagner@oss.bmw-carit.de>
Subject: [RFC v1 0/3] Add simple work framework
Date: Fri, 11 Jul 2014 15:26:10 +0200
Message-ID: <1405085173-20449-1-git-send-email-daniel.wagner@oss.bmw-carit.de>
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52410 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753856AbaGKNco (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jul 2014 09:32:44 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

here is my next attempt to fix the crash I see on my system.

I spend considerable time reading up on memory barriers and etc.  Many
thanks to the authors of the excellent documentation
(memory-barriers.txt and Is Parallel Programming hard, And, If So,
What Can You Do About It?)!

After reading it I am pretty sure I got it wrong.

The framework is inspired by the irq_work.c infrastructure. Maybe it
could be merged somehow but I don't know if that is a clever idea.

cheers,
daniel

Daniel Wagner (2):
  work-simple: Simple work queue implemenation
  thermal: Defer thermal wakups to threads

Steven Rostedt (1):
  x86/mce: Defer mce wakeups to threads for PREEMPT_RT

 arch/x86/kernel/cpu/mcheck/mce.c       |  57 +++++++++---
 drivers/thermal/x86_pkg_temp_thermal.c |  48 +++++++++-
 include/linux/work-simple.h            |  35 +++++++
 kernel/sched/Makefile                  |   1 +
 kernel/sched/work-simple.c             | 165 +++++++++++++++++++++++++++++++++
 5 files changed, 292 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/work-simple.h
 create mode 100644 kernel/sched/work-simple.c

-- 
1.9.3

