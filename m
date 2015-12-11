From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RFC] rdtscbench: a nohz_full validation and benchmarking
 tool
Date: Fri, 11 Dec 2015 14:40:27 -0600
Message-ID: <20151211144027.099b2fa0@sluggy.hsv.redhat.com>
References: <1440189958-6959-1-git-send-email-isaac.griswoldsteiner@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jkacur@redhat.com, linux-rt-users@vger.kernel.org, joshc@ni.com,
	Isaac Griswold-Steiner <isaac.griswoldsteiner@ni.com>
To: Isaac Griswold-Steiner <isaac.griswold.steiner@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43386 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbbLKUk3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 15:40:29 -0500
In-Reply-To: <1440189958-6959-1-git-send-email-isaac.griswoldsteiner@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 21 Aug 2015 15:45:58 -0500
Isaac Griswold-Steiner <isaac.griswold.steiner@gmail.com> wrote:

> From: Isaac Griswold-Steiner <isaac.griswoldsteiner@ni.com>
> 
> rdtscbench is a cyclictest-like tool that spawns a thread per cpu. Each thread
> measures the difference in cycle count (using the tsc) during the execution of a
> tight loop.
> 
> This is a simple tool intended to be used for the validation of nohz_full CPU
> configurations. As the validation of nohz_full CPUs is the objective, the tool
> avoids the usage of system calls, timers, or anything that might break nohz_full.
> 


Isaac,

A question and a request.

Was there any particular reason you used sleep() rather than clock_nanosleep() in your cycles_per_second function? I see that you did ten samples but wondered if the slop from a HZ-based wakeup might still introduce some error, as opposed to a more precise programmed wakeup. 

Also, I'd appreciate it if you would expand a bit on the usage section in your README file, specifically how you tune a system prior to running rdtscbench, what output indicates that your tuning is *not* working, versus when to know you're doing the right things. It's probably as simple as saying "if the max latency numbers are spiking you have a problem" but it's good to be explicit about that sort of thing. 

Thanks,
Clark
