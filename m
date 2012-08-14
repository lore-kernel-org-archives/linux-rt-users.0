From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH 1/2][RFC] Add README_cyclicload
Date: Tue, 14 Aug 2012 11:10:18 -0700
Message-ID: <502A948A.5070102@am.sony.com>
References: <1343797643-10208-1-git-send-email-Priyanka.Jain@freescale.com>	<AC83832D6324604BB08FAE5A33553F1907A926BA@039-SN2MPN1-012.039d.mgd.msft.net>	<20120806085929.6c5f8cd7@redhat.com>	<AC83832D6324604BB08FAE5A33553F1907A94309@039-SN2MPN1-012.039d.mgd.msft.net>	<AC83832D6324604BB08FAE5A33553F1907A9E244@039-SN2MPN1-012.039d.mgd.msft.net>	<alpine.LFD.2.02.1208131740280.8203@tycho>	<AC83832D6324604BB08FAE5A33553F1907A9FB9B@039-SN2MPN1-012.039d.mgd.msft.net>	<AC83832D6324604BB08FAE5A33553F1907A9FD9F@039-SN2MPN1-012.039d.mgd.msft.net> <20120814103028.2836b7a6@redhat.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jain Priyanka-B32167 <B32167@freescale.com>,
	John Kacur <jkacur@redhat.com>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Srivastava Rajan-B34330 <B34330@freescale.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [216.32.180.184] ([216.32.180.184]:17680 "EHLO
	co1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1757232Ab2HNSL6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Aug 2012 14:11:58 -0400
In-Reply-To: <20120814103028.2836b7a6@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/14/12 08:30, Clark Williams wrote:
> 
> My comments inline.
> 
> On Tue, 14 Aug 2012 10:15:28 +0000 Jain Priyanka-B32167
> <B32167@freescale.com> wrote:
> 
>> 
>> 
>> -----Original Message----- From:
>> linux-rt-users-owner@vger.kernel.org
>> [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Jain
>> Priyanka-B32167 Sent: Tuesday, August 14, 2012 2:06 PM To: John
>> Kacur; Frank Rowand Cc: Clark Williams;
>> linux-rt-users@vger.kernel.org; dvhart@linux.intel.com;
>> rostedt@goodmis.org; tglx@linutronix.de; Srivastava Rajan-B34330;
>> Aggrwal Poonam-B10812 Subject: RE: [PATCH 1/2][RFC] Add
>> README_cyclicload
>> 
>> 
>> Thanks John and Frank for going through it.

I didn't look at the load portion of the patch (the whole point of the
proposal) - I only looked at how it was breaking cyclictest.


>> 
>> As Frank has suggested to make it separate application and  as John
>> also pointed out that it is breaking some of cyclic-test features,
>> and also the targeted use-case is different, so I think it's better
>> to maintain it as separate tool. Please comments on this.
> 
> What I'd *really* like to do is pull the common routines out of 
> cyclictest.c and put them in separate object files, so that we could 
> create cyclictest-like-tests such as cyclicload without having to
> cram the new logic into cyclictest.  As Frank mentioned, cyclictest
> is complicated enough and somewhat fragile, so adding new logic tends
> to just add new bugs as well.
> 
> John (and Frank and the test of the CC list) what do you think?

If there is a set of common routines and several programs that need
to use them, then that would make sense.  If the only other use case
is cyclicload then it seems like a lot of pain for little gain.

There is already rt-tests/src/lib/ that contains common code...

< snip >

- Frank

