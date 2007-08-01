From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH] RT: Add priority-queuing and priority-inheritance to
	workqueue infrastructure
Date: Wed, 01 Aug 2007 11:19:45 -0400
Message-ID: <1185981585.9513.119.camel@ghaskins-t60p.haskins.net>
References: <20070801002407.4973.54778.stgit@novell1.haskins.net>
	 <1185940340.2636.97.camel@imap.mvista.com>
	 <1185969554.9513.106.camel@ghaskins-t60p.haskins.net>
	 <1185981025.2636.102.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934976AbXHAPV5@vger.kernel.org>
In-Reply-To: <1185981025.2636.102.camel@imap.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-08-01 at 08:10 -0700, Daniel Walker wrote:

> 
> rt_mutex_setprio() is just a function. It was also designed specifically
> for PI , so it seems fairly sane to use it in other PI type
> situations ..
> 

Yes.  It is designed for PI and I wasn't suggesting you shouldn't use
the logic itself.  What I was suggesting is that dealing with an API
that has "rt_mutex" in it for something that has nothing to do with
rt_mutexes is, well...

All I was suggesting is that we break out the PI subsystem from rt_mutex
code so its an independent PI API and have the rt_mutex subsystem become
a user.   That's a far cleaner way to do it, IMHO.

-Greg
