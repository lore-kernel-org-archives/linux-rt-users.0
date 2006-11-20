From: "David Sperry" <dave_sperry@ieee.org>
Subject: RE: RT Patch set, SystemTap, tcp test fails
Date: Sun, 19 Nov 2006 21:26:02 -0500
Message-ID: <001001c70c4b$397ca8e0$7901a8c0@dad>
References: <y0mvelb1ciu.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <systemtap@sources.redhat.com>, 	<linux-rt-users@vger.kernel.org>
Return-path: <systemtap-return-4928-gls-systemtap=m.gmane.org@sourceware.org>
To: <fche@redhat.com>
In-Reply-To: <y0mvelb1ciu.fsf@ton.toronto.redhat.com>
List-Unsubscribe: <mailto:systemtap-unsubscribe-gls-systemtap=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
List-Id: linux-rt-users.vger.kernel.org

Thanks for the response. Just to get a workaround I changed tapsets.cxx and
cleared up that particular error for my system. 


--- src_orig/tapsets.cxx	2006-11-17 15:35:47.000000000 -0500
+++ src/tapsets.cxx	2006-11-19 19:09:02.000000000 -0500
@@ -4332,13 +4332,13 @@ hrtimer_derived_probe_group::emit_module
 
   s.op->newline() << "for (i=0; i<" << probes.size() << "; i++) {";
   s.op->newline(1) << "struct stap_hrtimer_probe* stp = &
stap_hrtimer_probes [i];";
-  s.op->newline() << "hrtimer_init (& stp->hrtimer, CLOCK_MONOTONIC,
HRTIMER_REL);";
-  s.op->newline() << "stp->hrtimer.function = & enter_hrtimer_probe;";
+  s.op->newline() << "hrtimer_init (& stp->hrtimer, CLOCK_MONOTONIC,
HRTIMER_MODE_REL);";
+  s.op->newline() << "stp->hrtimer.function = (void *)(&
enter_hrtimer_probe);";
   // There is no hrtimer field to identify *this* (i-th) probe handler
   // callback.  So instead we'll deduce it at entry time.
   s.op->newline() << "(void) hrtimer_start (& stp->hrtimer, ";
   emit_interval (s.op);
-  s.op->line() << ", HRTIMER_REL);";
+  s.op->line() << ", HRTIMER_MODE_REL);";
   // Note: no partial failure rollback is needed: hrtimer_start only
   // "fails" if the timer was already active, which cannot be.
   s.op->newline(-1) << "}"; // for loop

Hopefully I didn't break something else

Dave

> -----Original Message-----
> From: fche@redhat.com [mailto:fche@redhat.com]
> Sent: Sunday, November 19, 2006 2:07 PM
> To: dave_sperry@ieee.org
> Cc: systemtap@sources.redhat.com; linux-rt-users@vger.kernel.org
> Subject: Re: RT Patch set, SystemTap, tcp test fails
> 
> Dave Sperry <dave_sperry@ieee.nospam.dot.org> writes:
> 
> > Hi I'm trying to get systemtap to work with Ingo Molnar's RT patch set
> > and have run into a few problems. My test setup is a dual Xeon IBM
> > intellistation with fc6 and 2.6.18-rt7 #1 SMP PREEMPT.
> > [...]
> > The the tcp test fails because the symbol HRTIMER_REL cannot be found.
> > detail for the tcp tests is.
> 
> According to mingo's patch set, HRTIMER_REL and HRTIMER_ABS were
> simply renamed to HRTIMER_MODE_REL and HRTIMER_MODE_ABS.  Since these
> are enums instead of macros, a little #ifndef/#define hack would not
> work.  Unless the RT patches identify themselves at compile time, it
> may be tricky to generate code that works with both base and patched
> kernel.
> 
> - FChE
