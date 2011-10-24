From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [RFC] [PATCH -rt 5/5] cpufreq: get rid of
 get_online_cpus()/put_online_cpus()
Date: Mon, 24 Oct 2011 10:44:17 +0800
Message-ID: <20111024024416.GB24581@zhy>
References: <1318762607-2261-1-git-send-email-yong.zhang0@gmail.com>
 <1318762607-2261-6-git-send-email-yong.zhang0@gmail.com>
 <alpine.LFD.2.02.1110191110140.3240@ionos>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44802 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab1JXCo2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Oct 2011 22:44:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110191110140.3240@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 19, 2011 at 11:12:20AM +0200, Thomas Gleixner wrote:
> On Sun, 16 Oct 2011, Yong Zhang wrote:
> 
> > Fix below false positive (seems this is not a real deadlock scenario)
> > lockdep warning:
> 
> This looks like you caused it with patch 1.

Hmmm, yup.
CPU_DOWN_PREPARE will be under cpu_hotplug.lock.

> Both need a bit more
> thought, but thanks for catching that.

No sure whether it's big issue or not.
Mind showing more about your concern?

Thanks,
Yong
