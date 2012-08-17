From: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: RE: [PATCH 1/2][RFC] Add README_cyclicload
Date: Fri, 17 Aug 2012 11:04:40 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F1907AA5E02@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1343797643-10208-1-git-send-email-Priyanka.Jain@freescale.com>
 <AC83832D6324604BB08FAE5A33553F1907A926BA@039-SN2MPN1-012.039d.mgd.msft.net>
 <20120806085929.6c5f8cd7@redhat.com>
 <AC83832D6324604BB08FAE5A33553F1907A94309@039-SN2MPN1-012.039d.mgd.msft.net>
 <AC83832D6324604BB08FAE5A33553F1907A9E244@039-SN2MPN1-012.039d.mgd.msft.net>
 <alpine.LFD.2.02.1208131740280.8203@tycho>
 <AC83832D6324604BB08FAE5A33553F1907A9FB9B@039-SN2MPN1-012.039d.mgd.msft.net>
 <AC83832D6324604BB08FAE5A33553F1907A9FD9F@039-SN2MPN1-012
 <20120814103028.2836b7a6@redhat.com>
 <alpine.LFD.2.02.1208141927090.19837@tycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Srivastava Rajan-B34330 <B34330@freescale.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:44733
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756722Ab2HQLEo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Aug 2012 07:04:44 -0400
In-Reply-To: <alpine.LFD.2.02.1208141927090.19837@tycho>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



-----Original Message-----
From: John Kacur [mailto:jkacur@gmail.com] On Behalf Of John Kacur
Sent: Wednesday, August 15, 2012 2:05 AM
To: Clark Williams
Cc: Jain Priyanka-B32167; John Kacur; Frank Rowand; linux-rt-users@vger.kernel.org; dvhart@linux.intel.com; rostedt@goodmis.org; tglx@linutronix.de; Srivastava Rajan-B34330; Aggrwal Poonam-B10812
Subject: Re: [PATCH 1/2][RFC] Add README_cyclicload



On Tue, 14 Aug 2012, Clark Williams wrote:

> 
> My comments inline.
> 
> On Tue, 14 Aug 2012 10:15:28 +0000
> Jain Priyanka-B32167 <B32167@freescale.com> wrote:
> 
> > 
> > 
> > -----Original Message-----
> > From: linux-rt-users-owner@vger.kernel.org 
> > [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Jain 
> > Priyanka-B32167
> > Sent: Tuesday, August 14, 2012 2:06 PM
> > To: John Kacur; Frank Rowand
> > Cc: Clark Williams; linux-rt-users@vger.kernel.org; 
> > dvhart@linux.intel.com; rostedt@goodmis.org; tglx@linutronix.de; 
> > Srivastava Rajan-B34330; Aggrwal Poonam-B10812
> > Subject: RE: [PATCH 1/2][RFC] Add README_cyclicload
> > 
> > 
> > Thanks John and Frank for going through it.
> > 
> > As Frank has suggested to make it separate application and  as John also pointed out that it is breaking some of cyclic-test features, and also the targeted use-case is different, so I think it's better to maintain it as separate tool. Please comments on this. 
> 
> What I'd *really* like to do is pull the common routines out of 
> cyclictest.c and put them in separate object files, so that we could 
> create cyclictest-like-tests such as cyclicload without having to cram 
> the new logic into cyclictest.  As Frank mentioned, cyclictest is 
> complicated enough and somewhat fragile, so adding new logic tends to 
> just add new bugs as well.
> 
> John (and Frank and the test of the CC list) what do you think?
> 

Yes, that is what we want to do, and we've started doing so, although it is still pretty bare bones. This code is in src/lib. We should keep enhancing this.

But it's too much of course to ask someone to do this who just wants to get a new tool into the code. So, I would require this.

1. The new tool doesn't break cyclictest, this is rule number one.
2. The new tool does what it claims to do, and is useful.
3. Doesn't unncessarily complicate cyclictest.

I think you automatically lower the bar if you can do this separately because you won't be breaking cyclictest. Of course, it doesn't seem very smart to just go and duplicate a lot of code though, it might be good enough for a prototype. Is a prototype good enough for rttests though?

I think the answer to that depends on meeting requirement number 2.

My first impression running cyclicload was, that it needs a bit of work.
One example of many, using the command line for smp he gave in his README I got

(gdb) r  -p 99 -c 1 -d 0 -x 40 -X 30 -q -D 600 -S Program received signal SIGFPE, Arithmetic exception.
[Switching to Thread 0x7ffff7fcc700 (LWP 21506)]
0x00000000004042c5 in timerthread (param=0x60c490)
    at src/cyclictest/cyclictest.c:1032
1032					((stat->done_t1 * 
100)/stat->num_t1))/
glibc-2.15-51.fc17.x86_64 numactl-libs-2.0.7-6.fc17.x86_64
(gdb) print stat->num_t1
$1 = 0
 
It has to be at a certain level before we're interested in reviewing it more closely. I'm not sure if Jain was just showing us a prototype or he thought it was ready to go in?

[Priyanka]: It is a RFC version . I am working on to make it a robust one. I will send the polished version soon. My major concern for the polished version is to propose this as separate tool or as part of cyclictest . Also, as you have mentioned above that cyclic-load need a bit of work, can you please mentioned those rework required liked the one you highlighted. It will help me in correcting the tool faster. Thanks a lot, Looking forward for your support.

I'm not willing to review it until it's polished some more.

 --->o snip


