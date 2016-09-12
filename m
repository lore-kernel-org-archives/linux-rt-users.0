From: Stanislav Meduna <stano@meduna.org>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Mon, 12 Sep 2016 11:16:55 +0200
Message-ID: <1e95689e-ae42-7f47-03ff-732f1bc4841c@meduna.org>
References: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
 <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de>
 <20160808164505.GA13707@linutronix.de>
 <CAL7_A_Vz+BCg-QXraob1ndDF4b3ggGN-j+fnQ9FTqY1FdbVvug@mail.gmail.com>
 <20160812123735.zboeocbv4o5sjnwb@linutronix.de>
 <CAL7_A_WcvqmghJiQaDdnYRZmPf9=-s3eveMfM1uYtHfKykbmVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:42089 "EHLO meduna.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755210AbcILJmy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Sep 2016 05:42:54 -0400
In-Reply-To: <CAL7_A_WcvqmghJiQaDdnYRZmPf9=-s3eveMfM1uYtHfKykbmVg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 9/8/2016 12:36 PM, Jens Koehler wrote:

> disable preemption during CR3 read+write

This got my attention as I have hunted some very similar looking
thing 3 years ago:

https://lkml.org/lkml/2013/5/17/109

Coud it explain this? I am unfortunately not able to quickly
reproduce the environment back then.

-- 
                                    Stano

