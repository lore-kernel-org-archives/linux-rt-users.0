From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [ANNOUNCE] 3.14.3-rt5
Date: Mon, 16 Feb 2015 12:34:33 +0000
Message-ID: <54E1E3D9.7090501@arm.com>
References: <20140509181214.GK29014@linutronix.de> <20140513153020.35c0e9d08db60c7b3919e593@gmail.com> <20150216112954.GB21649@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:32913 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbBPMeU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Feb 2015 07:34:20 -0500
In-Reply-To: <20150216112954.GB21649@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

On 16/02/15 11:29, Sebastian Andrzej Siewior wrote:
> * Juri Lelli | 2014-05-13 15:30:20 [+0200]:
> 
>> Hi,
> Hi Juri,
> 
>> Also SCHED_DEADLINE dies without the following.
>>
>> Thanks,
>>
>> - Juri
>>
>> ---From 3ca5943538c728399037823e5632431bc2da707c Mon Sep 17 00:00:00 2001
>> From: Juri Lelli <juri.lelli@gmail.com>
>> Date: Tue, 13 May 2014 15:21:16 +0200
>> Subject: [PATCH] sched/deadline: dl_task_timer has to be irqsafe
> 
> applied.
> 

Thanks!

- Juri

> Sebastian
> 

