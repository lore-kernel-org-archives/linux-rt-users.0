From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree
 lockless
Date: Wed, 3 Sep 2008 15:41:05 +0200
Message-ID: <20080903154105.7dff49db@bull.net>
References: <1218029429-21114-1-git-send-email-sebastien.dugue@bull.net>
	<1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
	<1219209781.21386.25.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, paulus@samba.org,
	michael@ellerman.id.au, jean-pierre.dion@bull.net,
	gilles.carry@ext.bull.net, tinytim@us.ibm.com, tglx@linutronix.de,
	rostedt@goodmis.org, dwalker@mvista.com
To: benh@kernel.crashing.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:60083 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbYICNlP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Sep 2008 09:41:15 -0400
In-Reply-To: <1219209781.21386.25.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 20 Aug 2008 15:23:01 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> BTW. It would be good to try to turn the GFP_ATOMIC into GFP_KERNEL,

  That would be nice indeed

> maybe using a semaphore instead of a lock to protect insertion vs.
> initialisation.

  a semaphore? are you meaning a mutex? If not, I fail to understand what you're
implying.

> The old scheme was fine because if the atomic allocation
> failed, it could fallback to the linear search and try again on the next
> interrupt. Not anymore.

  Right, that's the problem with this new scheme and I'm still trying
to find a way to handle memory allocation failures be it for GFP_ATOMIC or
GFP_KERNEL.

  I could not think of anything simple so far and I'm open for suggestions.

  Thanks,

  Sebastien.

