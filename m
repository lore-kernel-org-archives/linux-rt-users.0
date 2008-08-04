From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 3/3] powerpc - Make the irq reverse mapping radix tree
	lockless
Date: Mon, 04 Aug 2008 09:31:36 -0700
Message-ID: <1217867496.3946.33.camel@localhost.localdomain>
References: <1217848124-3719-1-git-send-email-sebastien.dugue@bull.net>
	 <1217848124-3719-4-git-send-email-sebastien.dugue@bull.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, benh@kernel.crashing.org,
	paulus@samba.org, michael@ellerman.id.au,
	jean-pierre.dion@bull.net, gilles.carry@ext.bull.net,
	tinytim@us.ibm.com, tglx@linutronix.de, rostedt@goodmis.org
To: Sebastien Dugue <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:1263 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbYHDQby (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Aug 2008 12:31:54 -0400
In-Reply-To: <1217848124-3719-4-git-send-email-sebastien.dugue@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2008-08-04 at 13:08 +0200, Sebastien Dugue wrote:

> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -119,6 +119,7 @@ struct irq_host {
>  		} linear;
>  		struct radix_tree_root tree;
>  	} revmap_data;
> +	spinlock_t	       tree_lock;

You have a tabbing issue above..

Daniel

