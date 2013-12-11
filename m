From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/5] a few open coded completions
Date: Wed, 11 Dec 2013 10:34:20 -0500
Message-ID: <20131211103420.291aa61c@gandalf.local.home>
References: <20131211003732.351606520@goodmis.org>
	<20131211003801.836995968@goodmis.org>
	<52A875D9.6090609@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Corey Minyard <cminyard@mvista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52A875D9.6090609@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 11 Dec 2013 08:25:29 -0600
Corey Minyard <cminyard@mvista.com> wrote:

> This chunk doesn't seem to belong in this patch...

You're right!

I noticed this after I sent these out.

This even caused a conflict, where I fixed it up.

As this chunck doesn't need to be in the stable branch, I'm just going
to nuke it.

I'll even fix up the change log too.

Thanks,

-- Steve

> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 819923f..ba78526 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1139,7 +1139,7 @@ struct net_device {
>  	unsigned char		perm_addr[MAX_ADDR_LEN]; /* permanent hw address */
>  	unsigned char		addr_assign_type; /* hw address assignment type */
>  	unsigned char		addr_len;	/* hardware address length	*/
> -	unsigned char		neigh_priv_len;
> +	unsigned short		neigh_priv_len;
>  	unsigned short          dev_id;		/* for shared network cards */
>  
>  	spinlock_t		addr_list_lock;
