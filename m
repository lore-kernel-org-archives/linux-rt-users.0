Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:37902 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeJESIi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Oct 2018 14:08:38 -0400
Date: Fri, 5 Oct 2018 13:10:17 +0200
From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: WARNING when running cyclictest
Message-ID: <20181005111017.gmctslwfgnhtdsul@linutronix.de>
References: <043561c1-3fc1-5cbc-9cec-a87e39e0218a@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <043561c1-3fc1-5cbc-9cec-a87e39e0218a@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: He Zhe <zhe.he@windriver.com>
Cc: linux-rt-users@vger.kernel.org

On 2018-09-20 23:22:58 [+0800], He Zhe wrote:
> Hi,
Hi.

> When running cyclictest on latest preempt-rt kernel I met the following the WARNING. It only happens when "taskset -c 0" and "-c 1"(CLOCK_REALTIME) is specified in the command line. After bisecting, it seems this happens since v4.13-rt1. Is this possibly a bug?
> 
> taskset -c 0 cyclictest -p 80 -i 1000 -l 10000 -c 1 -q

This is known and mentioned at the bottom of the release notes. I would
suggest to use clock_nanosleep() (see that -n parameter) which should be
preferred over the other timer interfaces.

> Zhe

Sebastian
