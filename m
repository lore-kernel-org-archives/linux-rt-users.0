From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Making rcu_normal=1 in RT
Date: Thu, 3 Nov 2016 09:26:20 -0700
Message-ID: <20161103162620.GH3716@linux.vnet.ibm.com>
References: <20161016044420-mutt-send-email-mst@kernel.org>
 <20161016112846.GR29518@linux.vnet.ibm.com>
 <20161031173852.a3ji7hhgjis5l3u4@linutronix.de>
 <20161031181543.GN3716@linux.vnet.ibm.com>
 <20161101003510-mutt-send-email-mst@kernel.org>
 <20161101021941.GP3716@linux.vnet.ibm.com>
 <20161101043508-mutt-send-email-mst@kernel.org>
 <20161101025240.GR3716@linux.vnet.ibm.com>
 <20161101051400-mutt-send-email-mst@kernel.org>
 <20161102160547.uscnkzhw7we3hucn@linutronix.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758914AbcKCQ00 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Nov 2016 12:26:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA3GO4nH064101
        for <linux-rt-users@vger.kernel.org>; Thu, 3 Nov 2016 12:26:25 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26g6c1hjaf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Nov 2016 12:26:25 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 3 Nov 2016 10:26:24 -0600
Content-Disposition: inline
In-Reply-To: <20161102160547.uscnkzhw7we3hucn@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Nov 02, 2016 at 05:05:47PM +0100, Sebastian Andrzej Siewior wrote:
> On 2016-11-01 05:31:56 [+0200], Michael S. Tsirkin wrote:
> > > > > > > 
> > > > > > > > - optionally it has been requested to make synchronize_rcu() behave like
> > > > > > > >   synchronize_rcu_expedited() on shutdown and kexec().
> > 
> > I was trying to say that the fact net core calls expedited sync
> > implies that many people care about boot time.
> > 
> > Should rcu_normal_after_boot override rcu_expedited?
> > I'm not sure what happens if you specify both ATM.
> 
> I think what you asked for is something like this:
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -283,6 +283,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>  	struct pid_namespace *pid_ns = task_active_pid_ns(current);
>  	char buffer[256];
>  	int ret = 0;
> +	bool force_rcu_exp = false;
> 
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!ns_capable(pid_ns->user_ns, CAP_SYS_BOOT))
> @@ -311,7 +312,19 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>  	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
>  		cmd = LINUX_REBOOT_CMD_HALT;
> 
> +	switch (cmd) {
> +	case LINUX_REBOOT_CMD_RESTART:
> +	case LINUX_REBOOT_CMD_HALT:
> +	case LINUX_REBOOT_CMD_POWER_OFF:
> +	case LINUX_REBOOT_CMD_RESTART2:
> +	case LINUX_REBOOT_CMD_KEXEC:
> +		force_rcu_exp = true;
> +	}
> +
>  	mutex_lock(&reboot_mutex);
> +	if (force_rcu_exp)
> +		rcu_expedite_gp();
> +
>  	switch (cmd) {
>  	case LINUX_REBOOT_CMD_RESTART:
>  		kernel_restart(NULL);
> @@ -362,6 +375,8 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>  		ret = -EINVAL;
>  		break;
>  	}
> +	if (force_rcu_exp)
> +		rcu_unexpedite_gp();
>  	mutex_unlock(&reboot_mutex);
>  	return ret;
>  }
> 
> and problem that this patch is pointless because it is too late. This
> RESTART, POWER_OFF, KEXEC hooks here called once the `shutdown' binary
> is done doing sync & cleanup and invokes the kernel for the final
> operation.
> So to achieve what you ask for, we would need a
> LINUX_REBOOT_CMD_RCU_FAST option which is invoked by the `shutdown'
> binary as the first thing - long before it gets to
> LINUX_REBOOT_CMD_RESTART (or KEXEC).

FWIW, this looks sane to me.

							Thanx, Paul

