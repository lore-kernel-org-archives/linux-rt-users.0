From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 26/39] scheduling while atomic in cgroup code
Date: Tue, 17 Mar 2015 16:13:09 -0400
Message-ID: <20150317161309.52eb2b9d@gandalf.local.home>
References: <20150312191307.081068717@goodmis.org>
	<20150312191411.381735145@goodmis.org>
	<20150317201010.GB26043@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>,
	Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:41819 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752529AbbCQUNO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Mar 2015 16:13:14 -0400
In-Reply-To: <20150317201010.GB26043@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 17 Mar 2015 16:10:11 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> [[PATCH RT 26/39] scheduling while atomic in cgroup code] On 12/03/2015 (Thu 15:13) Steven Rostedt wrote:
> 
> > 3.14.34-rt32-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Mike Galbraith <umgwanakikbuti@gmail.com>
> > 
> > mm, memcg: make refill_stock() use get_cpu_light()
> 
> This looks like only 1/2 of Mike's original patch:
> 
> https://lkml.org/lkml/2014/6/21/11 
> 
> I suspect that is because 3.18 could only use 1/2 of it, and based on
> the SOB lines, this is backported from 3.18.
> 
> The other half applies to 3.14 -- testing in progress; not sure about
> the 3.10-rt and earlier....

Grumble. Yeah, I'm sure I got this from 3.18 and backported it.

-- Steve

