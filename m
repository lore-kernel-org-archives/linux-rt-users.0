Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754032AbeC1PcA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Mar 2018 11:32:00 -0400
Date: Wed, 28 Mar 2018 10:31:56 -0500
From: Clark Williams <williams@redhat.com>
Subject: Re: cyclictest result variations
Message-ID: <20180328103156.61721154@tagon>
In-Reply-To: <87370kqmec.fsf@linutronix.de>
References: <TY1PR01MB1769F9602F276EC6B3A351DDF5A30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
        <87vadgqqgv.fsf@linutronix.de>
        <TY1PR01MB17698C0EF45D762EB61E593BF5A30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
        <87370kqmec.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, rt-users <linux-rt-users@vger.kernel.org>, John Kacur <jkacur@gmail.com>, Carsten Emde <C.Emde@osadl.org>

On Wed, 28 Mar 2018 16:56:27 +0200
John Ogness <john.ogness@linutronix.de> wrote:

> On 2018-03-28, Phil Edworthy <phil.edworthy@renesas.com> wrote:
> >> > I found that cyclictest results vary from one run to another.
> >> >
> >> > [...]
> >> >
> >> > Is it common knowledge that cyclictest results vary so much from
> >> > one run to another? Any ideas how to mitigate this?  
> >> 
> >> It would be helpful if you provided the command arguments you use for
> >> your tests. Particularly important options to consider:
> >> 
> >>     -a / --affinity
> >>     -m / --mlockall
> >>     -n / --nanosleep
> >>     -t / --threads
> >>          --secaligned
> >> 
> >> and of course giving it an appropriate realtime priority:
> >> 
> >>     -p / --priority  
> >
> > Sure:
> > cyclictest   -m -n -Sp99 -i200 -h300 -M -D 10h  
> 
> I would recommend using prio 98 instead of 99. In general, applications
> should not be taking the CPU from the migration or watchdog tasks. And
> usually you want cyclictest to reflect the latencies of real
> applications.

Agree, please don't use fifo:99. Honestly there's no difference between fifo:51
and fifo:98. The interrupt threads default to fifo:50, so you want to be above that
but no real need to contend with migration, watchdog or posix timers. 

Also, if you are on a NUMA architecture system, you may want to use the
--numa/-U option, instead of the --smp/-S option. With that option cyclictest
uses the libnuma calls to allocate a stack on the local NUMA node for each
measurement thread (trying to avoid cross-node allocations). 

Clark
