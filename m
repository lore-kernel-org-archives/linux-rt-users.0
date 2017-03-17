From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Fri, 17 Mar 2017 19:12:19 +0100
Message-ID: <20170317181219.5vr4obmtiod7euuk@linutronix.de>
References: <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
 <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
 <20170306190707.GL29100@jcartwri.amer.corp.natinst.com>
 <e1193ceb-af77-b561-5b84-c08915e7859e@lebib.org>
 <fb9e1287-7042-9b46-1730-1e622eac99cc@lebib.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Julia Cartwright <julia@ni.com>,
        Daniel Vidal <danielvidalchornet@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Wargreen <wargreen@lebib.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdCQSNK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Mar 2017 14:13:10 -0400
Content-Disposition: inline
In-Reply-To: <fb9e1287-7042-9b46-1730-1e622eac99cc@lebib.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-03-10 18:51:27 [+0100], Wargreen wrote:
> Do you think i should send an issue to DRM/Radeon ?

Wargreen, how long does it take to trigger this issue for you?

What is it, that you do to trigger this? What is _exactly_ the thing you
do?

Could you please additionally also do
	echo t > /proc/sysrq-trigger

once this happens? And please make sure your dmesg buffer big enough to
handle the output (and if not, please increase CONFIG_LOG_BUF_SHIFT).

It seems that the first logs you uploaded kalaj.darktech.org had to
frame pointers enabled but in the recent logs you included here in this
thread you had them enabled. Good. Please keep them enabled.

Please attach the logs to the email and do not paste them since they get
reformatted and it is hard to read them.

> Thanks for your help !

Sebastian
