From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: EDF - "earliest deadline first" scheduler
Date: Mon, 3 Apr 2017 08:06:23 +0300
Message-ID: <CAJ2oMhKPbh5BJW+JBGtLSvUxukB2e1MA_DierJ1P6k5Cbs+Ohg@mail.gmail.com>
References: <CAOuSAjfVPjd5VFDdvzd6NN=ddCeVtmQj_WAB6xDt6R7Yxux73w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Alison Chaiken <alison@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35106 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdDCFGZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Apr 2017 01:06:25 -0400
Received: by mail-wr0-f177.google.com with SMTP id k6so146533611wre.2
        for <linux-rt-users@vger.kernel.org>; Sun, 02 Apr 2017 22:06:25 -0700 (PDT)
In-Reply-To: <CAOuSAjfVPjd5VFDdvzd6NN=ddCeVtmQj_WAB6xDt6R7Yxux73w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Apr 3, 2017 at 5:38 AM, Alison Chaiken <alison@peloton-tech.com> wrote:
>  Ran Shalit <ranshalit@gmail.com> wrote:
>> I have found in
>> https://wiki.linuxfoundation.org/realtime/documentation/howto/applications/cyclic
>> that there is EDF scheduler option for creating a periodic RT thread.
>> Yet, I could not understand what's behind the EDF scheduler
>
>
> Have a look at "Using SCHED_DEADLINE" at
>
> http://elinux.org/ELC_Europe_2016_Presentations
>
> Also, look for papers on this topic by Juri Lelli.
>
> HTH,
> Alison

Hi Alison,

Thank you very much.
I reviewed the material, which is very interesting, but I am not yet
sure which timer are used internally in SCHED_DEADLINE.
Is it posix or non-posix ?

Thanks,
Ran
