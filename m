From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH][RT] netpoll: Always take poll_lock when doing polling
Date: Thu, 2 Jun 2016 18:12:35 +0200
Message-ID: <20160602161235.GA12971@linutronix.de>
References: <20160526195641.6c26e979@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <williams@redhat.com>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	David Miller <davem@davemloft.net>
To: Steven Rostedt <rostedt@goodmis.org>, alison@peloton-tech.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47040 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161105AbcFBQMl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Jun 2016 12:12:41 -0400
Content-Disposition: inline
In-Reply-To: <20160526195641.6c26e979@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2016-05-26 19:56:41 [-0400]:

>[ Alison, can you try this patch ]

Alison, did you try it?

Sebastian
