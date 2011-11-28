From: Thomas Schauss <schauss@tum.de>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Mon, 28 Nov 2011 11:08:26 +0100
Message-ID: <4ED35D9A.7090401@tum.de>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com> <4EC384FD.1040106@tum.de> <alpine.LFD.2.02.1111161605580.4902@ionos>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050601020002090906090802"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.106]:53932 "EHLO
	mailrelay1.lrz-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752591Ab1K1KIe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Nov 2011 05:08:34 -0500
Received: from scan6.mail.lrz.de (scan6.mail.lrz.de [10.156.6.40]) by mailrelay1.lrz-muenchen.de with ESMTP for linux-rt-users@vger.kernel.org; Mon, 28 Nov 2011 11:08:27 +0100
Received: from mailrelay1.lrz-muenchen.de ([10.156.6.201])
	by scan6.mail.lrz.de (scan6.mail.lrz.de [10.156.6.26]) (amavisd-new, port 10024)
	with ESMTP id OW14fMV82zMT for <linux-rt-users@vger.kernel.org>;
	Mon, 28 Nov 2011 11:08:27 +0100 (CET)
Received: from robusta.lsr.ei.tum.de (robusta.lsr.ei.tum.de [129.187.147.176]) by mailrelay1.lrz-muenchen.de with ESMTP for linux-rt-users@vger.kernel.org; Mon, 28 Nov 2011 11:08:26 +0100
Received: from mail.lsr.ei.tum.de (mail.lsr.ei.tum.de [129.187.147.212])
	by robusta.lsr.ei.tum.de (Postfix) with ESMTP id DB9FB150CAED
	for <linux-rt-users@vger.kernel.org>; Mon, 28 Nov 2011 11:08:26 +0100 (CET)
In-Reply-To: <alpine.LFD.2.02.1111161605580.4902@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050601020002090906090802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/2011 04:06 PM, Thomas Gleixner wrote:
> On Wed, 16 Nov 2011, Thomas Schauss wrote:
>> Unfortunately, with 3.0-rt and the nvidia-driver we get complete system
>> freezes when starting X on several different hardware setups (a few systems
>> work fine). This is certainly caused by this combination. When using the
>> nouveau-driver everything works fine.
>
> Have you ever tried to run with CONFIG_PROVE_LOCKING=y ?
>

Hello,

thank you for that tip. I have tried this now and have not found any 
warnings which seem related to the nvidia-driver. Further testing 
revealed, that the driver works fine with CONFIG_PREEMPT_RTB and the 
freezes when running startx occur as soon as we switch to 
CONFIG_PREEMPT_RT_FULL.

Regarding lockdep, we do get some warnings in slab.c -> cache_flusharray 
that however seem unrelated to nvidia. As we could not find any other 
bugs with the same locking warning I attached one example below. You can 
find some complete bootlogs (all with deadlock-warnings, all with 
slightly different call-stack) and my kernel-config at

http://www.lsr.ei.tum.de/team/schauss/lockdep/

On rt-base I also get a lockdep-warning which however seems unrelated to 
the rt-full one (not in cache_flusharray). You can find that log on the 
same page.

Best Regards,
Thomas



Nov 17 17:34:49 fix kernel: [   30.750925] 
=============================================
Nov 17 17:34:49 fix kernel: [   30.750927] [ INFO: possible recursive 
locking detected ]
Nov 17 17:34:49 fix kernel: [   30.750930] 3.0.9-25-rt #0
Nov 17 17:34:49 fix kernel: [   30.750931] 
---------------------------------------------
Nov 17 17:34:49 fix kernel: [   30.750933] udevd/517 is trying to 
acquire lock:
Nov 17 17:34:49 fix kernel: [   30.750935] 
(&parent->list_lock){+.+...}, at: [<ffffffff81613e63>] 
cache_flusharray+0x47/0xd6
Nov 17 17:34:49 fix kernel: [   30.750944]
Nov 17 17:34:49 fix kernel: [   30.750945] but task is already holding lock:
Nov 17 17:34:49 fix kernel: [   30.750946] 
(&parent->list_lock){+.+...}, at: [<ffffffff81613e63>] 
cache_flusharray+0x47/0xd6
Nov 17 17:34:49 fix kernel: [   30.750950]
Nov 17 17:34:49 fix kernel: [   30.750951] other info that might help us 
debug this:
Nov 17 17:34:49 fix kernel: [   30.750952]  Possible unsafe locking 
scenario:
Nov 17 17:34:49 fix kernel: [   30.750953]
Nov 17 17:34:49 fix kernel: [   30.750954]        CPU0
Nov 17 17:34:49 fix kernel: [   30.750955]        ----
Nov 17 17:34:49 fix kernel: [   30.750956]   lock(&parent->list_lock);
Nov 17 17:34:49 fix kernel: [   30.750958]   lock(&parent->list_lock);
Nov 17 17:34:49 fix kernel: [   30.750959]
Nov 17 17:34:49 fix kernel: [   30.750960]  *** DEADLOCK ***
Nov 17 17:34:49 fix kernel: [   30.750961]
Nov 17 17:34:49 fix kernel: [   30.750962]  May be due to missing lock 
nesting notation
Nov 17 17:34:49 fix kernel: [   30.750963]
Nov 17 17:34:49 fix kernel: [   30.750964] 2 locks held by udevd/517:
Nov 17 17:34:49 fix kernel: [   30.750966]  #0:  (&per_cpu(slab_lock, 
__cpu).lock){+.+...}, at: [<ffffffff8116a5c6>] kfree+0xd6/0x380
Nov 17 17:34:49 fix kernel: [   30.750973]  #1: 
(&parent->list_lock){+.+...}, at: [<ffffffff81613e63>] 
cache_flusharray+0x47/0xd6
Nov 17 17:34:49 fix kernel: [   30.750977]
Nov 17 17:34:49 fix kernel: [   30.750977] stack backtrace:
Nov 17 17:34:49 fix kernel: [   30.750980] Pid: 517, comm: udevd Not 
tainted 3.0.9-25-rt #0
Nov 17 17:34:49 fix kernel: [   30.750982] Call Trace:
Nov 17 17:34:49 fix kernel: [   30.750987]  [<ffffffff810a0097>] 
print_deadlock_bug+0xf7/0x100
Nov 17 17:34:49 fix kernel: [   30.750991]  [<ffffffff810a1add>] 
validate_chain.isra.37+0x67d/0x720
Nov 17 17:34:49 fix kernel: [   30.750995]  [<ffffffff810a2478>] 
__lock_acquire+0x478/0x9c0
Nov 17 17:34:49 fix kernel: [   30.750999]  [<ffffffff8162ae19>] ? 
sub_preempt_count+0x29/0x60
Nov 17 17:34:49 fix kernel: [   30.751003]  [<ffffffff81627475>] ? 
_raw_spin_unlock+0x35/0x60
Nov 17 17:34:49 fix kernel: [   30.751007]  [<ffffffff81625f0b>] ? 
rt_spin_lock_slowlock+0x2eb/0x340
Nov 17 17:34:49 fix kernel: [   30.751011]  [<ffffffff81056be1>] ? 
get_parent_ip+0x11/0x50
Nov 17 17:34:49 fix kernel: [   30.751014]  [<ffffffff81613e63>] ? 
cache_flusharray+0x47/0xd6
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff810a2f64>] 
lock_acquire+0x94/0x160
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff81613e63>] ? 
cache_flusharray+0x47/0xd6
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff81626999>] 
rt_spin_lock+0x39/0x40
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff81613e63>] ? 
cache_flusharray+0x47/0xd6
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff8105a90b>] ? 
migrate_disable+0x6b/0xe0
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff81613e63>] 
cache_flusharray+0x47/0xd6
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff81167a41>] 
kmem_cache_free+0x221/0x300
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff81167b8f>] 
slab_destroy+0x6f/0xa0
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff81167d32>] 
free_block+0x172/0x190
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff81613eb4>] 
cache_flusharray+0x98/0xd6
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff814f1110>] ? 
__sk_free+0x130/0x160
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff814f1110>] ? 
__sk_free+0x130/0x160
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff8116a806>] 
kfree+0x316/0x380
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff814f5328>] ? 
skb_queue_purge+0x28/0x40
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff814f1110>] 
__sk_free+0x130/0x160
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff814f11d5>] 
sk_free+0x25/0x30
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff8152d908>] 
netlink_release+0x128/0x200
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff814ea388>] 
sock_release+0x28/0x90
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff814eaa57>] 
sock_close+0x17/0x30
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff8117b914>] 
__fput+0xb4/0x200
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff8117ba85>] 
fput+0x25/0x30
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff81177d0c>] 
filp_close+0x6c/0x90
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff81177df0>] 
sys_close+0xc0/0x130
Nov 17 17:34:49 fix kernel: [   30.751015]  [<ffffffff8162ed02>] 
system_call_fastpath+0x16/0x1b

--------------050601020002090906090802
Content-Type: text/x-vcard; charset=utf-8;
 name="schauss.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="schauss.vcf"

begin:vcard
fn:Thomas Schauss
n:Schauss;Thomas
org:Technische Universitaet Muenchen (TUM);Institute of Automatic Control Engineering (LSR)
adr:;;Theresienstr. 90;Munich;;80333;Germany
email;internet:schauss@tum.de
title:Dipl.-Ing. (Univ.)
tel;work:+49 89 289 23406
tel;fax:+49 89 289 28340
url:http://www.lsr.ei.tum.de
version:2.1
end:vcard


--------------050601020002090906090802--
