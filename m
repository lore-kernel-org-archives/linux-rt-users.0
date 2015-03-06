From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rcutorture: fix missing function at build time
Date: Fri, 6 Mar 2015 19:32:59 +0100
Message-ID: <20150306183259.GG10155@linutronix.de>
References: <20150302201530.GA4189@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56322 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbbCFSdD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Mar 2015 13:33:03 -0500
Content-Disposition: inline
In-Reply-To: <20150302201530.GA4189@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luis Claudio R. Goncalves | 2015-03-02 17:15:31 [-0300]:

>Hello,
>
>This is a minor issue, but as I seem to have woken up Paul at 4AM with the
>many beeps from IRC I would feel bad if I did not send this patch to the
>list. Actually, as that patch has been sitting on my computer for a few
>days now, i already feel bad :)

Thanks. I folded this into
rcu-merge-rcu-bh-into-rcu-preempt-for-rt.patch since it is v3.18 only.

Sebastian
