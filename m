From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 4.8.6-rt5 ftrace function_graph hangs
Date: Mon, 28 Nov 2016 15:33:17 +0100
Message-ID: <20161128143317.oz6n6jzvu227jnz3@linutronix.de>
References: <d275a464-c787-6e21-0d3f-bbb3d854176e@windriver.com>
 <20161118113524.43f6ff3c@gandalf.local.home>
 <1785742b-8094-56af-01b9-6bac5c67865f@windriver.com>
 <67df43c6-ac39-dea0-025d-5fce434d2743@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, Yang Shi <yang.shi@windriver.com>
To: He Zhe <zhe.he@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46076 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932626AbcK1OdV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Nov 2016 09:33:21 -0500
Content-Disposition: inline
In-Reply-To: <67df43c6-ac39-dea0-025d-5fce434d2743@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-11-21 16:30:40 [+0800], He Zhe wrote:
> And I've tried on "a7fac75 Linux 4.8.1" and the latest linux-4.8.y-rt-rebase branch.They have the same issue.

It works here. I tried your config with oldconfig on a x86-64 box. Do
you have a x86-64 config?

> Zhe

Sebastian
