Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB2BC35E15
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 18:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1303120726
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 18:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vC3GX1Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgB0SaA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:30:00 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41301 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgB0SaA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 13:30:00 -0500
Received: by mail-qv1-f65.google.com with SMTP id s7so39939qvn.8
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Feb 2020 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5dpNUSmaEhmExuHEBgvYjl3PkOKesHFQuFO3KT8Fk24=;
        b=vC3GX1Z34OlI72nsj0lem6EbmtosB2IarCfIN5CN4v9/t2wyFR/WFNGR5VgVMxIBrr
         9YSPfE3qUqgI4wnOGsaynEwYdqSUe6wFvk841OeZukHSb+Y/UXzoR6jEesaO0QIVgTjy
         B8J7VBED2g5s8hd1SHfnoOqrJjtxnOIEXvBcFvMAKOQq2j8Wwt5awWvspUdnbH38psgf
         iEZ+YIG45/Ec23F+2CY5eQXxnpBbJPQonfaQwEsosV1jexpa+zf28pdSuh2i29wEXU5a
         wHlGqI1cGNxLDy5P4ojCHMm6U753sIeqaxBGFSTssBQMHzVY45JekW6F9tMPcO5MXuZs
         75RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=5dpNUSmaEhmExuHEBgvYjl3PkOKesHFQuFO3KT8Fk24=;
        b=mCuxANwpzk7faaXg759k1Xm/wC3GLhgxyP84FnoGxfR4CbxTjRk/5NdyZdsBMXiGGV
         G6nql5lLSDDtmSQyZS/EcJdJYRCQrX7ZEa5nt+WH5Wp6/LcuwFq8v8mw6WGDwxUT8WQR
         VQ4TWPqjV6wl+bQ533Jv4be46syHA6WnqyD2Xw51afSWNUXFHqkJLuSIwRO1maQdd+5D
         cjngAO7tbsDX6gS9AToeTr+RbAa/tqgxoDLb1wtC+iebWQ/ryBNUsPIJyUMLRXESgvtV
         FyJxN6PXbahOedVsRywOij//Pwyzlziy+2fHi7WEUCcVmfzfqAPtHH9iTjBF2C11GRrz
         GWaA==
X-Gm-Message-State: APjAAAVPp/o6CflbmSWKAUKonCRCMfGnug2W/KS2m0Q4v/YczrMmhW4L
        k0mVPdAZrdl1wFQLQcEXnEM=
X-Google-Smtp-Source: APXvYqxKyD1VseEYoXbR3QO7JAo4jqGpiz1Lk5MozG5FOxof7fNnuQ2Hhc3Lg+aNbQmDGTR7W6i6jA==
X-Received: by 2002:ad4:58a8:: with SMTP id ea8mr163813qvb.93.1582828199457;
        Thu, 27 Feb 2020 10:29:59 -0800 (PST)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id b2sm3462655qkj.9.2020.02.27.10.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:29:58 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:29:50 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     "Jeremy A. Puhlman" <jpuhlman@mvista.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests][PATCH] rt-tests: make manpages builds reproducible
In-Reply-To: <3688e9ae-69b9-7237-59e8-9c1f316b5fa8@mvista.com>
Message-ID: <alpine.LFD.2.21.2002271329300.5532@planxty>
References: <20200225234230.17232-1-jpuhlman@mvista.com> <alpine.LFD.2.21.2002261217460.9967@planxty> <3688e9ae-69b9-7237-59e8-9c1f316b5fa8@mvista.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463805694-245952331-1582828198=:5532"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463805694-245952331-1582828198=:5532
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 26 Feb 2020, Jeremy A. Puhlman wrote:

> 
> 
> On 2/26/2020 9:18 AM, John Kacur wrote:
> >
> > On Tue, 25 Feb 2020, Jeremy A. Puhlman wrote:
> >
> >> From: Jeremy Puhlman <jpuhlman@mvista.com>
> >>
> >> Add -n to gzip call to make the build output
> >> of the manpages reproducible.
> >>
> >> Signed-off-by: Jeremy A. Puhlman <jpuhlman@mvista.com>
> >> ---
> >>   Makefile | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index 8747971..1b37ba7 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -181,7 +181,7 @@ ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
> >>    $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
> >>   
> >>   %.8.gz: %.8
> >> -	gzip -c $< > $@
> >> +	gzip -nc $< > $@
> >>   
> >>   %.8.bz2: %.8
> >>   	bzip2 -c $< > $@
> >> -- 
> >> 2.20.1
> >>
> >>
> > Could you explain to me how this makes the build output of manpages more
> > reproducible?
> 
> gzip adds the name of the file(not really an issue) and the modification time
> into the header of the
> gzipped archive.  Different modification times can cause the archives to have
> different md5sums even
> though the content is identical.  Adding -n causes the archives to always be
> identical regardless of when
> they are built so long as the content is identical. Its less of an
> issue(provided the build system in question
> doesn't touch or modify the man pages) when you are building from released
> tarballs, but if you build
> from git, the modification time of the file is when the file was checked out.
> 
> Tools like rpm will object to the files being installed(like say multilib
> versions of the same packages) together
> due different md5sums and the fact that they are not elf binaries, even though
> the files are the same.
> 
> 
> -- 
> Jeremy A. Puhlman
> jpuhlman@mvista.com
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
---1463805694-245952331-1582828198=:5532--
