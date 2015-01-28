From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: kernel-rt rcuc lock contention problem
Date: Wed, 28 Jan 2015 14:06:14 -0500
Message-ID: <20150128140614.6d1f2cce@redhat.com>
References: <20150126141403.469dc92f@redhat.com>
	<20150127203752.GD19109@linux.vnet.ibm.com>
	<20150128015508.GA12233@amt.cnet>
	<20150128091836.647d0eee@redhat.com>
	<20150128180950.GS19109@linux.vnet.ibm.com>
	<20150128133916.6ea982ff@redhat.com>
	<20150128190047.GU19109@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45333 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759483AbbA1UkY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Jan 2015 15:40:24 -0500
In-Reply-To: <20150128190047.GU19109@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 28 Jan 2015 11:00:47 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > > 2.	You are letting the rcuc kthreads contend for the worker CPUs.
> > > 	Pin them to housekeeping CPUs.  This applies to both the
> > > 	host and the guest rcuc kthreads, but especially to the
> > > 	host rcuc kthreads.
> > 
> > I'd love to be able to do this, but the rcuc threads are CPU-bound
> > threads. There's one per CPU and the kernel doesn't allow me to move
> > them around.
> 
> Can you build with CONFIG_RCU_BOOST=n?  Then you won't have any rcuc
> kthreads.  

Oh, really? I will try this right away!

Thanks for your help!
