From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: RFC: NUMA modifications to cyclictest
Date: Wed, 20 Jan 2010 18:54:45 +0300
Message-ID: <201001201854.46935@zigzag.lvk.cs.msu.su>
References: <20100119171439.24726f2e@torg> <alpine.LFD.2.00.1001200741000.2906@localhost.localdomain> <20100120073734.4be7a52b@torg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Carsten Emde <ce@ceag.ch>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:39586 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab0ATPyt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2010 10:54:49 -0500
In-Reply-To: <20100120073734.4be7a52b@torg>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> The other idea I toyed with was dynamic loading of libnuma so there's
> not an install dependency for the libnuma package with the rt-tests
> package. I only use five functions from libnuma, so that's not too bad
> a set of function pointers to manage. Hmmm, that probably won't work
> very well, since I'll still have to include numa.h. Sigh...

It's an overkill.

We are not talking about use package to be installed into millions of 
systems in binary form.

rt-tests are used by developers; developers may compile those with needed 
options.

Nikita
