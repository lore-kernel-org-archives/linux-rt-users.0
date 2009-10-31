From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Odd bug in SATA link power management
Date: Sat, 31 Oct 2009 01:28:46 -0400
Message-ID: <75b66ecd0910302228x45c00264qbba4c0f6639e4861@mail.gmail.com>
References: <74fd948d0910301225k207ec1f9sf2744ba0c5de6d33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:61612 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbZJaF2l (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 31 Oct 2009 01:28:41 -0400
Received: by pxi9 with SMTP id 9so2223817pxi.4
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Oct 2009 22:28:46 -0700 (PDT)
In-Reply-To: <74fd948d0910301225k207ec1f9sf2744ba0c5de6d33@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Oct 30, 2009 at 3:25 PM, Pedro Ribeiro <pedrib@gmail.com> wrote:
> The tricky part is that doing those two commands by hand (disabling
> the pm-utils script which does it, remove the AC, set min_power,
> insert the AC, set max_performance) doesn't crash the computer! Only
> when the script is run automatically by pm-utils it crashes. So I
> guess the timing is important here.

Try with 'sleep 10.0s' at the top of the script.  If that works reduce
the sleep time until you find the smallest value that works.  Then
separately test with the sleep in only the on or off case, and post
your results.

Lee
