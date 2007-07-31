From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] RT: Preemptible Function-Call-IPI Support
Date: Tue, 31 Jul 2007 16:22:35 +0200
Message-ID: <20070731142235.GB22209@elte.hu>
References: <46AEEEA50200005A00028665@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51814 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761775AbXGaOWm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 10:22:42 -0400
Content-Disposition: inline
In-Reply-To: <46AEEEA50200005A00028665@mcclure.wal.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Gregory Haskins <ghaskins@novell.com> wrote:

> > as far as the prioritization of function calls goes, _that_ makes 
> > sense, but it should not be a separate API but should be done to our 
> > normal workqueue APIs. That not only extends the effects of 
> > priorities to all current workqueue using kernel subsystems, but 
> > also keeps the API more unified. We really dont want to have too 
> > many -rt specific APIs.
> 
> I agree with you that having some kind of priority and cpu-binding 
> specifiers for work-queues would be very cool indeed.  However, note 
> that I didn't actually introduce a new API(*), per se.  I simply 
> worked under the existing smp_call_function[_single]() API.
> 
> Using the smp_call_functions is critical design factor, however.  I 
> really want clients of this function to seamlessly transition to 
> threaded mode. [...]

well, 'clients' of this function are low-level architectural bits like 
the scheduler and the TLB flush code which stays atomic nevertheless. 
smp_call_function() is _not_ a true generic framework and to 'thread' it 
is wrong and misplaced and leads to the kind of over-complification that 
your patch shows. Please work based on the workqueue APIs.

	Ingo
