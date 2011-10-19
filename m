From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] [PATCH -rt 5/5] cpufreq: get rid of
 get_online_cpus()/put_online_cpus()
Date: Wed, 19 Oct 2011 11:12:20 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110191110140.3240@ionos>
References: <1318762607-2261-1-git-send-email-yong.zhang0@gmail.com> <1318762607-2261-6-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35586 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab1JSJMW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Oct 2011 05:12:22 -0400
In-Reply-To: <1318762607-2261-6-git-send-email-yong.zhang0@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 16 Oct 2011, Yong Zhang wrote:

> Fix below false positive (seems this is not a real deadlock scenario)
> lockdep warning:

This looks like you caused it with patch 1. Both need a bit more
thought, but thanks for catching that.

Thanks,

	tglx
