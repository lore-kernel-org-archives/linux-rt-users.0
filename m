From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.1.3-rt3] [report][suspend to ram] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:917
Date: Fri, 11 Dec 2015 17:20:08 +0100
Message-ID: <20151211162008.GB6720@linutronix.de>
References: <55CB8FAE.9020309@ti.com>
 <20150816114241.GC7004@linutronix.de>
 <55D201DC.5070604@ti.com>
 <55E9CAFB.9070002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Russell King <rmk+kernel@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>,
	linux-rt-users@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46984 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbLKQUL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 11:20:11 -0500
Content-Disposition: inline
In-Reply-To: <55E9CAFB.9070002@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Grygorii Strashko | 2015-09-04 19:46:51 [+0300]:

>Hi All,
Hi,

>I'd very appreciated for comments.

did you run into any problems with this or is it working for you?

Sebastian
