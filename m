From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Why isn't there individual CONFIG in CONFIG_PREEMPT_RT_FULL?
Date: Fri, 22 Nov 2013 15:21:00 +0100
Message-ID: <20131122142100.GB8698@linutronix.de>
References: <526915E2.4040809@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	Steven Rostedt <rostedt@goodmis.org>,
	"Sampath, Pradyumna" <pradyumna@hitachi.co.in>
To: Hiraku Toyooka <hiraku.toyooka.gu@hitachi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44856 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab3KVOVD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 09:21:03 -0500
Content-Disposition: inline
In-Reply-To: <526915E2.4040809@hitachi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Hiraku Toyooka | 2013-10-24 21:43:14 [+0900]:

>Hello,
Hello

>CONFIG_PREEMPT_RT_FULL consists of many patches. I think it doesn't
>represent specific feature but is general term of various features.
>Why don't those features have each CONFIG_* ?

Do you have something in particular in mind?
As long as it makes sense, there are CONFIG_* introduced. If a patch
breaks locks for instance then we don't a special CONFIG item because
this what we need and we don't keep both versions around (and the non-RT
variant can work both ways).

>Best regards,

Sebastian
