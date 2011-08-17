From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Re: Linux RT patch works on single core - but not booting SMP ARM
 OMAP4 PandaBoard
Date: Wed, 17 Aug 2011 14:10:47 -0500
Message-ID: <CAFQPvXe2hgjsW=gYVi1VQx-EgC0fDesQLBc7vQxkc0XrCz6O7A@mail.gmail.com>
References: <CAFQPvXfMgXWHhRsBRbj_CAcymHbbB9UYjU+yM_L+Fp2cEGMbUg@mail.gmail.com>
	<CAFQPvXfAhvw+TGmHC910ObkAmt2ZE_QsyGxWWAByzvVYf3+R+g@mail.gmail.com>
	<4E4AB90E.10805@am.sony.com>
	<4E4ACD2D.80802@am.sony.com>
	<CAFQPvXcAM4B2_JN7XbqkXdnf-vJ4G_1z2iobv9tCyfd6LQq_WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64622 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab1HQTKr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Aug 2011 15:10:47 -0400
Received: by vws1 with SMTP id 1so931675vws.19
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Aug 2011 12:10:47 -0700 (PDT)
In-Reply-To: <CAFQPvXcAM4B2_JN7XbqkXdnf-vJ4G_1z2iobv9tCyfd6LQq_WA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Aug 17, 2011 at 11:54 AM, Sankara Muthukrishnan
<sankara.m@gmail.com> wrote:
> The cyclic test results are not acceptable (attached the output of
> cyclictest). I am seeing maximum latency of 757 us on core-0 and 1905
> us on core-1. Are you (Is anyone) seeing better results on latency
> with SMP kernel with RT patch on ARM (OMAP4 processors)? I have seen
> ~25 us of latency with single core kernel (though I have used a
> different kernel configuration).
>

Never ever mind and sorry for the confusion. I did not realize that
"Kernel debugging" was enabled in the config Frank had attached. With
kernel debugging disabled, I see max latencies less than 20 us on both
cores on panda board with cyclictest (cyclictest -l1000000 -m -Sp99
-i200 -h60 -q -n) in my quick run and it is exciting to see these
numbers. Thanks Frank.

The only other outstanding problem as of now is that the RT kernel
hanging during boot on panda board (boots sometimes after several
resets and/or power-cycles).
