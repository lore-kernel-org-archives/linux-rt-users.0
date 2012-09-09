From: Gregoire Gentil <gregoiregentil@gmail.com>
Subject: Re: TI wl1271 wireless bug with 3.4-rt17
Date: Sun, 09 Sep 2012 15:42:13 -0700
Message-ID: <504D1B45.3080202@gmail.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de> <20120902194911.GT28643@pengutronix.de> <50444D2F.3040607@gentil.com> <20120904141138.GA14942@beefymiracle.amer.corp.natinst.com> <5046A959.3080904@gentil.com> <20120906034846.GB14942@beefymiracle.amer.corp.natinst.com> <504824F4.2060606@gentil.com>
Reply-To: gregoiregentil@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000700040507060309060600"
Cc: Luciano Coelho <coelho@ti.com>
To: Josh Cartwright <josh.cartwright@ni.com>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:59192 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab2IIWmT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 9 Sep 2012 18:42:19 -0400
In-Reply-To: <504824F4.2060606@gentil.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000700040507060309060600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit



On 09/05/2012 09:22 PM, Gregoire Gentil wrote:
>
>
> On 09/05/2012 08:48 PM, Josh Cartwright wrote:
>> CC'd Luciano to let him know about breakage of wl12xx on -rt.
>>
>> On Tue, Sep 04, 2012 at 06:22:33PM -0700, Gregoire Gentil wrote:
>>> On 09/04/2012 07:11 AM, Josh Cartwright wrote:
>>>> On Sun, Sep 02, 2012 at 11:24:47PM -0700, Gregoire Gentil wrote:
>>>>> Hello,
>>>>>
>>>>> I'm trying to debug a wifi bug with 3.4-rt17 applied, running on an
>>>>> OMAP4 ARM board such as Pandaboard.
>>>>>
>>>>> Wi-Fi works perfectly well without rt patches. It also works quite
>>>>> well with rt patches AND without wifi module loaded. But with both
>>>>> rt patches and wifi module, the system is very flaky and even if I
>>>>> manage to launch a big download, I get a kernel hang. I managed to
>>>>> get a trace:
>>>>>
>>>>> BUG: scheduling while atomic: irq/213-wl12xx/1588/0x00010002
>>>>> Modules linked in: omapdce(C) wl12xx wlcore omaprpc(C) mac80211 d
>>>>> [<c001beb4>] (unwind_backtrace+0x0/0xf0) from [<c0613548>] (dump)
>>>>> [<c0613548>] (dump_stack+0x20/0x24) from [<c0073908>] (__schedul)
>>>>> [<c0073908>] (__schedule_bug+0x54/0x60) from [<c0614818>] (__sch)
>>>>> [<c0614818>] (__schedule+0x74/0x6c0) from [<c0614f60>] (schedule)
>>>>> [<c0614f60>] (schedule+0xa0/0xb8) from [<c0615eb8>] (rt_spin_loc)
>>>>> [<c0615eb8>] (rt_spin_lock_slowlock+0x198/0x288) from [<c06160a8)
>>>>> [<c06160a8>] (rt_spin_lock+0x18/0x1c) from [<bf0c6b24>] (wl12xx_)
>>>>> [<bf0c6b24>] (wl12xx_hardirq+0x2c/0xa4 [wlcore]) from [<c00bd4f0)
>>>>> [<c00bd4f0>] (handle_irq_event_percpu+0xac/0x24c) from [<c00bd70)
>>>>> [<c00bd70c>] (handle_irq_event+0x7c/0x9c) from [<c00c08f0>] (han)
>>>>> [<c00c08f0>] (handle_level_irq+0xe4/0x134) from [<c00bcf58>] (ge)
>>>>> [<c00bcf58>] (generic_handle_irq+0x34/0x3c) from [<c03217e8>] (g)
>>>>> [<c03217e8>] (gpio_irq_handler+0x160/0x1a4) from [<c00bcf58>] (g)
>>>>> [<c00bcf58>] (generic_handle_irq+0x34/0x3c) from [<c001449c>] (h)
>>>>> [<c001449c>] (handle_IRQ+0x88/0xc8)
>>>>>
>>>>> Source code including the function wl12xx_hardirq is here:
>>>>> http://dev.omapzoom.org/?p=integration/kernel-ubuntu.git;a=blob;f=drivers/net/wireless/ti/wlcore/main.c;h=45fe911a6504f92dddff5a9415bb77a643b3c4a9;hb=f84c72f6b36418ff11d16808c16a7c3216730bb0
>>>>>
>>>>>
>>>>> Any idea what could be wrong and how I could debug and fix this
>>>>> situation?
>>>>
>>>> On first glance, it looks like the driver uses request_threaded_irq(),
>>>> to register its handlers, but is trying to acquire a regular spin_lock
>>>> in its primary handler.  That's bad news, since spin_locks' can
>>>> schedule() when contended with CONFIG_PREEMPT_RT.
>>>>
>>>> And it's not just that, unfortunately, since the primary handler also
>>>> complete()s a completion, which also can schedule().
>>>>
>>>> It looks like the overall interrupt handling strategy of this driver
>>>> probably needs to be revisited. :(.
>>>
>>> Josh,
>>>
>>> I really appreciate the answer. Thank you. Though I'm definitely not
>>> a RT expert, I really would like to make this work... Could you
>>> provide a little bit more guideline what I should patch to fix this
>>> situation? Could I change request_threaded_irq to something else?
>>> Would raw_spin* help?
>>
>> In general, the hardirq handler should be doing the absolute bare
>> minimum necessary to determine whether or not the device is interrupting
>> (and if so, quiet it down and return IRQ_WAKE_THREAD), since
>> longer-running handlers have detrimental impact to the system
>> determinism.
>>
>> The right solution for wl12xx seems to be pushing the logic currently
>> implemented in the hardirq handler into the threaded handler, but
>> without knowing too many details about the driver, its difficult to
>> judge the viability/impact of this solution.
> [G2]. Luciano,
>
> Could you please comment on this suggestion? With the right guideline,
> I'm willing to patch and test and see if we can improve this buggy
> situation.
>
> Many thanks in advance,
>
> Grégoire
Find attached a patch which seems to work but I really don't know what 
I'm doing here! Any comment would be appreciated,

Grégoire


--------------000700040507060309060600
Content-Type: text/x-patch;
 name="rt-wifi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rt-wifi.patch"

--- a/drivers/net/wireless/ti/wlcore/main.c	2012-09-06 08:35:44.821870411 -0700
+++ b/drivers/net/wireless/ti/wlcore/main.c	2012-09-06 08:38:32.994704341 -0700
@@ -5234,6 +5234,11 @@
 
 static irqreturn_t wl12xx_hardirq(int irq, void *cookie)
 {
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t wl1271_irq_special(int irq, void *cookie)
+{
 	struct wl1271 *wl = cookie;
 	unsigned long flags;
 
@@ -5253,12 +5258,10 @@
 		wl1271_debug(DEBUG_IRQ, "should not enqueue work");
 		disable_irq_nosync(wl->irq);
 		pm_wakeup_event(wl->dev, 0);
-		spin_unlock_irqrestore(&wl->wl_lock, flags);
-		return IRQ_HANDLED;
 	}
 	spin_unlock_irqrestore(&wl->wl_lock, flags);
 
-	return IRQ_WAKE_THREAD;
+	return wl1271_irq(irq, cookie);
 }
 
 int __devinit wlcore_probe(struct wl1271 *wl, struct platform_device *pdev)
@@ -5292,7 +5295,7 @@
 	else
 		irqflags = IRQF_TRIGGER_HIGH | IRQF_ONESHOT;
 
-	ret = request_threaded_irq(wl->irq, wl12xx_hardirq, wl1271_irq,
+	ret = request_threaded_irq(wl->irq, wl12xx_hardirq, wl1271_irq_special,
 				   irqflags,
 				   pdev->name, wl);
 	if (ret < 0) {

--------------000700040507060309060600--
