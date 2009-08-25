From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Tue, 25 Aug 2009 23:09:43 +0200
Message-ID: <4A945317.5040501@tudelft.nl>
References: <1250983671.5688.21.camel@raz>	 <1251004897.7043.70.camel@marge.simson.net> <1251018551.3810.35.camel@raz>	 <1251012621.14003.71.camel@marge.simson.net> <1251025557.3810.65.camel@raz>	 <1251021133.14003.172.camel@marge.simson.net>	 <alpine.DEB.1.10.0908251122020.26329@gentwo.org>	 <1251222993.7023.53.camel@marge.simson.net>	 <alpine.DEB.1.10.0908251402300.17963@gentwo.org> <1251227322.7538.1172.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux-foundation.org>,
	Mike Galbraith <efault@gmx.de>,
	raz ben yehuda <raziebe@gmail.com>, riel@redhat.com,
	mingo@elte.hu, andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932244AbZHYVJw@vger.kernel.org>
In-Reply-To: <1251227322.7538.1172.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Op 25-08-09 21:08, Peter Zijlstra schreef:
> On Tue, 2009-08-25 at 14:03 -0400, Christoph Lameter wrote:
>> On Tue, 25 Aug 2009, Mike Galbraith wrote:
>>
>>> I asked the questions I did out of pure curiosity, and that curiosity
>>> has been satisfied.  It's not that I find it useless or whatnot (or that
>>> my opinion matters to anyone but me;).  I personally find the concept of
>>> injecting an RTOS into a general purpose OS with no isolation to be
>>> alien.  Intriguing, but very very alien.
>> Well lets work on the isolation piece then. We could run a regular process
>> on the RT cpu and switch back when OS services are needed?
> 
> Christoph, stop being silly, this offline scheduler thing won't happen,
> full stop.
> 
> Its not a maintainable solution, it doesn't integrate with existing
> kernel infrastructure, and its plain ugly.
> 
> If you want something work within Linux, don't build kernels in kernels
> or other such ugly hacks.
Hello,

For the one interested in such approach, you can have a look at an now
unmaintained project that we developed, ARTiS:
http://www2.lifl.fr/west/artis/

It allows several RT tasks to share a "RT" cpu, and if a task tries to
"cheat" by calling a kernel function which disables the preemption or
the interrupts, it is temporally migrated to another CPU. This is a
working approach, with some good low latency results which can be seen
in the papers on the website.

See you,
Eric
