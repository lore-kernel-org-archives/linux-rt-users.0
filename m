From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.11-rt8 NFS triggered seizures
Date: Fri, 07 Jun 2013 14:46:41 +0200
Message-ID: <51B1D631.9040804@linutronix.de>
References: <1368437465.11686.60.camel@marge.simpson.net>  <20130607090300.GC10280@linutronix.de>  <1370603848.5854.42.camel@marge.simpson.net>  <51B1C5CC.7010306@linutronix.de> <1370608481.5854.60.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46240 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3FGMqn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 08:46:43 -0400
In-Reply-To: <1370608481.5854.60.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/07/2013 02:34 PM, Mike Galbraith wrote:
> Yeah, it didn't repeat before DVD download finally finished (after mere
> three _weeks_).  The below fired during the same boot as the last hang,
> but far earlier fwiw.
>
> [10288.045302] ------------[ cut here ]------------
> [10288.045330] WARNING: at kernel/workqueue.c:1575 worker_enter_idle+0xea/0x130()

This is actually something I'm looking at right now. But I can trigger
this only with CPU-hotplug. You don't play with CPU-hotplug, do you?

Sebastian
