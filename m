Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34215 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbeFEHCc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Jun 2018 03:02:32 -0400
Received: by mail-qt0-f196.google.com with SMTP id d3-v6so1362075qto.1
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jun 2018 00:02:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604220202.GB15066@jcartwri.amer.corp.natinst.com>
References: <CAJ2oMhLfhVMPS1L-kknW_Kb4t=P81KCAhqPz6rL89scsqh4yiw@mail.gmail.com>
 <20180604210459.GB20752@sisyphus.home.austad.us> <CAJ2oMhJ-bkzo87ynSEnfnZfAXOo0opEEQB+djvNbeGeHHvhHag@mail.gmail.com>
 <20180604214806.GA21263@sisyphus.home.austad.us> <20180604220202.GB15066@jcartwri.amer.corp.natinst.com>
From: Ran Shalit <ranshalit@gmail.com>
Date: Tue, 5 Jun 2018 10:02:30 +0300
Message-ID: <CAJ2oMh+6C_GwkhskmOwSjJC5m6h3fA_sD=Ad8fdPUp_goScVUw@mail.gmail.com>
Subject: Re: ostream::flush in RT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: Henrik Austad <henrik@austad.us>, linux-rt-users <linux-rt-users@vger.kernel.org>

On Tue, Jun 5, 2018 at 1:02 AM, Julia Cartwright <julia@ni.com> wrote:
> On Mon, Jun 04, 2018 at 11:48:07PM +0200, Henrik Austad wrote:
>> On Tue, Jun 05, 2018 at 12:30:47AM +0300, Ran Shalit wrote:
>> > On Tue, Jun 5, 2018 at 12:04 AM, Henrik Austad <henrik@austad.us> wrote:
> [..]
>> > 1. Are all above suggestions valid also for "soft realtime", i.e.
>> > linux without rt patch, yet using rt threads priorities, mlock, etc ?
>>
>> Yes, this goes for all "time-sensitive" threads, avoid unbounded latencies
>> and uncertainties where you can.
>>
>> Steps to do (in no particular order, what is optimal for me may not be
>> optimal for you):
>>
>> - Do a (careful) analysis of your tasks priorities to make sure the most
>>   important thread have the highest pri
>> - Use locks with priority inheritance
>> - Steer interrupts away from the core with the RT thread (if you have more
>>   than 1 core)
>
> Note that this should be true for all of the irrelevant/secondary
> interrupts for your application.
>
> For those interrupts which are themselves part of your RT application,
> you'll want these delivered/affinitized to the same CPU as your RT
> task(s), lest you fall victim to interrupt and irqthread scheduling
> latencies on a housekeeping CPU.
>
>    Julia

Thank you for the useful comments, Julia, Henrik.
I have a lot of information to digest now.

Yet, I would please like to ask about the data transfer of data for
the other thread which is responsible for file write:
I want to use std::queue for transferring data from the high priority
RT thread to the lower priority RT thread responsible for file write
(the lower priority thread should yet be *RT* thread too, just with
lower priority, right ?).
I don't see that documentation in c++ states if std::queue is blocking
on mutex or not, yet I guess that push should not block. Does it sound
reasonable assumption ?

Thank you very much,
Ran
