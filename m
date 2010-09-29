From: Tony Poppleton <tony.poppleton@gmail.com>
Subject: BKL & latency
Date: Wed, 29 Sep 2010 16:11:27 +0100
Message-ID: <AANLkTimikhQEFSALtgH7+wRqHCHNv1RzdYW6YHi92BPf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48834 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab0I2PLs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Sep 2010 11:11:48 -0400
Received: by wyb28 with SMTP id 28so821213wyb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2010 08:11:47 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have read that with each new kernel release, the Big Kernel Lock
(BKL) is gradually being removed from the core kernel code.

Just out of interest, I was wondering if this has an impact on the RT patch?

In particular,
 - does the RT patch have any connection with the BKL?
 - presumably the BKL removal will reduce the average latency of the
unpatched kernel?
 - is the BKL currently a source of considerable latency?
 - will the BKL removal make the RT patch considerably smaller/simpler?
 - has the RT patch effectively been removing the BKL since day 1, or
does it just make the BKL a pre-emptible lock?

Many thanks,
Tony
