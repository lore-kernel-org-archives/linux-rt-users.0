From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [v4.9-rt][report] stress-ng: possible circular locking
 dependency detected
Date: Mon, 18 Dec 2017 20:06:12 -0500
Message-ID: <20171218200612.7dce6787@gandalf.local.home>
References: <e27d043e-9565-f9fd-0b00-8fa5e123f147@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sekhar Nori <nsekhar@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935486AbdLSBGP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Dec 2017 20:06:15 -0500
In-Reply-To: <e27d043e-9565-f9fd-0b00-8fa5e123f147@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 18 Dec 2017 18:55:24 -0600
Grygorii Strashko <grygorii.strashko@ti.com> wrote:

> Hi All,
> 
> I've tried to run stress-ng on TI am57xx-evm (SMP, 2 cpu) and caught 2  "INFO: possible circular locking dependency detected"
> 
> Command 1 (log 1):
> ## stress-ng --class cpu --all 0 -t 5m &   stress-ng --class memory --all 0 --vm-bytes 90% -t 5m
> 
> Command 2 (log 2):
> ## stress-ng --class os --all 0 -t 5m
> 
> actually command 2 often stuck or crushes (Log3 - I've collected 3 different dumps)
> 

I hate to tell you but CPU hotplug is known to be broken on 4.9-rt and
earlier. Hopefully the v4.14-rt code with the redesigned hotplug work
fixes all this.

-- Steve
