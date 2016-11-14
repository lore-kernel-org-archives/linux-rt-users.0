From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: Calculate average latencies on the fly
Date: Mon, 14 Nov 2016 08:42:31 -0700
Message-ID: <CANLsYkzYHZX085Yb=2CYo6qsC+ZDp_mWwNE3p5yxYdrconxsWQ@mail.gmail.com>
References: <CAK+oA4V8yFDnieAa4tsCQKTapNe6gA_VLJvvEh6_u_jgWpyahQ@mail.gmail.com>
 <CAK+oA4WFAaT4DmR=8nKqTsyKe9imDYCu5p6DG4kqbhoBPD=LXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Piotr Gregor <piotrgregor@rsyncme.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36477 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbcKNPmc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Nov 2016 10:42:32 -0500
Received: by mail-yw0-f176.google.com with SMTP id a10so63748967ywa.3
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Nov 2016 07:42:32 -0800 (PST)
In-Reply-To: <CAK+oA4WFAaT4DmR=8nKqTsyKe9imDYCu5p6DG4kqbhoBPD=LXw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 14 November 2016 at 04:50, Piotr Gregor <piotrgregor@rsyncme.org> wrote:
> There was an error in previous patch. Please find attached corrected patch.
>
> cheers,
> Piotr

Piort,

I am fairly new to this mailing list but if it is anything like the
kernel's, you will want to send your patch using git send-email.  It
is probably a good idea to run checkpatch.pl on it too - that way
you'll avoid all sort of style problems like lines over 80 characters
long.

Mathieu
