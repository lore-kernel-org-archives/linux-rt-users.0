From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.19-rt6, yum/rpm
Date: Thu, 7 Dec 2006 22:44:34 +0100
Message-ID: <20061207214434.GA29357@elte.hu>
References: <20061205171114.GA25926@elte.hu> <1165524358.9244.33.camel@cmn3.stanford.edu> <20061207205819.GA21953@elte.hu> <1165526445.27217.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Mike Galbraith <efault@gmx.de>,
	Clark Williams <williams@redhat.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Giandomenico De Tullio <ghisha@email.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:41938 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163449AbWLGVpq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Dec 2006 16:45:46 -0500
To: Arjan van de Ven <arjan@infradead.org>
Content-Disposition: inline
In-Reply-To: <1165526445.27217.59.camel@laptopd505.fenrus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> > i think it's the UP vs. SMP difference. We are chasing some SMP 
> > latencies right now that trigger on boxes that have deeper C sleep 
> > states. idle=poll seems to work around those problems.
> 
> well C-states do cause latencies... as advertized in the 
> /proc/acpi/processor/CPU0/power file.

no, this is a plain logic bug somewhere, not a hardware latency. 
Sometimes the latency is in the seconds range, etc.

	Ingo
