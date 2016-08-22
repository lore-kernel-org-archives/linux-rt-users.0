From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Make output of RT throttling more verbose
Date: Mon, 22 Aug 2016 09:40:06 +0200
Message-ID: <20160822074005.ecckrxmnnqy72crs@linutronix.de>
References: <99b19596-c11b-0b92-7376-b1a07f1aaa88@osadl.org>
 <20160817084613.npcfmylluwhi5suh@linutronix.de>
 <250cd9a5-7b1d-96b4-1317-c54bc632bb6a@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:52175 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754656AbcHVHkK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Aug 2016 03:40:10 -0400
Content-Disposition: inline
In-Reply-To: <250cd9a5-7b1d-96b4-1317-c54bc632bb6a@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-08-21 23:39:21 [+0200], Carsten Emde wrote:
> Hi Sebastian,
Hi Carsten,

> We could save a short history of RT tasks along with their uninterrupted
> runtime and, in case of throttling, print the one with the longest
> uninterrupted runtime.

A sched_switch tracer would do that. It only does not stop and records
SCHED_OTHER as well. Maybe the tracing folks have an idea.

> Carsten.

Sebastian
