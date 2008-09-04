From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree
 lockless
Date: Thu, 4 Sep 2008 10:04:55 +0200
Message-ID: <20080904100455.5b96cc29@bull.net>
References: <1218029429-21114-1-git-send-email-sebastien.dugue@bull.net>
	<1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
	<1219209781.21386.25.camel@pasglop>
	<20080903154105.7dff49db@bull.net>
	<1220496739.4879.20.camel@pasglop>
	<20080904092252.12b3df4a@bull.net>
	<1220513643.4879.68.camel@pasglop>
	<20080904095507.207d1091@bull.net>
	<1220515136.4879.70.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dwalker@mvista.com, tinytim@us.ibm.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, jean-pierre.dion@bull.net,
	michael@ellerman.id.au, linuxppc-dev@ozlabs.org, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
To: benh@kernel.crashing.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:50730 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959AbYIDIFF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Sep 2008 04:05:05 -0400
In-Reply-To: <1220515136.4879.70.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 04 Sep 2008 17:58:56 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> >   There's nothing to 'de-initialize' here, or am I missing something?
> > radix_tree_insert() will return ENOMEM and won't insert anything.
> 
> Forget my comment, just fallback.
> 
> > > Or you can fallback if you don't find, as easy, probably
> > > easier since it shouldn't happen in practice.
> > 
> >   That's what I had in mind.
> 
> Thanks for doing that work !
>

  Will do that way.

  Thanks,

  Sebastien.
