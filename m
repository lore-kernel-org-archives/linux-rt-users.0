From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.22.1-rt3
Date: Fri, 13 Jul 2007 09:29:27 -0700
Message-ID: <1184344167.16715.13.camel@dhcp193.mvista.com>
References: <46974FE50200006C0001494D@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mingo@elte.hu, linux-rt-users@vger.kernel.org
To: David Bahi <dbahi@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:19944 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbXGMQl2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 12:41:28 -0400
In-Reply-To: <46974FE50200006C0001494D@sinclair.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-07-13 at 10:11 -0600, David Bahi wrote:
> On Fri, 2007-07-13 at 13:36 +0200, Remy Bohmer wrote:
> > Thomas,
> > 
> 
> > It should be: http://www.tglx.de/projects/preempt-rt/2.6.22.1-rt3/
> > 
> > Remy
> > 
> > > This release is bugfix release:
> > >
> > > - update of the x8664 -hrt queue (resolve boot problems)
> > > - gtod vsyscall fix from Gregory Haskins
> > >
> 
> excellent. this definitely de-bricks -rt2 for my box.
> 
> still, there's this -rt1 acpi + spinlock panic if ! acpi=off 
> (attached - now with some debug)
> 
> db
> 

Below is an only compile tested patch to drop the spinlocks out of the
c3 enter idle function, and use atomics instead. It looks related to
your panic.. I'm in the process of testing it, but you more than welcome
to try it..

---
 drivers/acpi/processor_idle.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

Index: linux-2.6.22.1/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.22.1.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.22.1/drivers/acpi/processor_idle.c
@@ -950,8 +950,7 @@ static int acpi_idle_enter_c2(struct cpu
 	return ticks_elapsed_in_us(t1, t2);
 }
 
-static int c3_cpu_count;
-static DEFINE_SPINLOCK(c3_lock);
+static atomic_t c3_cpu_count;
 
 /**
  * acpi_idle_enter_c3 - enters an ACPI C3 state-type
@@ -990,16 +989,13 @@ static int acpi_idle_enter_c3(struct cpu
 
 	/* disable bus master */
 	if (pr->flags.bm_check) {
-		spin_lock(&c3_lock);
-			c3_cpu_count++;
-		if (c3_cpu_count == num_online_cpus()) {
+		if (atomic_inc_return(&c3_cpu_count) == num_online_cpus()) {
 			/*
 			 * All CPUs are trying to go to C3
 			 * Disable bus master arbitration
 			 */
 			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
 		}
-		spin_unlock(&c3_lock);
 	} else {
 		/* SMP with no shared cache... Invalidate cache  */
 		ACPI_FLUSH_CPU_CACHE();
@@ -1012,12 +1008,9 @@ static int acpi_idle_enter_c3(struct cpu
 	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
 	if (pr->flags.bm_check) {
-		spin_lock(&c3_lock);
 		/* Enable bus master arbitration */
-		if (c3_cpu_count == num_online_cpus())
+		if (atomic_dec_return(&c3_cpu_count) == (num_online_cpus() - 1))
 			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
-		c3_cpu_count--;
-		spin_unlock(&c3_lock);
 	}
 
 #ifdef CONFIG_GENERIC_TIME
