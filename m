From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.23.1-rt9 (and others)
Date: Wed, 07 Nov 2007 14:17:50 +0000
Message-ID: <4731C90E.7030509@gmx.net>
References: <1194413959.8827.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:33439 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750830AbXKGNVP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2007 08:21:15 -0500
In-Reply-To: <1194413959.8827.66.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven Rostedt wrote:
> This is a special announcement for the latest -rt patches. This is
> actually announcing more than one tree (pay close attention to the
> differences between -rt7, -rt8 and -rt9).
>
>   2.6.23.1-rt6
>
>    - Removed BUG_ON in exit (Steven Rostedt and Daniel Walker)
>
>    -  Turn RCU preempt boost on by default (Steven Rostedt)
>       (for when RCU PREEMPT is enabled)
>
>    - Fixes for PowerPC (Paul McKenney)
>
>
>   2.6.23.1-rt7
>
>    - Found that there's a flaw in the PowerPC patch so
>      it was pulled from the tree.
>
>   2.6.23.1-rt8
>
>    - More aggressive RT Balancing (Gregory Haskins)
>
>   2.6.23.1-rt9
>
>    - RT balancing by CPU priorities (Gregory Haskins)
>
>
> Now benchmarks against 2.6.23.1-rt7 -rt8 and -rt9 would be greatly
> appreciated.  These three are all present in
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/
>
> Gregory and I have been having disagreements on how to solve RT task
> balancing among CPUS. Although we shared ideas back and forth, and both
> our methods have been greatly influenced by each other, the real answer
> comes from actual numbers. So these three versions are posted for your
> convenience to see which actually do the best. I would be happy to tell
> Gregory he's right, if the numbers prove it.
>
> Currently, what we do to test RT latencies is to run Thomas Gleixner's
> cyclictest
> (http://git.kernel.org/?p=linux/kernel/git/tglx/rt-tests.git;a=summary)
> as well as hackbench, to see what the maximum latencies we get are.
>
> Other tests are welcomed too.
>
>
> to build a 2.6.23.1-rt7 tree, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.1.tar.bz2 
>   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23.1-rt7.bz2
>
> to build a 2.6.23.1-rt8 tree, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.1.tar.bz2 
>   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23.1-rt8.bz2
>
> to build a 2.6.23.1-rt9 tree, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.1.tar.bz2 
>   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23.1-rt9.bz2
>
>
> And like always, my RT version of Matt Mackall's ketchup will get this
> for you nicely:
>
>   http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt1
>
> The broken out patches are also available.
>
> Thanks!
>
> -- Steve
>
>   
hallo, i just tried to compile rt9 and rt7 and both times i get this 
error at about the end of the 'make && make modules' step:

  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `sched_init':
(.init.text+0x1af): undefined reference to `cpupri_init'
make: *** [.tmp_vmlinux1] Fehler 1


i am on uniprozessor machine here, IBM-thinkpad-r50e + debian testing.
if you need parts of my config file, just feel free to tell me so and  i 
ll try to provide you the information!

cheers,
doc
