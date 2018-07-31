Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.thorsis.com ([92.198.35.195]:59422 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbeGaPrn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Jul 2018 11:47:43 -0400
From: Alexander Dahl <ada@thorsis.com>
Subject: Re: How to apply RT patches to a kernel not listed in http://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/
Date: Tue, 31 Jul 2018 16:07:09 +0200
Message-ID: <8426606.ZxYD7UXQP7@ada>
In-Reply-To: <CAF_dkJDV0t7Cp7xjW2j9teJRU45anfKMJMO6KpU+ewTVmW0J4A@mail.gmail.com>
References: <CAF_dkJC2UqpDVGzF4K575_hZYii_-OL6H1h=nNO8mTQm4QK2SQ@mail.gmail.com> <4333850.dc08gExWjP@ada> <CAF_dkJDV0t7Cp7xjW2j9teJRU45anfKMJMO6KpU+ewTVmW0J4A@mail.gmail.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Patrick Doyle <wpdster@gmail.com>

Hello,

Am Dienstag, 31. Juli 2018, 09:49:20 CEST schrieb Patrick Doyle:
> I guess I have always assumed that the linux-at91 tree was more
> betterer for the SAMA5 than the vanilla tree.  But I have never asked
> what makes it better.  I do admire and applaud Atmel/Microchip's
> commitment to getting their changes mainlined.

They do, although also a lot seems to come from the engineers at Bootlin?

If you're aiming at SAMA5: I have a look at linux-arm-kernel every now and 
then and there's still a lot of ongoing development for that target. Maybe LTS 
vanilla v4.14 with the PREEMPT_RT patches is also an option for you?

HTH and Greets
Alex

