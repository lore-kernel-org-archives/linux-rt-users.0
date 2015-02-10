From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Doubt about v3.14-rt-rebase commits
Date: Mon, 9 Feb 2015 19:42:39 -0500
Message-ID: <20150209194239.3888dcf8@grimm.local.home>
References: <CAA8Xd+8CxjOFo_SLPfgAnrC7fo-kLxzamTkiOZPTkLVSX1zh7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Gustavo Bittencourt <gbitten@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:56749 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932845AbbBJAnM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Feb 2015 19:43:12 -0500
In-Reply-To: <CAA8Xd+8CxjOFo_SLPfgAnrC7fo-kLxzamTkiOZPTkLVSX1zh7A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 9 Feb 2015 21:52:21 -0200
Gustavo Bittencourt <gbitten@gmail.com> wrote:

> This is probably a silly question. I noticed that the below commits
> revert each other. Is any reason to maintain those commits in recent
> releases?

The rebase release is just that: a rebase. If a revert exists, but does
not cause any issue during the rebase, there's no reason to remove it.

I have (in fact in the last release I did) removed commits that later
get reverted. But that's because the original commit conflicts with a
new stable release, and then there's a reason to remove it.

-- Steve


> 
> commit: migrate_disable pushd down in atomic_dec_and_spin_lock
> 9056f04da7fd3bd39d5bc05cb42cf9d0f5b7b98c
> https://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v3.14-rt-rebase&id=9056f04da7fd3bd39d5bc05cb42cf9d0f5b7b98c
> 
> commit: Revert "migrate_disable pushd down in atomic_dec_and_spin_lock"
> 2137b9fff666c62077c7ae35e865eec86da0a499
> https://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v3.14-rt-rebase&id=2137b9fff666c62077c7ae35e865eec86da0a499

