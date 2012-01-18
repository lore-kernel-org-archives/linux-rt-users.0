From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/4] wait-simple: Simple waitqueue implementation
Date: Wed, 18 Jan 2012 07:45:03 -0500
Message-ID: <1326890703.17534.76.camel@gandalf.stny.rr.com>
References: <20120118034531.335521323@goodmis.org>
	 <20120118034700.245278561@goodmis.org>
	 <1326878928.7482.2.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:58068 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab2ARMpG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jan 2012 07:45:06 -0500
In-Reply-To: <1326878928.7482.2.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-01-18 at 10:28 +0100, Mike Galbraith wrote:
> > +
> > +void __init_swait_head(struct swait_head *head, struct lock_class_key *key)
> > +{
> > +	raw_spin_lock_init(&head->lock);
> > +	lockdep_set_class(&head->lock, key);
> > +	INIT_LIST_HEAD(&head->list);
> > +}
> > +EXPORT_SYMBOL_GPL(__init_swait_head);
> 
> #include <linux/module.h> ?

Did it fail to compile for you?  The 3.2 version included linux/export.h
which didn't exist, and that failed the compile for me. I removed it an
it compiled fine. But perhaps I should have replaced it with module.h.
I'll look into it.

Thanks!

-- Steve


