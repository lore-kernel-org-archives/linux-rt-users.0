From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: BKL & latency
Date: Wed, 29 Sep 2010 11:33:29 -0700
Message-ID: <1285785209.19859.6.camel@quadrophenia>
References: <AANLkTimikhQEFSALtgH7+wRqHCHNv1RzdYW6YHi92BPf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Tony Poppleton <tony.poppleton@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46541 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217Ab0I2Sdf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Sep 2010 14:33:35 -0400
Received: by bwz11 with SMTP id 11so779299bwz.19
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2010 11:33:34 -0700 (PDT)
In-Reply-To: <AANLkTimikhQEFSALtgH7+wRqHCHNv1RzdYW6YHi92BPf@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-09-29 at 16:11 +0100, Tony Poppleton wrote:
> Hi,
> 
> I have read that with each new kernel release, the Big Kernel Lock
> (BKL) is gradually being removed from the core kernel code.
> 
> Just out of interest, I was wondering if this has an impact on the RT patch?
> 
> In particular,
>  - does the RT patch have any connection with the BKL?

Yes. The RT patch has been addressing BKL for several years.

>  - presumably the BKL removal will reduce the average latency of the
> unpatched kernel?

Yes.

>  - is the BKL currently a source of considerable latency?

Especially on SMP it can be.

>  - will the BKL removal make the RT patch considerably smaller/simpler?

It will eliminate code from the RT patch. You would need to scan the
latest patch yourself to ascertain how much, as this is WiP and I am not
totally current.

>  - has the RT patch effectively been removing the BKL since day 1, or
> does it just make the BKL a pre-emptible lock?
> 

It has been making it preemptible since day 1. 

Sven


