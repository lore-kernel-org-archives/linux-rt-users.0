From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.9.30-rt20
Date: Sat, 27 May 2017 19:33:18 +0200
Message-ID: <20170527173318.ed2v6ipmrnnq4iv5@linutronix.de>
References: <20170527163230.b7qcfbmwsmbyo7k2@linutronix.de>
 <fccee2a1-e0d3-4591-8ecc-6a1da4934219@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Bernhard Landauer <oberon@manjaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44580 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdE0RdV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 May 2017 13:33:21 -0400
Content-Disposition: inline
In-Reply-To: <fccee2a1-e0d3-4591-8ecc-6a1da4934219@manjaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-05-27 19:19:51 [+0200], Bernhard Landauer wrote:
> Thanks a lot as always!
> I have a question regarding packager keys:
> It seems this time the patch has been signed with a different key than
> usual:
> 
> unknown public key 4FE5E3262872E4CC
> 
> Could you please let me know where you packager keys can be looked up?
> Thanks

This is a subkey on the original key 0x7B96E8162A8CF5D1. If you refresh
the key then it should work again. Please let me know if it does not.

> regards
> Bernhard

Sebastian
