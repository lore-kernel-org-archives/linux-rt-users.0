From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Thu, 19 Mar 2015 12:26:11 -0400
Message-ID: <20150319122611.0d002d48@gandalf.local.home>
References: <20150317163541.080310081@goodmis.org>
	<20150317163617.218582800@goodmis.org>
	<20150317163551.3093b6c2@gandalf.local.home>
	<1426753029.4168.80.camel@gmail.com>
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
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:43322 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751129AbbCSQ0P (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Mar 2015 12:26:15 -0400
In-Reply-To: <1426753029.4168.80.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 19 Mar 2015 09:17:09 +0100
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:


> (aw crap, let's go shopping)... so why is the one in timer.c ok?

It's not. Sebastian, you said there were no other cases of rt_mutexes
being taken in hard irq context. Looks like timer.c has one.

So perhaps the real fix is to get that special case of ownership in
hard interrupt context?

-- Steve

