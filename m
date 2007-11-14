From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Priority Ceiling for SMP?
Date: Wed, 14 Nov 2007 17:38:55 +0100 (CET)
Message-ID: <alpine.LFD.0.9999.0711141735450.3265@localhost.localdomain>
References: <473346DF.3080108@l1nuxh4ck3r.de> <200711081800.35937.lhenriques@netvisao.pt> <47335D45.7040507@l1nuxh4ck3r.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1509614291-1195058337=:3265"
Cc: =?ISO-8859-15?Q?Lu=EDs_Henriques?= <lhenriques@netvisao.pt>,
	linux-rt-users@vger.kernel.org
To: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:53843 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283AbXKNQjL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Nov 2007 11:39:11 -0500
In-Reply-To: <47335D45.7040507@l1nuxh4ck3r.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1509614291-1195058337=:3265
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 8 Nov 2007, Bernhard Kuhn wrote:
> Luís Henriques wrote:
> 
> > Maybe I didn't completely understood your question, but... if there is a
> > problem with SMP efficiency (I do not really know, but believe you :) ) with
> > priority ceiling (PC) implementation, this problem should have been already
> > identified (and possibly solved) in the current PI implementation, right?
> 
> To make it clear: I'm not aware of any efficiency issues with
> the current PI implementation :-)
> 
> 
> The (potential) efficiency issue with PC on SMP derives from the
> dead-lock avoidance mechanism that you mentioned: If a task
> locks a resource, then it's priority is raised to the ceiling
> (which is typically the highest priority of all task sharing
> that resource). Once that happens, no other task (sharing the
> same resource) could then lock another resource that potentially
> leads to a dead-lock situation.
> 
> Example:
> 
> * A low priority Task A shall share resources X and Y
>   with a high priority Task B.
> 
> * Task A shall execute the following fraction of code:
> 
>     1. lock(X)
>     2. lock(Y)
> 
> * Task B shall execute the following fraction of code:
> 
>     1. lock(Y)
>     2. lock(X)

Classic ABBA deadlock :) Priority ceiling is not designed to allow
that. It's just a coincidence that it does not lead to a deadlock on
UP, but thats not a semantical property.

Thanks,

	tglx
--8323328-1509614291-1195058337=:3265--
