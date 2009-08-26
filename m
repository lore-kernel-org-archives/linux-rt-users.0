From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 17:09:04 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0908261700260.13739@gentwo.org>
References: <1251282598.3514.20.camel@raz> <alpine.DEB.1.10.0908260943090.9924@gentwo.org> <1251297910.1791.22.camel@maxim-laptop> <1251298443.4791.7.camel@raz> <1251300625.18584.18.camel@twins> <alpine.DEB.1.10.0908261136590.9933@gentwo.org>
 <1251302598.18584.31.camel@twins> <alpine.DEB.1.10.0908261211340.9933@gentwo.org> <20090826180407.GA13632@elte.hu> <alpine.DEB.1.10.0908261509580.9933@gentwo.org> <20090826193252.GA14721@elte.hu> <alpine.DEB.1.10.0908261627110.5554@gentwo.org>
 <20090826135041.e6169d18.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mingo@elte.hu, peterz@infradead.org, raziebe@gmail.com,
	maximlevitsky@gmail.com, cfriesen@nortel.com, efault@gmx.de,
	riel@redhat.com, wiseman@macs.biu.ac.il,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753739AbZHZVJT@vger.kernel.org>
In-Reply-To: <20090826135041.e6169d18.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 26 Aug 2009, Andrew Morton wrote:

> All I've seen is "I want 100% access to a CPU".  That's not a problem
> statement - it's an implementation.

Maybe. But its a problem statement that I have seen in various industries.
Multiple kernel hacks exist to do this in more or less contorted way. We
already have Linux scheduler functionality that does partially what is
needed.

See the

	isolcpus

kernel parameter. isolcpus does not switch off OS sources of noise
but it takes the processor away from the scheduler. We need a harder form of
isolation where the excluded processors offer no OS services at all.

> What is the problem statement?

My definition (likely not covering all that the author of this patchset
wants):

How to make a processor in a multicore system completely
available to a process.
