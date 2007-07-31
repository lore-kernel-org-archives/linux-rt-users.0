From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [PATCH 1/2] RT: Preemptible Function-Call-IPI Support
Date: Tue, 31 Jul 2007 08:11:17 -0400
Message-ID: <46AEEEA50200005A00028665@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:17932 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754314AbXGaML0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 08:11:26 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-07-31 at 11:25 +0200, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > * Gregory Haskins <ghaskins@novell.com> wrote:
> >  
> > > This code allows FUNCTION_CALL IPIs to become preemptible by 
> > > executing them in kthread context instead of interrupt context.  
> > > They are referred to as "Virtual Function Call IPIs" (VFCIPI) 
> > > because we no longer rely on the actual FCIPI facility.  Instead we 
> > > schedule a thread to run.  This essentially replaces the synchronous 
> > > FCIPI with an async RESCHEDULE IPI.
> > 
> > why do we need this? It's quite complex and brings little extra 
> > AFAICS. See the "schedule_on_each_cpu-enhance.patch" from Peter 
> > Ziljstra that lets a function to be executed on all CPUs. That should 
> > be extended (trivially) to execute a function on another CPU. That's 
> > all we need.
> 
> as far as the prioritization of function calls goes, _that_ makes sense, 
> but it should not be a separate API but should be done to our normal 
> workqueue APIs. That not only extends the effects of priorities to all 
> current workqueue using kernel subsystems, but also keeps the API more 
> unified. We really dont want to have too many -rt specific APIs.

I agree with you that having some kind of priority and cpu-binding
specifiers for work-queues would be very cool indeed.  However, note
that I didn't actually introduce a new API(*), per se.  I simply worked
under the existing smp_call_function[_single]() API.

Using the smp_call_functions is critical design factor, however.  I
really want clients of this function to seamlessly transition to
threaded mode.  So even if we ultimately can modify work-queues to have
those features mentioned, IMO we still need to modify the underlying
smp_call_function API to use the new workqueue stuff.  And more
importantly, the new workqueue APIs will have to be as flexible as the
current implementation to work in various modes (e.g. in_atomic=1 or 0,
etc).

(*)Ok, ok...i admit...There is one new API:  That is the legacy access
to the real FCIPI calls (which BTW, ive changed from
"smp_call_function__nodelay" to "raw_smp_call_function" in my latest
(and unreleased) series.  This makes them more in sync with some of the
other naming conventions in -rt).  So technically you are right ;) but
that is more of an implementation detail.  There are no users of the new
API other than the VFCIPI code.

Regards,
-Greg  
