From: Dennis Borgmann <dennis.borgmann@googlemail.com>
Subject: Re: patchset still being developed?
Date: Fri, 10 Dec 2010 15:43:16 +0100
Message-ID: <4D023C84.8030201@googlemail.com>
References: <4D022981.20606@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:55020 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab0LJOnU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Dec 2010 09:43:20 -0500
Received: by ewy10 with SMTP id 10so2570020ewy.4
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Dec 2010 06:43:19 -0800 (PST)
In-Reply-To: <4D022981.20606@googlemail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I just installed 2.6.36.2, but it doesn't seem to have complete
preemption. I don't see the IRQs as processes and cannot set priorities
to them. Therefore 2.6.33.7 seems to be the last kernel with rt-support.
Am I right? Of so, why?

Dennis

Dennis Borgmann schrieb:
> Hello rt-users!
>
> Is the CONFIG PREEMPT RT Patch still developed? So far I canot find any
> newer patchset than the one for kernel 2.6.33.7 on
> http://www.kernel.org/pub/linux/kernel/projects/rt/ but what I can find
> is submissions to the linux kernel related to PREEMPT stuff in the
> Changelog of recent kernels.
>
> Does this mean, that with current kernels (starting 2.6.34) no more
> patching is needed and a Kernel can be configured to do realtime
> preemption without patches?
>
> If so, an update on the mainpage of the wiki would be nice...
>
> Kind regards,
> Dennis
>   

