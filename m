From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt WIP] NMI-safe lightweight parallel-update -rt RCU
Date: Thu, 12 Jul 2007 02:09:37 +0200
Message-ID: <20070712000937.GA1946@elte.hu>
References: <20070712000157.GA4168@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	rostedt@goodmis.org, dipankar@in.ibm.com, josht@linux.vnet.ibm.com,
	linux-rt-users@vger.kernel.org, akpm@linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:59911 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936123AbXGLAKe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jul 2007 20:10:34 -0400
Content-Disposition: inline
In-Reply-To: <20070712000157.GA4168@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Hello!
> 
> Just work in progress, not recommended for inclusion.  Seems stable 
> under rigorous rcutorture testing, so should be OK for 
> experimentation.

nice stuff!

i'm wondering, could you try to do this as a splitup against -mm? I 
think we should get people exposed to the idea of RCU_PREEMPT in the 
upstream kernel a bit more. The netfilter folks promised some 
preparatory enhancements to make it easier, a few months ago :)

	Ingo
