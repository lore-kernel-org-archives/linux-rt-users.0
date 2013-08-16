From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.10.6-rt3
Date: Fri, 16 Aug 2013 09:01:51 +0200
Message-ID: <520DCE5F.1040402@linutronix.de>
References: <20130812163413.GI23040@linutronix.de> <520D212F.7030400@localhost> <20130815152210.5ed93696@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Kent Overstreet <kmo@daterainc.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37775 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3HPHB5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Aug 2013 03:01:57 -0400
In-Reply-To: <20130815152210.5ed93696@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/15/2013 09:22 PM, Steven Rostedt wrote:
> On Thu, 15 Aug 2013 11:42:55 -0700
> Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
>> On 08/12/2013 09:34 AM, Sebastian Andrzej Siewior wrote:
>>> Dear RT folks!
>>>
>>> I'm pleased to announce the v3.10.6-rt3 patch set.
>>
>> I'm getting this when trying to build:
>>
>> drivers/md/bcache/request.c: In function 'cached_dev_write_complete':
>> drivers/md/bcache/request.c:1008:2: error: implicit declaration of 
>> function 'up_read_non_owner' [-Werror=implicit-function-declaration]
>>    up_read_non_owner(&dc->writeback_lock);
>>    ^
>> drivers/md/bcache/request.c: In function 'request_write':
>> drivers/md/bcache/request.c:1034:2: error: implicit declaration of 
>> function 'down_read_non_owner' [-Werror=implicit-function-declaration]
>>    down_read_non_owner(&dc->writeback_lock);
>>    ^
>> cc1: some warnings being treated as errors
>>
> 
> Can you send us your config.

The problem is that bcache is using new semaphore functions which it
just introduced which rt does not know about. The comment above their
definition says that it is wrong to use them and completion is the
right way to do it.
So my question is, why don't we use completion but this nasty hack?

> 
> Thanks,
> 
> -- Steve

Sebastian
