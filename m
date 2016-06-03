From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: [PATCH] Force processes to non-realtime before mm_exit
Date: Fri, 3 Jun 2016 16:33:31 -0700
Message-ID: <CAGt3f4kSr9iFLj7RFBYno9axULf55o-ymgCHN=wgo0bs5jqJnw@mail.gmail.com>
References: <1462903464-11448-1-git-send-email-brian@peloton-tech.com>
 <20160512085946.GB19035@linutronix.de> <CAGt3f4m=+yimx-wxDjH9TCzAb5F6zUbxG_RAEhTrT4cZWFKKcg@mail.gmail.com>
 <20160525163323.GB18036@linutronix.de> <CAGt3f4=SyBqM-7Jeitx10Tm8yTrNBpSoFNvCZNZX7A3oixzUzA@mail.gmail.com>
 <574602F0.2070608@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <574602F0.2070608@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sebastian had some questions about this patch when I first sent it to rt-users.

On Wed, May 25, 2016 at 12:54 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 05/25/2016 08:00 PM, Brian Silverman wrote:
>>> Why can't the application drop the RT priority before its exit? Wouldn't
>>> that be appropriate?
>>
>> If it crashes or gets killed, it doesn't have a chance to drop priority.
>
> That is correct. The task with the highest priority is usually one of
> the most important ones. Usually if that task crashes or gets killed by
> the OOM killer while in production you have usually bigger problems
> than this.

I sometimes use high priority for low latency rather than because a
process is important. Processes like that are designed to always run
quickly, but they need to run with low latency, so they're high
priority. However, they should never cause high latencies for other
processes, even if they crash.

Also, when something bad does happen and an important process crashes,
it's nice to have it not cause problems for other processes too.
Dumping core or freeing memory pages is never more important than
continuing to run the rest of the system.

> I'm neither pro nor against this patch. This patch can go actually
> upstream if accepted since it is not RT specific. If you have a good
> use case please submit please post it upstream and CC me. Once accepted
> I would pull it in -RT as well.

Done

Brian
