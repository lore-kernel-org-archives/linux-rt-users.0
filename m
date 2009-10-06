From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][UHCI-DEBUG] Don't kmalloc with BKL held
Date: Tue, 6 Oct 2009 12:09:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910061206120.2646@localhost.localdomain>
References: <1254474744.28661.2.camel@sven.thebigcorporation.com>  <20091002092021.GA25083@gambetta> <1254573359.11691.0.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frederik Deweerdt <frederik.deweerdt@xprog.eu>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sdietrich@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756924AbZJFKKW@vger.kernel.org>
In-Reply-To: <1254573359.11691.0.camel@sven.thebigcorporation.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 3 Oct 2009, Sven-Thorsten Dietrich wrote:
> On Fri, 2009-10-02 at 09:20 +0000, Frederik Deweerdt wrote:
> > Hi Sven-Thorsten,
> > 
> > On Fri, Oct 02, 2009 at 11:12:24AM +0200, Sven-Thorsten Dietrich wrote:
> > > Subject: Don't kmalloc with BKL held.
> > > From: Sven-Thorsten Dietrich <sdietrich@suse.de>
> > > 
> > > I'm eyeballing this file for complete removal of lock_kernel but 
> > > at first glance, we definitely don't need BKL to kmalloc(). 
> > You need to move the unlock_kernel() above the out: label too.
> > 
> 
> How about this ?
> 
> Subject: Don't kmalloc with BKL held.
> From: Sven-Thorsten Dietrich sdietrich@suse.de Sat Oct 3 01:27:27 2009 -0700
> Date: Sat Oct 3 01:27:27 2009 -0700:
> Git: 4f62eb81e827eb857129101e49757d84ac9ee7eb
> 
> We don't need BKL to kmalloc
> 
> diff --git a/drivers/usb/host/uhci-debug.c b/drivers/usb/host/uhci-debug.c
> index e52b954..3fd5602 100644
> --- a/drivers/usb/host/uhci-debug.c
> +++ b/drivers/usb/host/uhci-debug.c
> @@ -494,32 +494,30 @@ static int uhci_debug_open(struct inode *inode, struct file *file)
>  {
>  	struct uhci_hcd *uhci = inode->i_private;
>  	struct uhci_debug *up;
> -	int ret = -ENOMEM;
>  	unsigned long flags;
>  
> -	lock_kernel();
>  	up = kmalloc(sizeof(*up), GFP_KERNEL);
>  	if (!up)
> -		goto out;
> +		return -ENOMEM;
>  
>  	up->data = kmalloc(MAX_OUTPUT, GFP_KERNEL);
>  	if (!up->data) {
>  		kfree(up);
> -		goto out;
> +		return -ENOMEM;
>  	}
>  
>  	up->size = 0;
> +
> +	lock_kernel();

Why don't you remove it completely ? That lock_kernel() protects
exactly nothing.

Thanks,

	tglx
