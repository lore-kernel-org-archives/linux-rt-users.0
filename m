Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:38678 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEXzB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Oct 2018 19:55:01 -0400
Date: Fri, 5 Oct 2018 18:55:26 +0200
From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: Floating point register corruption on ARM Cortex A57 (ARMv8)
 with RT_PREEMPT linux
Message-ID: <20181005165525.vmgxqdyymcuc6xkd@linutronix.de>
References: <CAF_EZTMMAkxfCxjAVTJCqVHTUbPQNyUXDgbDk8xmGvp-hKdwcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF_EZTMMAkxfCxjAVTJCqVHTUbPQNyUXDgbDk8xmGvp-hKdwcQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Anup Pemmaiah <anup.pemmaiah@gmail.com>
Cc: linux-rt-users@vger.kernel.org

On 2018-10-04 19:12:53 [-0700], Anup Pemmaiah wrote:
> 1) Is there any floating point related kernel setting that I should
> set in the RT_PREEMPT kernel? I have set eagerfpu=on (even though it
> is on by default)

nope, should work by default. Do you have NEON related crypto code or
EFI enabled?

> 2) Was reading about "Lazy Stacking" for Cortex-M4, but not sure if it
> applies for Cortex A57
> 
> Any comments will be greatly appreciated.

Could you please try the latest v4.18? I believe it is fixed there and
needs just backporting. Could you please try?

Sebastian
