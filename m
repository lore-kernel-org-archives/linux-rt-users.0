From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rt] Fix races in ptrace
Date: Mon, 12 Aug 2013 18:41:45 +0200
Message-ID: <20130812164145.GJ23040@linutronix.de>
References: <102271374683007@web8f.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Alexander Fyodorov <halcy@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45093 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614Ab3HLQlq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 12:41:46 -0400
Content-Disposition: inline
In-Reply-To: <102271374683007@web8f.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Alexander Fyodorov | 2013-07-24 20:23:27 [+0400]:

>Hi all,
Hi Alexander,

>I ran into a race on 2.6.33-rt kernel which I think still exists in the latest RT patches. The following patch fixes it but it may be incomplete: probably spinlock should be taken in all other places that check saved_state too.  I only compile-tested this patch for 3.6-rt.

It looks interresting, thanks for the report. Do you have maybe a
test-case which can provoke the bug?

Sebastian
