From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Fri, 17 Mar 2017 19:15:02 +0100
Message-ID: <20170317181501.6dtfjonh73g2v2w7@linutronix.de>
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wargreen <wargreen@lebib.org>, Pankaj Gupta <pagupta@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Daniel Vidal <danielvidalchornet@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdCQSPF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Mar 2017 14:15:05 -0400
Content-Disposition: inline
In-Reply-To: <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-26 12:55:01 [+0100], Daniel Vidal wrote:
> Hi
Hi Daniel,

> The radeon driver hangs from 3.16 kernel.
> 
> RT patch for radeon driver only disable ( preempt_disable_rt() ) and
> reenable ( preempt_enable_rt() ) the whole RT in file radeon_display.c

how long does it take for you to get this reproduced? Do you simple surf
with chrome?

Sebastian
