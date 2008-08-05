From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH 3/3] powerpc - Make the irq reverse mapping radix tree
 lockless
Date: Tue, 5 Aug 2008 10:28:27 +0200
Message-ID: <20080805102827.7d8dbc4b@bull.net>
References: <1217848124-3719-1-git-send-email-sebastien.dugue@bull.net>
	<1217848124-3719-4-git-send-email-sebastien.dugue@bull.net>
	<1217867496.3946.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, benh@kernel.crashing.org,
	paulus@samba.org, michael@ellerman.id.au,
	jean-pierre.dion@bull.net, gilles.carry@ext.bull.net,
	tinytim@us.ibm.com, tglx@linutronix.de, rostedt@goodmis.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39245 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921AbYHEK5X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Aug 2008 06:57:23 -0400
In-Reply-To: <1217867496.3946.33.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 04 Aug 2008 09:31:36 -0700 Daniel Walker <dwalker@mvista.com> wrote:

> On Mon, 2008-08-04 at 13:08 +0200, Sebastien Dugue wrote:
> 
> > --- a/arch/powerpc/include/asm/irq.h
> > +++ b/arch/powerpc/include/asm/irq.h
> > @@ -119,6 +119,7 @@ struct irq_host {
> >  		} linear;
> >  		struct radix_tree_root tree;
> >  	} revmap_data;
> > +	spinlock_t	       tree_lock;
> 
> You have a tabbing issue above..

  Yuck, right.

  Thanks,

  Sebastien.
