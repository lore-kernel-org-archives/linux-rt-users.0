From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] README: Added info about setting branch --tracking
Date: Thu, 8 Jun 2017 09:57:00 +0200
Message-ID: <20170608075700.wwm6vdfdq3xk4rqw@linutronix.de>
References: <20170605080130.strwcmn6lqptqf76@debian1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jkacur@redhat.com, rolf.freitag@email.de,
        linux-rt-users@vger.kernel.org
To: Piotr Gregor <piotrgregor@rsyncme.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41766 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdFHH5I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2017 03:57:08 -0400
Content-Disposition: inline
In-Reply-To: <20170605080130.strwcmn6lqptqf76@debian1.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-05 09:01:33 [+0100], Piotr Gregor wrote:
> To setup remote tracking of the branch stable/v1.0
> git checkout with --track option can be used:
> 	git checkout -b stable/v1.0 --track origin/stable/v1.0
> Otherwise when git checkout -b stable/v1.0 is used
> branch may not be properly set up to track it's remote counterpart
> (given git option) and users may be confused due to no files present
> in the folder, but README.
> 
> Signed-off-by: Piotr Gregor <pgregor@quadrant-systems.co.uk>
> ---
>  README | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/README b/README
> index a618eb5..47e3e54 100644
> --- a/README
> +++ b/README
> @@ -4,3 +4,10 @@ The master branch is unused. You should use an existing branch instead.
>  
>  The stable/v1.0 branch contains the old stable version.
>  The unstable/devel branches contain the development versions.
> +
> +To checkout stable/v1.0 and setup remote tracking to /origin/stable/v1.0 please do:
> +	git checkout -b stable/v1.0 origin/stable/v1.0
> +or
> +	git checkout -b stable/v1.0 --track origin/stable/v1.0
> +and similarly for the unstable/devel/v1.1.1 branch please do:
> +	git checkout -b unstable/devel/v1.1.1 --track origin/unstable/devel/v1.1.1

That is mostly what I asked for. "Newer" git will accept

	git checkout stable/v1.0

go for the remote branch and track. But the long version is fine, too.
You could maybe add a
	git branch -r
to get an overview of the available remote branches. This is probably
helpful for someone not familiar with git.

Sebastian
