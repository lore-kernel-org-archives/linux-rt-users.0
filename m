From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: -rt kernel just can show 8 perf events?
Date: Fri, 11 Dec 2015 18:36:16 +0100
Message-ID: <20151211173616.GL6720@linutronix.de>
References: <565E04D5.4000202@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: "Shi, Yang" <yang.shi@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49168 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbLKRgT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 12:36:19 -0500
Content-Disposition: inline
In-Reply-To: <565E04D5.4000202@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Shi, Yang | 2015-12-01 12:36:37 [-0800]:

>Hi folks,
>
>I'm running some perf program on my x86-64 machine with 4.1.12-rt13
>kernel, but I found just 8 perf events can be showed up with "perf
>stat -e" on -rt kernel, but mainline kernel is fine.

And 4.1.12 (without -rt13) is not having this kind of problem?

>Regards,
>Yang

Sebastian
