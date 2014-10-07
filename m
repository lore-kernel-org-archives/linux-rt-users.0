From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] sched: Do not try to replenish from a non deadline tasks
Date: Tue, 07 Oct 2014 14:02:28 +0200
Message-ID: <5433D654.2020108@monom.org>
References: <1411565056-15577-1-git-send-email-daniel.wagner@bmw-carit.de> <5433B5B9.70006@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@arm.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	"juri.lelli@gmail.com" <juri.lelli@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:43082 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbaJGMCa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Oct 2014 08:02:30 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so9083714wgh.22
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Oct 2014 05:02:29 -0700 (PDT)
In-Reply-To: <5433B5B9.70006@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Juri,

On 10/07/2014 11:43 AM, Juri Lelli wrote:
> Hi Daniel,
> 
> On 24/09/14 14:24, Daniel Wagner wrote:
>> When a PI mutex is shared between an deadline task and normal task we
>> might end up trying to replenish from the normal task. In this case neither
>> dl_runtime, dl_period or dl_deadline are set. replenish_dl_entity() can't do
>> anything useful.
>>
> 
> Is this same bug we have with rt_mutex_setprio or something different?
> I'm sorry, but I don't remember anymore :/. It looks like a different
> issue, though.

There are two independent bugs but in both cases BUG_ON in
enqueue_dl_entity() is triggered.

The first one (this patch) is triggered by trying to use the sched_attr
of the non deadline task. The second one is the double queuing.

> Anyway, the callpath you talked about on IRC seems to make sense, does
> what below fix the thing?

I'll give it a spin.

> Could you please point me again to where the
> tests you are running are hosted, so that I can easily reproduce the
> bug here?

Sure. I reduced my original program to this:

http://www.monom.org/rt/pthread_test.c

If you let it run with 'pthread_test inherit' you should see the bugs
eventually.

cheers,
daniel
