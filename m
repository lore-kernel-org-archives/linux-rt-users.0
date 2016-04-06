From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch 2/2]  rt/locking/hotplug: Fix
 rt_spin_lock_slowlock() migrate_disable() bug
Date: Wed, 06 Apr 2016 14:00:21 +0200
Message-ID: <1459944021.3990.14.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1459405903.14336.64.camel@gmail.com>
	 <20160401211105.GE29603@linutronix.de> <1459566735.3779.36.camel@gmail.com>
	 <1459837988.26938.16.camel@gmail.com> <1459860597.7776.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38382 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbcDFMA0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Apr 2016 08:00:26 -0400
In-Reply-To: <1459860597.7776.2.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It'll take a hotplug beating seemingly as well as any non-rt kernel,
but big box NAKed it due to jitter, which can mean 1.0 things.. duh.

	-Mike
