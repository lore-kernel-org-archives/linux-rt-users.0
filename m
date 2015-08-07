From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/7] Linux 3.18.18-rt16-rc1
Date: Fri, 7 Aug 2015 09:48:01 -0400
Message-ID: <20150807094801.7498efc9@gandalf.local.home>
References: <20150805011826.881627614@goodmis.org>
	<55C47087.7050300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: "Wolfgang M. Reimer" <linuxball@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:44753 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753237AbbHGNsF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Aug 2015 09:48:05 -0400
In-Reply-To: <55C47087.7050300@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 07 Aug 2015 10:47:03 +0200
"Wolfgang M. Reimer" <linuxball@gmail.com> wrote:

> Hi all,
> 
> only after additionally installing my
> "3.18.17-rt14 locktorture: Do NOT include rwlock.h" patch
> I could build the kernel with CONFIG_PREEMPT_RT_FULL=y.

Is this something I need to add to 3.18.18-rt16?

-- Steve

> 
> So far kernel 3.18.18-rt16-rc1 runs fine on my lenovo
> notebook as well as on a server with (an already 5 year
> old) ASUS Z8NA-D6(C) motherboard (in Ubuntu 14.04.3 LTS).
> 
> Regards,
> 
> Wolfgang
> 
