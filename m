From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: [PATCH v2] drm/i915: Do not flush caches on RT, print a warning instead
Date: Mon, 10 Jun 2013 08:30:35 +0200
Message-ID: <CALqGcGoeGSN8tJ3AmRFeoysWEZdHA2c8X3Ebjn4GHOX=naK_Ww@mail.gmail.com>
References: <1369154725.6828.131.camel@gandalf.local.home>
	<CALqGcGop=cpgSvcdmwE6QOSjo-JHBDGYpe2qyy3cxULfamgy+w@mail.gmail.com>
	<1370637266.9844.95.camel@gandalf.local.home>
	<51B35727.6040907@osadl.org>
	<51B46AC0.7050502@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Daniel Vetter <daniel@ffwll.ch>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43252 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab3FJGag (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Jun 2013 02:30:36 -0400
Received: by mail-qa0-f46.google.com with SMTP id ih17so2085595qab.5
        for <linux-rt-users@vger.kernel.org>; Sun, 09 Jun 2013 23:30:35 -0700 (PDT)
In-Reply-To: <51B46AC0.7050502@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Jun 9, 2013 at 1:45 PM, Carsten Emde <C.Emde@osadl.org> wrote:
> Invalidating and flushing all caches may introduce long latencies of up
> to several milliseconds. Do not execute it in PREEMPT_RT_FULL kernels,
> warn once instead and propose to pin all GPU renderering tasks to a
> single CPU, if possible.
>
> Original commit:
> 25ff1195f8a0b3724541ae7bbe331b4296de9c06 upstream.
>
> Original log:
> In order to fully serialize access to the fenced region and the update
> to the fence register we need to take extreme measures on SNB+, and
> manually flush writes to memory prior to writing the fence register in
> conjunction with the memory barriers placed around the register write.
>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>

This fixes the problem for me on 3.6.11.5-rt37. Thanks, Carsten!

Christoph
