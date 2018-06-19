Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-io0-f178.google.com ([209.85.223.178]:36312 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966480AbeFSQUA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Jun 2018 12:20:00 -0400
Received: by mail-io0-f178.google.com with SMTP id k3-v6so749453iog.3
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Jun 2018 09:19:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515140313.6u777gfafpthsijj@linutronix.de>
References: <CALC81-sg=86AZgZv4bGSNPJEmw3r_j=yNv5HuGPBWKMYVoXJ1A@mail.gmail.com>
 <20180507131505.tv6qz4rzvya5o3no@linutronix.de> <CALC81-uM_23mu-EGhGSrW=-yUpZh+f_-hQQ=7Xa1Ka3mKygObQ@mail.gmail.com>
 <20180515140313.6u777gfafpthsijj@linutronix.de>
From: Iain Hunter <drhunter95@gmail.com>
Date: Tue, 19 Jun 2018 17:19:59 +0100
Message-ID: <CALC81-sqTxZwUvXb1ofFcREkU_xJYA_VYfeu++GroUG_ca8dUw@mail.gmail.com>
Subject: Re: RT Patch and Xen
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org

Hi Sebastian,
I have now tested dropping the restriction on Xilinx 4.14 with rt1 and
mainline 4.16.15-rt6. With both of these I can successfully run a Xen
Guest domain (DomU) with at least networking available (scp and ssh
works).
Iain

On 15 May 2018 at 15:03, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-05-08 16:55:15 [+0100], Iain Hunter wrote:
>> Hi Sebastian,
> Hi Iain,
>
>> Is your suggestion that I try just dropping the restriction in the
>> patch on CONFIG_PREEMPT_RT_FULL and just see if it works?
> correct.
>
>> If it is I will try on 4.14 with latest RT patch as I'd rather stick
>> with an official Xilinx release.
> okay.
>
>> Thanks, Iain
> Sebastian
