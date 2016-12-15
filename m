From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: question about rcuc/X tasks
Date: Thu, 15 Dec 2016 09:07:14 -0500
Message-ID: <20161215090714.0b62cc03@gandalf.local.home>
References: <584F27B8.2090406@windriver.com>
        <518a5f66-76d0-e356-b08b-bde2a7a17bb2@bristot.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>,
        Chris Friesen <chris.friesen@windriver.com>,
        linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:40998 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935790AbcLOOHS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Dec 2016 09:07:18 -0500
In-Reply-To: <518a5f66-76d0-e356-b08b-bde2a7a17bb2@bristot.me>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 15 Dec 2016 14:47:37 +0100
Daniel Bristot de Oliveira <daniel@bristot.me> wrote:

> Hi Chris,
> 
> On 12/12/2016 11:42 PM, Chris Friesen wrote:
> > Based on the fact that Documentation/kernel-per-CPU-kthreads.txt
> > describes CONFIG_RCU_NOCB_CPU_ALL=y as a solution by preventing the
> > rcuc/%u kthreads from having any work to do, I had expected that the
> > "rcu_nocbs=1-15" kernel parameter would have a similar effect.  

Paul, would rcu_nocbs=1-15 work? Or should ALL be used ? I'm assuming
this is on a 16 CPUs box, in which case I don't see much of a difference
for not just using ALL as it is almost there anyway ;-)

-- Steve

> 
> As far as I recall, using CONFIG_RCU_NOCB_CPU_ALL=y will prevent the RCU
> callbacks from running on rcuc/X threads (which are pinned to the CPU
> X), but the rcuc/X thread is still in charge of awaking the ruco*
> threads of the CPU X.
> 
> > Does anyone have any idea what's going on here, and how I can prevent
> > the rcuc/<cpu> tasks from waking up?  
> 
> You can try to use rcu_nocb_poll kernel parameter to unload the rcuc/X
> thread of the task of awaking its respective ruco*s threads.
> 
> >From [1]:  
> 
> rcu_nocb_poll	[KNL]
> 			Rather than requiring that offloaded CPUs
> 			(specified by rcu_nocbs= above) explicitly
> 			awaken the corresponding "rcuoN" kthreads,
> 			make these kthreads poll for callbacks.
> 			This improves the real-time response for the
> 			offloaded CPUs by relieving them of the need to
> 			wake up the corresponding kthread, but degrades
> 			energy efficiency by requiring that the kthreads
> 			periodically wake up to do the polling.
> 
> [1] https://www.kernel.org/doc/Documentation/kernel-parameters.txt
> 
> -- Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

