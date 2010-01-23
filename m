From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Best gcc flags?
Date: Sat, 23 Jan 2010 14:27:34 -0800
Message-ID: <5bdc1c8b1001231427k26a030ep4c15ceb918201849@mail.gmail.com>
References: <5bdc1c8b1001221054g406baa9cp226a478be7342c0e@mail.gmail.com>
	 <520f0cf11001221409t2eda34e6kae393afde012d6fc@mail.gmail.com>
	 <5bdc1c8b1001221458j74d36fdbl3f154f8b539791dd@mail.gmail.com>
	 <4B5B57F6.3050304@cauwe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
To: Xavier Miller <xavier.miller@cauwe.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:41240 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab0AWW1f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jan 2010 17:27:35 -0500
Received: by pzk28 with SMTP id 28so885996pzk.4
        for <linux-rt-users@vger.kernel.org>; Sat, 23 Jan 2010 14:27:35 -0800 (PST)
In-Reply-To: <4B5B57F6.3050304@cauwe.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Jan 23, 2010 at 12:11 PM, Xavier Miller <xavier.miller@cauwe.org> wrote:
> Hello,
>
> Don't play with CFLAGS/LDFLAGS. -march=native will let GCC find the best
> (and most sable) options for your compiler.
> Playing with unsafe CFLAGS/LDFLAGS will produce unstable system, hard to
> debug.
>
> Kind regards,
> Xavier Miller.
>

thanks. That's the direction I went. Trying to bring up X now. When
it's up I'll start working on adding rt-sources.

Cheers,
Mark
