From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RFC] rdtscbench: a nohz_full validation and benchmarking
 tool
Date: Fri, 11 Dec 2015 10:44:22 -0600
Message-ID: <20151211104422.2fd21bd3@sluggy.hsv.redhat.com>
References: <1440189958-6959-1-git-send-email-isaac.griswoldsteiner@ni.com>
	<20151211162607.GD6720@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Isaac Griswold-Steiner <isaac.griswold.steiner@gmail.com>,
	jkacur@redhat.com, linux-rt-users@vger.kernel.org, joshc@ni.com,
	Isaac Griswold-Steiner <isaac.griswoldsteiner@ni.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43447 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbbLKQoY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 11:44:24 -0500
In-Reply-To: <20151211162607.GD6720@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 11 Dec 2015 17:26:07 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Isaac Griswold-Steiner | 2015-08-21 15:45:58 [-0500]:
> 
> >From: Isaac Griswold-Steiner <isaac.griswoldsteiner@ni.com>
> >
> >rdtscbench is a cyclictest-like tool that spawns a thread per cpu. Each thread
> >measures the difference in cycle count (using the tsc) during the execution of a
> >tight loop.
> >
> >This is a simple tool intended to be used for the validation of nohz_full CPU
> >configurations. As the validation of nohz_full CPUs is the objective, the tool
> >avoids the usage of system calls, timers, or anything that might break nohz_full.
> >
> >Signed-off-by: Isaac Griswold-Steiner <isaac.griswoldsteiner@ni.com>
> 
> jkacur, williams: did you guys took a look on it?
> 
> Sebastian

I haven't yet. Will look at it this afternoon.

Clark
