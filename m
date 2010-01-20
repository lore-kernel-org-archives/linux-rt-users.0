From: John Kacur <jkacur@redhat.com>
Subject: Re: RFC: NUMA modifications to cyclictest
Date: Wed, 20 Jan 2010 16:40:49 +0100
Message-ID: <520f0cf11001200740x6a24eed6s5fd73a44f5d9dc@mail.gmail.com>
References: <20100119171439.24726f2e@torg>
	 <alpine.LFD.2.00.1001200741000.2906@localhost.localdomain>
	 <201001201223.36670@zigzag.lvk.cs.msu.su>
	 <20100120073932.479385cb@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:15128 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab0ATPkv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2010 10:40:51 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1291359eyd.19
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Jan 2010 07:40:49 -0800 (PST)
In-Reply-To: <20100120073932.479385cb@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 20, 2010 at 2:39 PM, Clark Williams <williams@redhat.com> wrote:
> On Wed, 20 Jan 2010 12:23:35 +0300
> "Nikita V. Youshchenko" <yoush@cs.msu.su> wrote:
>
>> > > The big difference here is that when using --numa, each measurement
>> > > thread (one per cpu) has it's stack allocated from the memory node
>> > > associated with it's cpu. Also, the major data structures for each
>> > > thread (parameter block, statistics block and histogram) are allocated
>> > > from the appropriate node. This is done with calls into libnuma,
>> > > which means this will add a dependency on libnuma.
>> >
>> > That might cause some trouble for embedded folks. :(
>>
>> Maybe make that a compile-time option?
>
> Yeah, I'm beginning to think I need to pull out the autoconf book :(
>
> Clark
>

compile-time option does not equal autoconf. Please, no autoconf.
