From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RCU simplification and RT needs
Date: Tue, 6 Jun 2017 05:58:14 -0700
Message-ID: <20170606125814.GD3721@linux.vnet.ibm.com>
References: <20170605203550.GA7126@linux.vnet.ibm.com>
 <b60afeb8-9967-3e83-8f3d-1f722ea78e8f@bristot.me>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, anna-maria@linutronix.de,
        williams@redhat.com, mingo@kernel.org, rostedt@goodmis.org
To: Daniel Bristot de Oliveira <daniel@bristot.me>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751305AbdFFM6T (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Jun 2017 08:58:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v56Cre3t069456
        for <linux-rt-users@vger.kernel.org>; Tue, 6 Jun 2017 08:58:19 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2awq372pr1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Jun 2017 08:58:18 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 6 Jun 2017 08:58:17 -0400
Content-Disposition: inline
In-Reply-To: <b60afeb8-9967-3e83-8f3d-1f722ea78e8f@bristot.me>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jun 06, 2017 at 09:57:47AM +0200, Daniel Bristot de Oliveira wrote:
> 
> On 06/05/2017 10:35 PM, Paul E. McKenney wrote:
> > Hello!
> > 
> > At Linus's request, I am simplifying the Linux-kernel RCU implementation,
> > which includes removing code that implements features and options that
> > are no longer needed.  This is not a half-hearted effort.  In fact,
> > I expect that my submission to the next merge window will be a net
> > removal of more than 2500 lines of code.
> 
> Nice :-)
> 
> > But wait, there is more!  ;-)
> > 
> > Although the following two features are not being axed in v4.13, they
> > will be in v4.14 unless someone makes a convincing case for them:
> > 
> > 1.	The ability to build a CONFIG_RCU_NOCB_CPUS=y kernel without
> > 	also specifying CONFIG_NO_HZ_FULL.
> > 
> > 	Unless someone speaks for this configuration option,
> > 	CONFIG_RCU_NOCB_CPUS will be slaved off of CONFIG_NO_HZ_FULL,
> > 	and the rcu_nocbs= boot parameter will be dropped.  (RCU would
> > 	instead use the nohz_full= boot parameter to determine which
> > 	CPUs get their callbacks offloaded.)
> 
> In our product (RHEL-RT), we do not have rcu offload enabled on all CPUs
> by default, that's because there are some cases in which customers want
> to avoid context switches - they let rcuc/ as a low priority thread and
> let it do all the job, when there is nothing else to do. So, we let the
> user decide in which CPUs they want to offload RCU.
> 
> The side effect of enforcing NOHZ_FULL on those cases are two:
> 
> 1) NOHZ_FULL enables NOHZ, which causes an overhead in the
> exit-from-idle path, increasing the average latency;
> 
> 2) Not all RT users want to pay the syscall overheads involved on
> NOHZ_FULL. NOHZ_FULL is very nice for HPC users (user-space busy-loop
> tools) but not for RT users doing fine grained events. These users like
> to offload RCU callbacks on some CPUs, but do not want to pay the
> NOHZ_FULL price.
> 
> So, for event/response real-time users, NOHZ_FULL + NOHZ causes
> undesired overhead, while they want to have rcu_nocbs= enabled. That is
> why I believe that having both rcu_nocbs= and  nohz_full= separated is
> very useful.
> 
> > 2.	The ability to specify polling for callback-offloaded CPUs.  This
> > 	means that the rcu_nocb_poll= boot parameter will be dropped,
> > 	and the CPU doing call_rcu() would do explicit wakeups, when
> > 	needed, to get the corresponding rcuo kthread on the job.
> > 
> > 	I have no evidence that anyone has ever used this option, other
> > 	than me running the occasional rcutorture test.
> 
> We are using it in some cases. There are cases in which users do not
> want to see any interference in a CPU, let's call them heavy CPU
> isolation users. They do not want to see any job there other than their
> user-space busy-loop application. In those cases, they do not want to
> see the rcuc/ threads being awakened - not even to juts wake up another
> thread. Although these cases look more HPC than RT, those users want to
> use the RT kernel to avoid latency in other real-time threads running in
> the same system. I think that the best example of those users is NFV people.
> 
> > So, anyone need either of these?  If not, out they go!  ;-)
> As we deal with many different sort of real-time/HPC workload in the
> enterprise RT world... we end up facing many different user-cases, and
> those options are very useful for us.

Thanks to both you and Gerhard!

Looks like I should figure on keeping these, at least for the time being.

							Thanx, Paul

