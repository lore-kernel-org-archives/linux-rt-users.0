From: Julia Cartwright <julia@ni.com>
Subject: Re: fix on rt-tests of backfire kernel module
Date: Wed, 27 Sep 2017 11:12:16 -0500
Message-ID: <20170927161216.GQ29872@jcartwri.amer.corp.natinst.com>
References: <CAFwEtmr=6rA28uUM6tHR4yH_mNShHk2zepAJ3GX-ZvvuUX8i5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>, John Kacur <jkacur@redhat.com>,
        "Clark Williams" <williams@redhat.com>
To: Michele Dionisio <michele.dionisio@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:37382 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751713AbdI0QMV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Sep 2017 12:12:21 -0400
Content-Disposition: inline
In-Reply-To: <CAFwEtmr=6rA28uUM6tHR4yH_mNShHk2zepAJ3GX-ZvvuUX8i5g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 27, 2017 at 09:15:11AM +0200, Michele Dionisio wrote:
> Hi all,
>
> I'm new in this mailing list.

Welcome!

> I start to work/test PREEPT_RT and making some test I seee that there
> is a bug on backfire module in rt-tests repository.

At the very least, you'll want to elaborate on the bug you were seeing.
What broke?  What did you expect to see?  What did you see instead?  Is
this a build time problem?  A run-time problem?  How does your fix
prevent this problem from occurring?

Also, for rt-tests patches, you'll want to ensure to CC John Kacur and
Clark Williams, who are maintaining the project.

> I'm attaching my patch.
>
> best regards.
> Michele


> From cd94ede8cf9eb8c26a196ea0111220969451cbb2 Mon Sep 17 00:00:00 2001
> From: Michele Dionisio <michele.dionisio@powersoft.it>
> Date: Tue, 26 Sep 2017 14:32:51 +0200
> Subject: [FIX] fix copy data to and from userspace

You'll want to include a changelog here, describing the above.  This is
what will go into the git permanent history.

> diff --git a/src/backfire/backfire.c b/src/backfire/backfire.c
> index aaf9c4a..b38651b 100644
> --- a/src/backfire/backfire.c
> +++ b/src/backfire/backfire.c
> @@ -20,11 +20,9 @@
[..]
> +#define MAX_SIZE_DATA_RW 512
> +
>  /*
>   * These are the file operation function for user access to /dev/backfire
>   */
>  static ssize_t
>  backfire_read(struct file *file, char *buf, size_t count, loff_t *ppos)
>  {
> -	return snprintf(buf, count, "%d,%d\n", (int) sendtime.tv_sec,
> +    char kbuf[MAX_SIZE_DATA_RW];
> +    ssize_t res;
> +    if (count > MAX_SIZE_DATA_RW) {
> +        count = MAX_SIZE_DATA_RW;
> +    }
> +	res = snprintf(kbuf, count, "%d,%d\n", (int) sendtime.tv_sec,
>  		(int) sendtime.tv_usec);
> +    copy_to_user(buf, kbuf, res+1);
> +    return res;

Your patch is also whitespace damaged.  You'll want to ensure to follow
the kernel's CodingStyle here (which is 8-space tabstops).

   Julia
