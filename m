Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:37893 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJESFo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Oct 2018 14:05:44 -0400
Date: Fri, 5 Oct 2018 13:07:25 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Bug or works as intended: signal behaviour on -RT
Message-ID: <20181005110725.jggf75junl7euf3c@linutronix.de>
References: <d5b58969-26d3-d32b-71f7-fdd437c06ee1@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5b58969-26d3-d32b-71f7-fdd437c06ee1@oth-regensburg.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

On 2018-09-26 17:07:02 [+0200], Ralf Ramsauer wrote:
> Hi,
Hi,

> But if I synchronously send a SIGALRM via kill, it will immediately
> arrive. Even a sched_yield() in the busy loop won't help. In order to
> get the signal, I have to leave running/runable with usleep().

a sched_yield() will put you at the end of the runqueue. If this is the
only task in that queue then the task will go back on the CPU.

> Thanks
>   Ralf

Sebastian
