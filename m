From: notgeorge burns <not.george.burns@gmail.com>
Subject: Re: entry_32.S ret_from_intr and invocation of scheduler, v3.2-rt
Date: Sat, 16 Mar 2013 17:10:44 -0700
Message-ID: <CAO2z5ZjDLdyrXJ-LsE_8VauwXuntTb4-51Gka3aLykYiBuNaVQ@mail.gmail.com>
References: <CAO2z5Zi52q94xfmqRDwq5XSgD-VaVitnJ_JNnEpGOr9Spi4cWA@mail.gmail.com>
	<alpine.LFD.2.02.1303152225250.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:43468 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3CQAKq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Mar 2013 20:10:46 -0400
Received: by mail-wg0-f49.google.com with SMTP id ds1so3038190wgb.4
        for <linux-rt-users@vger.kernel.org>; Sat, 16 Mar 2013 17:10:44 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1303152225250.22263@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>> Does the hardirq handler need to do something to make the TI_flags
>> work properly against _TIF_WORK_MASK ?   _TIF_WORK_MASK doesn't
>> include TIF_NEED_RESCHED so it seems that this wouldn't be the right
>> way to do it?
>
> To be honest I was puzzled for a second by that mysel after reading
> your mail, but you got tricked by really obfuscated macro magic:
>

Ok that was a silly miss, sorry about the confusion.

Just curious, what is the rationale for irq_default_primary_handler()
not to invoke set_need_resched()?  Drivers that set up with plain-old
request_irq() will have a scheduled softirq handler, but the hardirq
will return to wherever it was without the priority of the softirq
task coming into play.  For my drivers I can work around it with
request_threaded_irq() but is the potential inversion for
request_irq()-installed handlers really the expected behavior?  Sorry
if this question has been gone over before, I couldn't find anything
with a quick search of the archives.

-burns
