From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Bug#746232: 3.2.57-rt: rcu_preempt detected stalls at boot
Date: Mon, 16 Feb 2015 15:58:26 +0100
Message-ID: <20150216145826.GD21649@linutronix.de>
References: <20140513074539.GJ12328@oktetlabs.ru>
 <53739824.2080007@windriver.com>
 <1400098553.2647.26.camel@deadeye.wl.decadent.org.uk>
 <20140515085825.GN12328@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org, 746232@bugs.debian.org
To: "Alexandra N. Kossovsky" <Alexandra.Kossovsky@oktetlabs.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38338 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478AbbBPO6c (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Feb 2015 09:58:32 -0500
Content-Disposition: inline
In-Reply-To: <20140515085825.GN12328@oktetlabs.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Alexandra N. Kossovsky | 2014-05-15 12:58:25 [+0400]:

you seem to have have Xeon / i7. Can't it run x8664 / amd64?
I have no idea what is going wrong here except that something is
preventing rcu from running.

Sebastian
