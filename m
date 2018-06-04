Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:33606 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751098AbeFDWCh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Jun 2018 18:02:37 -0400
Date: Mon, 4 Jun 2018 17:02:02 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: ostream::flush in RT
Message-ID: <20180604220202.GB15066@jcartwri.amer.corp.natinst.com>
References: <CAJ2oMhLfhVMPS1L-kknW_Kb4t=P81KCAhqPz6rL89scsqh4yiw@mail.gmail.com>
 <20180604210459.GB20752@sisyphus.home.austad.us>
 <CAJ2oMhJ-bkzo87ynSEnfnZfAXOo0opEEQB+djvNbeGeHHvhHag@mail.gmail.com>
 <20180604214806.GA21263@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604214806.GA21263@sisyphus.home.austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Henrik Austad <henrik@austad.us>
Cc: Ran Shalit <ranshalit@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>

On Mon, Jun 04, 2018 at 11:48:07PM +0200, Henrik Austad wrote:
> On Tue, Jun 05, 2018 at 12:30:47AM +0300, Ran Shalit wrote:
> > On Tue, Jun 5, 2018 at 12:04 AM, Henrik Austad <henrik@austad.us> wrote:
[..]
> > 1. Are all above suggestions valid also for "soft realtime", i.e.
> > linux without rt patch, yet using rt threads priorities, mlock, etc ?
>
> Yes, this goes for all "time-sensitive" threads, avoid unbounded latencies 
> and uncertainties where you can.
>
> Steps to do (in no particular order, what is optimal for me may not be 
> optimal for you):
>
> - Do a (careful) analysis of your tasks priorities to make sure the most 
>   important thread have the highest pri
> - Use locks with priority inheritance
> - Steer interrupts away from the core with the RT thread (if you have more 
>   than 1 core)

Note that this should be true for all of the irrelevant/secondary
interrupts for your application.

For those interrupts which are themselves part of your RT application,
you'll want these delivered/affinitized to the same CPU as your RT
task(s), lest you fall victim to interrupt and irqthread scheduling
latencies on a housekeeping CPU.

   Julia
