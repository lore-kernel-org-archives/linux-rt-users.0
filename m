From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: [ANNOUNCE] 3.6.11.4-rt36
Date: Mon, 27 May 2013 09:38:22 +0200
Message-ID: <CALqGcGpX5FDi6yqDFC7zac2vKFzhNTozSbQxYn=YdLM=14DbFw@mail.gmail.com>
References: <1369154725.6828.131.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:57662 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640Ab3E0HiW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 May 2013 03:38:22 -0400
Received: by mail-qc0-f181.google.com with SMTP id u11so3340729qcx.40
        for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2013 00:38:22 -0700 (PDT)
In-Reply-To: <1369154725.6828.131.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Just did a quick "smoketest" with cyclictest. This release spikes to
over 600us when opening other gnome-terminals or switching to a VTY
etc. I checked with 3.6.11.3-rt35, and the problem does not occur
there.

Christoph

On Tue, May 21, 2013 at 6:45 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Dear RT Folks,
>
> I'm pleased to announce the 3.6.11.4-rt36 stable release.
>
>
> This release is just an update to the new stable 3.6.11.4 version
> and no RT specific changes have been made.
>
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   branch: v3.6-rt
>   Head SHA1: 605e3eba4fbf83ad32032cec4ca4c1d2fa665793
>
>
> Or to build 3.6.11.4-rt36 directly, the following patches should be
> applied:
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.6.tar.xz
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.6.11.xz
>
>
> http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/stable/patch-3.6.11.4.xz
>
>
> http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.11.4-rt36.patch.xz
>
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
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
