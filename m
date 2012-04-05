From: Thomas Schauss <schauss@tum.de>
Subject: Re: NVIDIA binary driver with rt patch
Date: Thu, 05 Apr 2012 10:50:53 +0200
Message-ID: <4F7D5CED.8070601@tum.de>
References: <CAFSh4Uy41q=Q5Na_15iLVo8ohpD2mkx0iVMcpCi-fRhnBJ9Qfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040309040408030409020102"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Tom Cook <tom.k.cook@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.106]:57395 "EHLO
	mailrelay1.lrz-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751819Ab2DEJGL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Apr 2012 05:06:11 -0400
Received: from scan6.mail.lrz.de (scan6.mail.lrz.de [10.156.6.40]) by mailrelay1.lrz-muenchen.de with ESMTP for linux-rt-users@vger.kernel.org; Thu, 5 Apr 2012 10:50:56 +0200
Received: from mailrelay1.lrz-muenchen.de ([10.156.6.201])
	by scan6.mail.lrz.de (scan6.mail.lrz.de [10.156.6.26]) (amavisd-new, port 10024)
	with ESMTP id RiH1zSDDQ2oc for <linux-rt-users@vger.kernel.org>;
	Thu,  5 Apr 2012 10:50:55 +0200 (CEST)
Received: from robusta.lsr.ei.tum.de (robusta.lsr.ei.tum.de [129.187.147.176]) by mailrelay1.lrz-muenchen.de with ESMTP for linux-rt-users@vger.kernel.org; Thu, 5 Apr 2012 10:50:55 +0200
Received: from mail.lsr.ei.tum.de (mail.lsr.ei.tum.de [129.187.147.212])
	by robusta.lsr.ei.tum.de (Postfix) with ESMTP id F4038150C65D
	for <linux-rt-users@vger.kernel.org>; Thu,  5 Apr 2012 10:50:54 +0200 (CEST)
In-Reply-To: <CAFSh4Uy41q=Q5Na_15iLVo8ohpD2mkx0iVMcpCi-fRhnBJ9Qfw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040309040408030409020102
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2012 05:37 PM, Tom Cook wrote:
> I'm quite new to linux-rt.  I'm trying to get a usable RT kernel on an
> Ubuntu 11.10 system.  It has an nVidia Quadro NVS 285 video card and
> I'm trying to get the binary drivers working, too.
>
> I've built the 3.0.25 kernel with the rt44 patcheset applied.  I've
> also modified it slightly so that migrate_enable, migrate_disable and
> __init_rt_mutex are exported using EXPORT_SYMBOL rather than
> EXPORT_SYMBOL_GPL (note I am aware of the legal issues surrounding
> this and won't be distributing the resulting kernel or source).  I've
> then patched the nVidia driver source, replacing atomic_spinlock with
> raw_spinlock, down/up with mutex_lock/mutex_unlock and semaphores with
> mutexes.
>
> The resulting system runs and has quite good RT performance (max
> latency<20us reported by cyclictest, at least on short tests with
> full Ubuntu desktop running).  However, the performance of X is dire -
> I get about two screen updates per second.  The mouse still moves
> smoothly, but everything else only updates once or twice per second.
> It seems to be something quite far down the graphics processing chain
> that is slow, not individual operations - for instance, opening a page
> in Firefox doesn't take much longer than usual, it's just that I get
> no response at all for nearly a second and then the rendered page
> appears.  It's like the screen is rendered into a buffer very fast but
> then flipping that buffer to the display is very slow.
>
> Does anyone have any suggestions for what might cause this or tools
> for tracking down where the problem comes from?  I've spent a couple
> of days googling now with no success.
>
> Thanks for any help,
> Tom
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hello Tom,

there was a thread about NVIDIA with linux-3.0-rt on this list some time 
back. The EXPORT_SYMBOL_GPL  hack is actually not necessary. If you make 
the appropriate changes to the nvidia-driver migrate enable/disable and 
other GPL-only exports are never called!

See this post for a patch that we use:
http://www.spinics.net/lists/linux-rt-users/msg07217.html

We have been using this on Ubuntu 11.10 for some time now. However, 
there are some compatibility issues with older NVIDIA-chips (computer 
freezes when starting X). I have not tries using this 
kernel/driver-combo for a Quatro-card yet so I am not sure if that works ok.

However, we never had the situation you are describing: either the 
computer froze when starting X or it worked fine, but we never 
experienced any (noticable) rendering delays.

Best regards,
Thomas

--------------040309040408030409020102
Content-Type: text/x-vcard; charset=utf-8;
 name="schauss.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="schauss.vcf"

YmVnaW46dmNhcmQNCmZuOlRob21hcyBTY2hhdXNzDQpuOlNjaGF1c3M7VGhvbWFzDQpvcmc6
VGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgTXVlbmNoZW4gKFRVTSk7SW5zdGl0dXRlIG9mIEF1
dG9tYXRpYyBDb250cm9sIEVuZ2luZWVyaW5nIChMU1IpDQphZHI6OztUaGVyZXNpZW5zdHIu
IDkwO011bmljaDs7ODAzMzM7R2VybWFueQ0KZW1haWw7aW50ZXJuZXQ6c2NoYXVzc0B0dW0u
ZGUNCnRpdGxlOkRpcGwuLUluZy4gKFVuaXYuKQ0KdGVsO3dvcms6KzQ5IDg5IDI4OSAyMzQw
Ng0KdGVsO2ZheDorNDkgODkgMjg5IDI4MzQwDQp1cmw6aHR0cDovL3d3dy5sc3IuZWkudHVt
LmRlDQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------040309040408030409020102--
