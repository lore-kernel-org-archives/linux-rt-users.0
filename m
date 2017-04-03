From: Alison Chaiken <alison@peloton-tech.com>
Subject: Re: EDF - "earliest deadline first" scheduler
Date: Sun, 2 Apr 2017 19:38:48 -0700
Message-ID: <CAOuSAjfVPjd5VFDdvzd6NN=ddCeVtmQj_WAB6xDt6R7Yxux73w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36499 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdDCCit (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 2 Apr 2017 22:38:49 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so104695636pge.3
        for <linux-rt-users@vger.kernel.org>; Sun, 02 Apr 2017 19:38:49 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Ran Shalit <ranshalit@gmail.com> wrote:
> I have found in
> https://wiki.linuxfoundation.org/realtime/documentation/howto/applications/cyclic
> that there is EDF scheduler option for creating a periodic RT thread.
> Yet, I could not understand what's behind the EDF scheduler


Have a look at "Using SCHED_DEADLINE" at

http://elinux.org/ELC_Europe_2016_Presentations

Also, look for papers on this topic by Juri Lelli.

HTH,
Alison
