From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: [ANNOUNCE] 3.6.11.4-rt36
Date: Mon, 27 May 2013 11:12:47 +0200
Message-ID: <CALqGcGon9Mpd1fMHuxffaipSHZaQVSVfx=Y_9o=xzUyBhhRMMw@mail.gmail.com>
References: <1369154725.6828.131.camel@gandalf.local.home>
	<CALqGcGpX5FDi6yqDFC7zac2vKFzhNTozSbQxYn=YdLM=14DbFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:34152 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab3E0JMs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 May 2013 05:12:48 -0400
Received: by mail-qe0-f52.google.com with SMTP id 1so3660537qec.11
        for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2013 02:12:48 -0700 (PDT)
In-Reply-To: <CALqGcGpX5FDi6yqDFC7zac2vKFzhNTozSbQxYn=YdLM=14DbFw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry, I did not provide any info at all:
- Intel i7 sandybridge with 64b kernel
- Onboard i915 with two screens is in use

As a lucky guess I tried reverting
a2f03d58cb16cdcdbbe83e28a00d03254a7840ba: drm/i915: Workaround
incoherence between fences and LLC across multiple CPUs.

The resulting kernel did not show the problems above and cyclictest is
back to around 10us worst case on an idle system.

Christoph
