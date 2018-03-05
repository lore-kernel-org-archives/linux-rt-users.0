Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33592 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932930AbeCEIra (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Mar 2018 03:47:30 -0500
Received: by mail-vk0-f66.google.com with SMTP id z130so9281722vkd.0
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Mar 2018 00:47:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171212101816.ux24jdai4fftd7ro@linutronix.de>
References: <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru> <5A01812F.7040406@mcst.ru> <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
 <20171117173820.GM872@jcartwri.amer.corp.natinst.com> <CAJ9FNxsfHRuc+UZCPKGDJDtk5neApOb3i6thpGTy9c-oP8T4JA@mail.gmail.com>
 <20171124093724.GB2564@linutronix.de> <CAJ9FNxtpTqjLevwN1w037=g1eqRPf-Fht+SFqSqJS0jVhFXkLg@mail.gmail.com>
 <20171204095912.GH2255@linutronix.de> <CAJ9FNxsqcLjq8=jcOJz+3mwbkzuXyXCp59XVhj-xamsv6Ux0nA@mail.gmail.com>
 <20171212101816.ux24jdai4fftd7ro@linutronix.de>
From: Sam Kappen <skappen@mvista.com>
Date: Mon, 5 Mar 2018 14:17:29 +0530
Message-ID: <CAJ9FNxtVuwtXhtPUoBQJTD=eO3dKznP9xtE2Yde4Q+p1Mr2iQQ@mail.gmail.com>
Subject: Re: schedule under irqs_disabled in SLUB problem
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org

On Tue, Dec 12, 2017 at 3:48 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-12-05 22:01:19 [+0530], Sam Kappen wrote:
>> Hi,
> Hi,
>
>> Thanks for looking at my queries. Please see my answers inline.
> please don't top-post. Please use a client which adds proper indention
> while quoting the email.
>
>>  1.)
>> > I had derived and tried a patch based on the below analysis.
>> > ( I referred below open source commit, to derive on this patch.
>> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git=
/commit/?h=3Dv4.9.47-rt37-rebase&id=3D7a347757f027190c95a363a491c18156a926a=
370
>> > )
>> >
>> We see this issue when there is a state change for irqs from disabled
>> to enabled. During slab allocations for SCSI on bootup
>> the irqs are found to be in disabled state since the system state is
>> not yet in "RUNNING".
>>
>> So we have added instrument code throughout the call trace and
>> confirmed culprit as pi_lock()/pi_unlock for changing the irqs state.
>> Basically it happens when it acquires the lock with irqs in disabled sta=
te.
>
> but by pi_lock/pi_unlock you don't mean the futex operation, do you?
>
> based on the fact that the system is not in state "running" yet and this
> trace here:
>> ------------[ cut here ]------------
>> WARNING: at kernel/sched/core.c:3052 migrate_disable+0x10b/0x120()
>> Modules linked in:
>> CPU: 1 PID: 7 Comm: kworker/u8:0 Not tainted 3.10.107-rt120+ #49
>> Hardware name: To be filled by O.E.M. To be filled by
> =E2=80=A6
>> Call Trace:
> =E2=80=A6
>>  [<ffffffff8105fcd5>] warn_slowpath_null+0x15/0x20
>>  [<ffffffff8109569c>] migrate_enable+0x14c/0x200
>>  [<ffffffff81100fb1>] get_page_from_freelist+0x9a1/0xbc0
>>  [<ffffffff81101f89>] __alloc_pages_nodemask+0x179/0xa50
>>  [<ffffffff81138ab1>] alloc_pages_current+0x101/0x1f0
>>  [<ffffffff8113cf95>] new_slab+0x265/0x310
>>  [<ffffffff816b386e>] __slab_alloc.isra.62+0x4e0/0x6ca
>>  [<ffffffff8113f5d0>] kmem_cache_alloc+0x170/0x190
>>  [<ffffffff810fbd0a>] mempool_alloc_slab+0x3a/0x70
>>  [<ffffffff810fc0be>] mempool_alloc+0xae/0x210
>>  [<ffffffff812d5ce8>] get_request+0x3a8/0x7c0
>>  [<ffffffff812d619a>] blk_get_request+0x9a/0x140
>>  [<ffffffff813ef02a>] scsi_execute+0x4a/0x170
> =E2=80=A6
>> ---[ end trace 0000000000000001 ]---
>
> I would that this is the same issue and the patch I posted should help.
>
>> > 2.) With your patch during the slab allocations irqs will be in enable=
d state.
>>
>> Thanks. I have been testing your patch, I will update once I finish the =
long
>> run test.
>
> Okay, so a note to myself, there is nothing outstanding for me to do so
> far.
>We have tested it for nearly a month and issue is not reproducible with yo=
ur patch. Many thanks.

>> Regards,
>> Sam
>
> Sebastian
