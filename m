From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH V2 2/2] rt: Increase/decrease the nr of migratory tasks
 when enabling/disabling migration
Date: Tue, 27 Jun 2017 18:32:51 +0200
Message-ID: <998180d6-b4c5-bf04-1088-4d5055e4eaf1@redhat.com>
References: <cover.1498482127.git.bristot@redhat.com>
 <e981d271cbeca975bca710e2fbcc6078c09741b0.1498482127.git.bristot@redhat.com>
 <94154431-a0b2-b106-8c23-519ce866271f@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Henri Roosen <henri.roosen@ginzinger.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35872 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdF0Qc5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jun 2017 12:32:57 -0400
Received: by mail-qk0-f173.google.com with SMTP id p21so29752159qke.3
        for <linux-rt-users@vger.kernel.org>; Tue, 27 Jun 2017 09:32:57 -0700 (PDT)
In-Reply-To: <94154431-a0b2-b106-8c23-519ce866271f@ginzinger.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 06/27/2017 04:55 PM, Henri Roosen wrote:
>>
>> As rt_nr_migratory is unsigned, it will become > 0, notifying that the
>> RQ is overloaded, activating pushing mechanism without need.
> 
> What kind of symptoms might be triggered by this? I'm currently facing a
> problem with a continuous-reboot-test where the kernel seems to hang
> sometimes at a (seemingly) random place during kernel boot, on
> 4.9.33-rt23 with iMX6Q. A back-port of this patch to 4.9-rt seems to fix
> it. Or is it covering up a different problem?

The side effect is notifying that the RQ is overloaded, activating
pushing mechanism without need.

I was not seeing system freezes because of it... but, just in case...do
you have the console output from your board?

-- Daniel
