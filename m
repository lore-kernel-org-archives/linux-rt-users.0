Return-Path: <SRS0=8Glo=DH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8284C4727C
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Sep 2020 15:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F37320739
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Sep 2020 15:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJEsWNhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgI3Ppc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgI3Ppc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 30 Sep 2020 11:45:32 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601480730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HO8sWT9IfgxNgQahgacDFKLH43vjjOJL8xgtGofXVbk=;
        b=PJEsWNhW9tBd9/U+mP5G5t4i1aupkdf1X6YeBcvOQBnpsfwtLXdxz7RWMZ8D39Pu9MaD/E
        fTgE0CABO0gFl205nePN+4jscYfXG1uGIGvOs0OUFdQWAtuI80QXNbwbw+a3beZO80QtA6
        nhpEehIJdcJufNkzln/buWpMt4lScro=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-xJoqerEWPwScjX0uY4C_IA-1; Wed, 30 Sep 2020 11:45:26 -0400
X-MC-Unique: xJoqerEWPwScjX0uY4C_IA-1
Received: by mail-qt1-f197.google.com with SMTP id e6so1502219qtg.13
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Sep 2020 08:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HO8sWT9IfgxNgQahgacDFKLH43vjjOJL8xgtGofXVbk=;
        b=l4Qbpb3lFezhlzCI2ziWvJPseRibNE7y4bOSEW/ZgBIbdXSfX/DFuUSZgasgPVij/Z
         MnPtbyxIE9unfO/imp0g+yFYaD19FlGyNEnSFD2faxdUaWkarE07cW+chiDjdZGm2YCl
         yfbAehm9w1/dEE1yNRSr0l3mcbjisq1GNgFCo6k6H4SLB94Me3i6b/rViaiYo3uyiaE1
         dfo75CMWx6wztL6WYzbYSiRf+ww/ScgyQZvqEwaRJRYEZdzkMtOM3G8Kgx5J4nHC/cv0
         SXLaJmK31DmhNM5AbeH545z+heub5g5OSeUmXC7lpWLh2xQjX5cVv84JC1ZQoTPCTPC/
         M6XA==
X-Gm-Message-State: AOAM530jzWDlVXXNMlhrVswsYmQdnDaT5k1u1zmeKhyP94aK4b1hyp1e
        e5w6KTWBdDQ9GNPwJ0NhH0HKCJcEirvblm2n0Jln78kRAFs5Wtnyz8ejMh5Yx4c8IsICQEl8q++
        1hXAHctz7HC8MU+jhI00ckChyWwQ=
X-Received: by 2002:ac8:1b6a:: with SMTP id p39mr2836555qtk.260.1601480725140;
        Wed, 30 Sep 2020 08:45:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydlsD1/DVKsBawgKh7G5rakSAprPSO7NZ8wENeITz2zkjQQugsJOZBjUXiFOa6c6qwWgYMnQ==
X-Received: by 2002:ac8:1b6a:: with SMTP id p39mr2836529qtk.260.1601480724832;
        Wed, 30 Sep 2020 08:45:24 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id h199sm2504730qke.112.2020.09.30.08.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:45:24 -0700 (PDT)
Date:   Wed, 30 Sep 2020 11:45:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Randy Witt <randy.e.witt@linux.intel.com>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: rt-tests v1.9 fails to compile on architectures that aren't
 x86_64, i386 or PPC64
Message-ID: <20200930154522.GD107801@xz-x1>
References: <62cb6195-7116-db1d-2af2-264dbd854ddb@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <62cb6195-7116-db1d-2af2-264dbd854ddb@linux.intel.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi, Randy,

On Mon, Sep 28, 2020 at 03:14:23PM -0700, Randy Witt wrote:
> With the addition of the oslat test in v1.9, "make" with no arguments will
> fail on any architecture that isn't x86_64, i386 or PPC64. This is due to
> the #error added here https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/oslat/oslat.c?h=v1.9#n72.
> 
> Since there is no build time configuration to turn off particular tests, is
> the expected workflow to specify the set of desired tests as make arguments?
> 
> In the absence of some sort of configure script, should there be a variable
> that allows for tests to be removed from the set of TARGETS?

I think we can, but instead of maintaining this knowledge both in the build
system and in oslat.c, I'm thinking maybe we can simply do that in oslat.c, let
it build but dump an error message for any unsupported archs.  Patch attached.

Another solution (as mentioned by John offlist) is we implement a common frc()
like fetching the time.  However since the __measure_cpu_hz() will always try
to calculate the cpu HZ, then the HZ could be confusing then.  Considering the
"read the processor clock" operation should still be the ideal implementation
for frc() (and I really doubt whether there'll be real need to run oslat on
other archs...), maybe we can use the simple way for now.

What do you think?

Thanks,

-- 
Peter Xu

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-rt-tests-oslat-Allow-build-for-not-supported-archs.patch"

From 40eeae690c1560632ac6160ad8056960216a9a43 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Sep 2020 11:30:15 -0400
Subject: [PATCH] rt-tests: oslat: Allow build for not supported archs

Now rt-tests won't build for archs other than x86/i386/ppc64 after oslat is
merged.  Instead of failing the build, let's make it pass.  However, whenever
oslat is executed, instead of running the real program, dump an error message,
so that people can try to implement the frc() function for it when there's a
real need for the new arch.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 src/oslat/oslat.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index f1a82f2..a8b6155 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -69,7 +69,9 @@ static inline void frc(uint64_t *pval)
 	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
 }
 # else
-#  error Need frc() for this platform.
+#  define relax()          do { } while (0)
+#  define frc(x)
+#  define FRC_MISSING
 # endif
 #else
 # error Need to add support for this compiler.
@@ -810,6 +812,12 @@ int main(int argc, char *argv[])
 	int i, n_cores;
 	cpu_set_t cpu_set;
 
+#ifdef FRC_MISSING
+	printf("This architecture is not yet supported. "
+	       "Please implement frc() function first for %s.\n", argv[0]);
+	return 0;
+#endif
+
 	CPU_ZERO(&cpu_set);
 
 	g.app_name = argv[0];
-- 
2.26.2


--eJnRUKwClWJh1Khz--

