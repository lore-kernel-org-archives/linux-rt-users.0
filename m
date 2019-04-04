Return-Path: <SRS0=J2Xz=SG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A91DC4360F
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 15:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2702082E
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 15:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTDqVhjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfDDPmG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:42:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40682 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDPmG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Apr 2019 11:42:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so3991022wmi.5
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Apr 2019 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OUFMbaBG3MO2NE7glq3hCZ9Wc+wnJop8M6sKOvcRdXQ=;
        b=kTDqVhjgdvoo6/7cmw93dGpRcQPpvHPpdZNLyh/+HspvJ1wdAA3qoeks2GuQDx4VKo
         dHaLETBk2W8gzTzLQ0EVy8NDzIEQB0Qk/+mPjBN5HerhjImkejvmzaYJdpA3hhDtFz0K
         E27GXfkmBhEGAcM4EZsHHAglB1TrXa/d8ehxmA06d1kRPAGJb8J0MjldrlwCY+/nKTpk
         sOdfBa7NQiHHsrj+8aB8dBX/s6nr9RC9n0U29FI83EfhivnuFFHGGVjSFQxPNqtqSL6O
         QujgNT1Aa6Os1PUoPYnuyJ/s1VlDHg+HU7qsYxihGUeY1PtoY+gEasXrgs+/lPUOEm3K
         aV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=OUFMbaBG3MO2NE7glq3hCZ9Wc+wnJop8M6sKOvcRdXQ=;
        b=rdakPqT25MRKEM6wiaGc5/gwARIRLTx0gtNtj9/ktGDg4tOTuLSxv0By2UnZnJ/b1q
         vNSuA8oOr3KnN8Ak+3NMQzMgTESBMEi0F2Sxc7x4v5NI+EtWBkYPvDbYBZ6+o+ipKFJ0
         BO34zJxEn05ybOzartCfHW6SJqU6GaMzBtEXEaY+FPknoLhELZY1ukv4DUkw9bfDADPB
         8dOhZodE44kx1NyyfKAubMcBO5Ap6lVXpAvJRJcoxlr/swSmdYUsn7kqMGt8xdcH27VO
         qB05198wWh5T3EisoMZ8PltE1POtP5gyXQ3TkBjNsU/czRERSJxbrrp7e5yRJswyWb72
         jN3g==
X-Gm-Message-State: APjAAAXzOloCdZEfZmU2sbwc2FfbeyNg6xC7G7QI9uNURXIUTrDuwMyb
        PB8vuPMns7YPXYaQNQces/M=
X-Google-Smtp-Source: APXvYqxkax/FcDypGB2GpEuC9f/9C9KdRyX46hBKwbMBytQDwEThVZpazXEeSintprTE9S+HajhbYg==
X-Received: by 2002:a1c:a70f:: with SMTP id q15mr4455526wme.28.1554392524293;
        Thu, 04 Apr 2019 08:42:04 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id d7sm23515996wmf.31.2019.04.04.08.42.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Apr 2019 08:42:03 -0700 (PDT)
Date:   Thu, 4 Apr 2019 17:42:02 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 4/4] rt-tests: deadline_test: add missing frees
In-Reply-To: <20190404151958.xdo66ytsvpklaqa2@linutronix.de>
Message-ID: <alpine.LFD.2.21.1904041741410.11547@planxty>
References: <20190404134814.13376-1-kurt@linutronix.de> <20190404134814.13376-5-kurt@linutronix.de> <alpine.LFD.2.21.1904041712560.11547@planxty> <20190404151958.xdo66ytsvpklaqa2@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 4 Apr 2019, Kurt Kanzenbach wrote:

> Hi,
> 
> On Thu, Apr 04, 2019 at 05:13:51PM +0200, John Kacur wrote:
> >
> >
> > On Thu, 4 Apr 2019, Kurt Kanzenbach wrote:
> >
> > > The threads and thread data structures are allocated using calloc(). But never
> > > free'd. So, free them.
> > >
> > > While here, remove the if statement for setcpu_buf. Free() is NULL safe.
> > >
> > > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > > ---
> > >  src/sched_deadline/deadline_test.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> > > index 4826557d0624..69e6fd18b73b 100644
> > > --- a/src/sched_deadline/deadline_test.c
> > > +++ b/src/sched_deadline/deadline_test.c
> > > @@ -2092,8 +2092,9 @@ int main (int argc, char **argv)
> > >  		printf("\n");
> > >  	}
> > >
> > > -	if (!setcpu_buf)
> > > -		free(setcpu_buf);
> > > +	free(thread);
> > > +	free(sched_data);
> > > +	free(setcpu_buf);
> > >
> > >  	return 0;
> > >  }
> > > --
> > > 2.11.0
> >
> > Does this remove your own if statement that I didn't even apply yet?
> > :)
> 
> No. That's a different binary. My patch was made against cyclicdeadline.
> 
> Thanks,
> Kurt

Ok, got it, thanks!

John
