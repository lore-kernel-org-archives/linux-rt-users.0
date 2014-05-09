From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: kernel/locking/rt.c: add missing EXPORT_SYMBOL for
 rt_down_write_nested_lock() needed by f2fs
Date: Fri, 9 May 2014 15:07:02 +0200
Message-ID: <20140509130702.GE29014@linutronix.de>
References: <20140504191442.370fcf4c@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Joakim Hernberg <jbh@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35732 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaEINHE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 May 2014 09:07:04 -0400
Content-Disposition: inline
In-Reply-To: <20140504191442.370fcf4c@tor.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Joakim Hernberg | 2014-05-04 19:14:42 [+0200]:

>I found this trying to build 3.14.2-rt3.

Applied.

Sebastian
