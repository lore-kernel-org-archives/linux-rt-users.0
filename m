From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 0/1] Lock problem when setting cpufreq variables
Date: Mon, 16 Feb 2015 16:41:46 +0100
Message-ID: <20150216154146.703580675@osadl.org>
References: <20150216145826.GD21649@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:33128 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755730AbbBPPxH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Feb 2015 10:53:07 -0500
In-Reply-To: <20150216145826.GD21649@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

your 3.18.7-rt1 kernel compiled without problem. First quick test
shows good latency values (i7 at rack #4, slot #6) and looks
promising. Will continue testing on more machines and architectures.

The cpufreq problem that first appeared in 3.14 - obviously - is still
there. Here comes a workaround that I needed to conduct tests at various
clock frequencies. It may also help to demonstrate the situation.

Thanks,
	-Carsten.  

