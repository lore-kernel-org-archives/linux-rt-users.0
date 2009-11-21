From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: scheduling latency & CONFIG_HZ
Date: Fri, 20 Nov 2009 18:32:51 -0800
Message-ID: <4B075153.1090103@am.sony.com>
References: <hdf0mo$6gj$1@ger.gmane.org>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	wg@grandegger.com
To: Tim Blechmann <tim@klingt.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:24884 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbZKUCcq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Nov 2009 21:32:46 -0500
In-Reply-To: <hdf0mo$6gj$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/11/09 10:44, Tim Blechmann wrote:
> i am curious, do the values of CONFIG_HZ and CONFIG_NO_HZ somehow affect 
> the scheduling latency (as reported by cyclictest) of a 
> real-time/vanilla kernel, especially when CONFIG_HIGH_RES_TIMERS is enabled?
> 
> thnx, tim
> 

Some anecdotal info...


From: http://lkml.indiana.edu/hypermail/linux/kernel/0906.2/03853.html

  "I have disabled CONFIG_NOHZ long ago, since it really influences latency."


>From http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg02300.html

  "With CONFIG_NO_HZ=y or CONFIG_PPC_BESTCOMM_GEN_BD=y the latency
   increases by approx. 100..150us, each."

  The thread goes on for a while, but I don't think the CONFIG_NO_HZ
  question was resolved.


Looking at some old source (2.6.23.17-rt14), there was at least one longer
IRQ disabled path if CONFIG_NO_HZ:

   void __noinstrument irq_enter(void)
   {
   #ifdef CONFIG_NO_HZ
        int cpu = smp_processor_id();
        if (idle_cpu(cpu) && !in_interrupt())
               tick_nohz_stop_idle(cpu);

   #endif
        ...
   #ifdef CONFIG_NO_HZ
        if (idle_cpu(smp_processor_id()))
               tick_nohz_update_jiffies();
   #endif
   }


But this code is different in later kernels.  As of 2.6.29.4-rt19, it was:

   irq_enter()
      ...
      if (idle_cpu(cpu) && !in_interrupt()) {
         __irq_enter();
         tick_check_idle(cpu);


            // tick_check_idle() contains:

            #ifdef CONFIG_NO_HZ
               tick_nohz_stop_idle(cpu);
               tick_nohz_update_jiffies();
               tick_nohz_kick_tick(cpu);



- Frank Rowand
Sony Corporation of America

