From: Jan Blunck <jblunck@suse.de>
Subject: Re: [PATCH] get rid of [softirq-NULL]
Date: Fri, 25 Sep 2009 10:16:22 +0200
Message-ID: <4de7f8a60909250116o69a52b09wbbeec340de4b7158@mail.gmail.com>
References: <1253825033-30094-1-git-send-email-linux@bohmer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:58453 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbZIYIQT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Sep 2009 04:16:19 -0400
In-Reply-To: <1253825033-30094-1-git-send-email-linux@bohmer.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Sep 24, 2009 at 10:43 PM, Remy Bohmer <linux@bohmer.net> wrote:
> if CONFIG_HIGH_RES_TIMERS is not configured, still the hrtimer-softirq
> is started, so to prevent the name 'softirq-NULL' in 'ps' output we
> should still define its name here.
> Preventing the softirq from starting at all would touch much more code, so
> I chose the easy way here, it is a cosmetic fix anyway.

Anyway, it would be the right thing to do just that.

Just un-define the enum HRTIMER_SOFTIRQ and the code that needs
modification should pop up. Removing it from the enum also disables
the kthread. Most of the code that raises the softirq should be
guarded by CONFIG_HIGH_RES_TIMERS anyway.

HtH,
Jan
