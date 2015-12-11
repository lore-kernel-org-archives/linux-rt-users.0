From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RFC] rdtscbench: a nohz_full validation and benchmarking
 tool
Date: Fri, 11 Dec 2015 17:26:07 +0100
Message-ID: <20151211162607.GD6720@linutronix.de>
References: <1440189958-6959-1-git-send-email-isaac.griswoldsteiner@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: williams@redhat.com, jkacur@redhat.com,
	linux-rt-users@vger.kernel.org, joshc@ni.com,
	Isaac Griswold-Steiner <isaac.griswoldsteiner@ni.com>
To: Isaac Griswold-Steiner <isaac.griswold.steiner@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47096 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbbLKQ0K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 11:26:10 -0500
Content-Disposition: inline
In-Reply-To: <1440189958-6959-1-git-send-email-isaac.griswoldsteiner@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Isaac Griswold-Steiner | 2015-08-21 15:45:58 [-0500]:

>From: Isaac Griswold-Steiner <isaac.griswoldsteiner@ni.com>
>
>rdtscbench is a cyclictest-like tool that spawns a thread per cpu. Each thread
>measures the difference in cycle count (using the tsc) during the execution of a
>tight loop.
>
>This is a simple tool intended to be used for the validation of nohz_full CPU
>configurations. As the validation of nohz_full CPUs is the objective, the tool
>avoids the usage of system calls, timers, or anything that might break nohz_full.
>
>Signed-off-by: Isaac Griswold-Steiner <isaac.griswoldsteiner@ni.com>

jkacur, williams: did you guys took a look on it?

Sebastian
