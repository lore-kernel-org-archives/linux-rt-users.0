From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [ANNOUNCE] 3.4.12-rt20
Date: Mon, 8 Oct 2012 19:05:59 -0400
Message-ID: <CAP=VYLrg2ouS+fODQMtxAguZ84h-v5T66aX48vTOCdsMhbBckg@mail.gmail.com>
References: <1349720414.6755.111.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35784 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2JHXGa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2012 19:06:30 -0400
In-Reply-To: <1349720414.6755.111.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Oct 8, 2012 at 2:20 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Dear RT Folks,
>
> I'm pleased to announce the 3.4.12-rt20 stable release.
>
>
> This release is just an update to the new stable 3.4.12 version
> and no RT specific changes have been made.

Did I miss something that ruled out the inclusion of your fix for
moving the per-cpu softirq lock init after setup_per_cpu_areas?

Thanks,
Paul.
--

>
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   Head SHA1: 16f7c2da31596d7b61e29ee6df2f89ed69a7ecf7
>
>
> Or to build 3.4.12-rt20 directly, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.12.xz
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.12-rt20.patch.xz
>
>
>
> Enjoy,
>
> -- Steve
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
