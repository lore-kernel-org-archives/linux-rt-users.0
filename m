From: Alessio Igor Bogani <abogani@texware.it>
Subject: Re: v2.6.23-rc4-rt1 / new project URL
Date: Thu, 06 Sep 2007 15:00:30 +0200
Message-ID: <1189083630.11470.3.camel@godzilla.tecnorama.it>
References: <1188593944.9647.15.camel@chaos>  <46DBE55D.3050905@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:38609 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756032AbXIFNAf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Sep 2007 09:00:35 -0400
In-Reply-To: <46DBE55D.3050905@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On Mon, 2007-09-03 at 12:43 +0200, John Sigler wrote:
[...]
> > - update to 2.6.23-rc4-hrt1
> > - UP compile fixes back merged (Kevin Hilman / Steven Rostedt)
> > - various latency tracer fixes (Steven Rostedt)
> > - softirq migration fixes (Steven Rostedt)
> > - ARM futex cmpxchg in atomic support (Khem Raj)
> > - ARM raw lock fix (Kevin Hilman)
> > - loadavgrt fix (Luis Claudio R. Goncalves)
> > - mellanox driver fix (Michael S. Tsirkin)
[...]
> Is (part of) this update planned to be back-ported to 2.6.22.6?

Someone could tell me which of these fixes are also valid for 2.6.22-rt
patchset, please?

Thanks in advance.

Ciao,
Alessio
