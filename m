From: raz ben yehuda <raziebe@gmail.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 18:11:09 +0300
Message-ID: <1251299469.4791.10.camel@raz>
References: <1250983671.5688.21.camel@raz>
	 <1251222993.7023.53.camel@marge.simson.net>
	 <alpine.DEB.1.10.0908251402300.17963@gentwo.org>
	 <1251227322.7538.1172.camel@twins> <4A943A00.9080609@nortel.com>
	 <1251264700.7538.1178.camel@twins> <1251282598.3514.20.camel@raz>
	 <alpine.DEB.1.10.0908260943090.9924@gentwo.org>
	 <1251297910.1791.22.camel@maxim-laptop> <1251298443.4791.7.camel@raz>
	 <84144f020908260806pb85ee72r7b7e32a07b921b59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Christoph Lameter <cl@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Chris Friesen <cfriesen@nortel.com>,
	Mike Galbraith <efault@gmx.de>, riel@redhat.com, mingo@elte.hu,
	andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57868 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbZHZPLN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Aug 2009 11:11:13 -0400
In-Reply-To: <84144f020908260806pb85ee72r7b7e32a07b921b59@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

sos linux is at:


http://sos-linux.svn.sourceforge.net/viewvc/sos-linux/offsched/

you will find the modules, once shot patches , split patches, and a
Documentation folder. 


On Wed, 2009-08-26 at 18:06 +0300, Pekka Enberg wrote:
> On Wed, Aug 26, 2009 at 5:54 PM, raz ben yehuda<raziebe@gmail.com> wrote:
> >> I have always been fascinated by the idea of controlling another cpu
> >> from the main CPU.
> >>
> >> Usually these cpus are custom, run proprietary software, and have no
> >> datasheet on their I/O interfaces.
> >>
> >> But, being able to turn an ordinary CPU into something like that seems
> >> to be very nice.
> >>
> >> For example, It might help with profiling. Think about a program that
> >> can run uninterrupted how much it wants.
> >>
> >> I might even be better, if the dedicated CPU would use a predefined
> >> reserved memory range (I wish there was a way to actually lock it to
> >> that range)
> >>
> >> On the other hand, I could see this as a jump platform for more
> >> proprietary code, something like that: we use linux in out server
> >> platform, but out "insert buzzword here" network stack pro+ can handle
> >> 100% more load that linux does, and it runs on a dedicated core....
> >>
> >> In the other words, we might see 'firmwares' that take an entire cpu for
> >> their usage.
> >
> > This is exactly what offsched (sos) is. you got it. SOS was partly inspired by the notion of a GPU.
> 
> So where are the patches? The URL in the original post returns 404...

