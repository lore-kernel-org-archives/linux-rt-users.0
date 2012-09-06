From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: TI wl1271 wireless bug with 3.4-rt17
Date: Wed, 05 Sep 2012 21:22:12 -0700
Message-ID: <504824F4.2060606@gentil.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de> <20120902194911.GT28643@pengutronix.de> <50444D2F.3040607@gentil.com> <20120904141138.GA14942@beefymiracle.amer.corp.natinst.com> <5046A959.3080904@gentil.com> <20120906034846.GB14942@beefymiracle.amer.corp.natinst.com>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Josh Cartwright <josh.cartwright@ni.com>,
	Luciano Coelho <coelho@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:37805 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab2IFEWR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Sep 2012 00:22:17 -0400
In-Reply-To: <20120906034846.GB14942@beefymiracle.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 09/05/2012 08:48 PM, Josh Cartwright wrote:
> CC'd Luciano to let him know about breakage of wl12xx on -rt.
>
> On Tue, Sep 04, 2012 at 06:22:33PM -0700, Gregoire Gentil wrote:
>> On 09/04/2012 07:11 AM, Josh Cartwright wrote:
>>> On Sun, Sep 02, 2012 at 11:24:47PM -0700, Gregoire Gentil wrote:
>>>> Hello,
>>>>
>>>> I'm trying to debug a wifi bug with 3.4-rt17 applied, running on a=
n
>>>> OMAP4 ARM board such as Pandaboard.
>>>>
>>>> Wi-Fi works perfectly well without rt patches. It also works quite
>>>> well with rt patches AND without wifi module loaded. But with both
>>>> rt patches and wifi module, the system is very flaky and even if I
>>>> manage to launch a big download, I get a kernel hang. I managed to
>>>> get a trace:
>>>>
>>>> BUG: scheduling while atomic: irq/213-wl12xx/1588/0x00010002
>>>> Modules linked in: omapdce(C) wl12xx wlcore omaprpc(C) mac80211 d
>>>> [<c001beb4>] (unwind_backtrace+0x0/0xf0) from [<c0613548>] (dump)
>>>> [<c0613548>] (dump_stack+0x20/0x24) from [<c0073908>] (__schedul)
>>>> [<c0073908>] (__schedule_bug+0x54/0x60) from [<c0614818>] (__sch)
>>>> [<c0614818>] (__schedule+0x74/0x6c0) from [<c0614f60>] (schedule)
>>>> [<c0614f60>] (schedule+0xa0/0xb8) from [<c0615eb8>] (rt_spin_loc)
>>>> [<c0615eb8>] (rt_spin_lock_slowlock+0x198/0x288) from [<c06160a8)
>>>> [<c06160a8>] (rt_spin_lock+0x18/0x1c) from [<bf0c6b24>] (wl12xx_)
>>>> [<bf0c6b24>] (wl12xx_hardirq+0x2c/0xa4 [wlcore]) from [<c00bd4f0)
>>>> [<c00bd4f0>] (handle_irq_event_percpu+0xac/0x24c) from [<c00bd70)
>>>> [<c00bd70c>] (handle_irq_event+0x7c/0x9c) from [<c00c08f0>] (han)
>>>> [<c00c08f0>] (handle_level_irq+0xe4/0x134) from [<c00bcf58>] (ge)
>>>> [<c00bcf58>] (generic_handle_irq+0x34/0x3c) from [<c03217e8>] (g)
>>>> [<c03217e8>] (gpio_irq_handler+0x160/0x1a4) from [<c00bcf58>] (g)
>>>> [<c00bcf58>] (generic_handle_irq+0x34/0x3c) from [<c001449c>] (h)
>>>> [<c001449c>] (handle_IRQ+0x88/0xc8)
>>>>
>>>> Source code including the function wl12xx_hardirq is here:
>>>> http://dev.omapzoom.org/?p=3Dintegration/kernel-ubuntu.git;a=3Dblo=
b;f=3Ddrivers/net/wireless/ti/wlcore/main.c;h=3D45fe911a6504f92dddff5a9=
415bb77a643b3c4a9;hb=3Df84c72f6b36418ff11d16808c16a7c3216730bb0
>>>>
>>>> Any idea what could be wrong and how I could debug and fix this si=
tuation?
>>>
>>> On first glance, it looks like the driver uses request_threaded_irq=
(),
>>> to register its handlers, but is trying to acquire a regular spin_l=
ock
>>> in its primary handler.  That's bad news, since spin_locks' can
>>> schedule() when contended with CONFIG_PREEMPT_RT.
>>>
>>> And it's not just that, unfortunately, since the primary handler al=
so
>>> complete()s a completion, which also can schedule().
>>>
>>> It looks like the overall interrupt handling strategy of this drive=
r
>>> probably needs to be revisited. :(.
>>
>> Josh,
>>
>> I really appreciate the answer. Thank you. Though I'm definitely not
>> a RT expert, I really would like to make this work... Could you
>> provide a little bit more guideline what I should patch to fix this
>> situation? Could I change request_threaded_irq to something else?
>> Would raw_spin* help?
>
> In general, the hardirq handler should be doing the absolute bare
> minimum necessary to determine whether or not the device is interrupt=
ing
> (and if so, quiet it down and return IRQ_WAKE_THREAD), since
> longer-running handlers have detrimental impact to the system
> determinism.
>
> The right solution for wl12xx seems to be pushing the logic currently
> implemented in the hardirq handler into the threaded handler, but
> without knowing too many details about the driver, its difficult to
> judge the viability/impact of this solution.
[G2]. Luciano,

Could you please comment on this suggestion? With the right guideline,=20
I'm willing to patch and test and see if we can improve this buggy=20
situation.

Many thanks in advance,

Gr=E9goire

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
