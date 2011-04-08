From: John Kacur <jkacur@redhat.com>
Subject: Re: Preferred way for rt-linux using git
Date: Fri, 8 Apr 2011 18:41:13 +0200
Message-ID: <BANLkTikP3ZEndzdOxA8aX29125h9MXG6xQ@mail.gmail.com>
References: <BANLkTi=3s8bZLibMZX7y6_NGhHivErwS_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: dashesy <dashesy@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38500 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583Ab1DHQok (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Apr 2011 12:44:40 -0400
Received: by qyk7 with SMTP id 7so4100145qyk.19
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Apr 2011 09:44:39 -0700 (PDT)
In-Reply-To: <BANLkTi=3s8bZLibMZX7y6_NGhHivErwS_Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 8, 2011 at 5:51 PM, dashesy <dashesy@gmail.com> wrote:
>
> Hi,
>
> I am new to rt-linux, what is the preferred way of getting the source
> and applying the patch using git?
> Should I do:
> "git clone git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
> rt/2.6.33"
> or maybe I should start from the long-term 2.6.33 version?
> "git clone git://git.kernel.org/pub/scm/linux/kernel/git/longterm/linux-2.6.33.y.git
> linux-2.6.33"
> then apply the newest patch?
>
> Thanks for the great work BTW
>

For -rt you want to clone the one in tip. tglx pulls from stable and
merges it into -rt himself.
The latest tag is 2.6.33.9-rt31

If you have any problems with it, we're always interesting in hearing
about them.

Thanks
John Kacur
