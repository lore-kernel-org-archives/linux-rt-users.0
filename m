From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 9/9] RT: Only dirty a cacheline if the priority is actually
 changing
Date: Sat, 20 Oct 2007 03:54:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710200353270.12737@gandalf.stny.rr.com>
References: <20071017184745.11272.10024.stgit@novell1.haskins.net>
 <20071017185113.11272.50568.stgit@novell1.haskins.net> <47196C9B.7090909@tiscali.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>
To: Roel Kluin <12o3l@tiscali.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:46016 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbXJTHyy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Oct 2007 03:54:54 -0400
In-Reply-To: <47196C9B.7090909@tiscali.nl>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Sat, 20 Oct 2007, Roel Kluin wrote:

> Gregory Haskins wrote:
> > We can avoid dirtying a rq related cacheline with a simple check, so why not.
> >
> > Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> > ---
> >
> >  0 files changed, 0 insertions(+), 0 deletions(-)
>
> I think you wanted a patch here?
>

But it is here.  Gregory is a Zen master, and this patch does exactly what
he wanted it to do.

-- Steve
