Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C81C43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 13:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8352084A
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 13:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Huc3FVeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfFTN0l (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:26:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38450 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfFTN0l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 09:26:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so3040369wrs.5;
        Thu, 20 Jun 2019 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=hU3DkIXyJYQmHH2nQ9En6cL1I4MCktg6zlXWBcKigZ4=;
        b=Huc3FVeThjguxOUz5naklW/LHaG0uERPNoBoIrM4md8PRawkrQ1EcdJ86pTFY/McVd
         QyR06cUn3aT+6nzzNzBkoEt8hhZnOGilPbGpl2gWfR/BIlFl1llx+cLoLIsql/GrBHC/
         tIvCWgaisC8+MZ0u7WJj1nlPFiUQyG9TxP1S7GMu8GkBGtbv4j6epkyBT/LsLaMAIrYk
         Qb64IiQi4NcYjD1vjK5PBRX7FxdQ8hXy0m/nnPmyyXhSyKwtBrArtWJqvyyWObIC+VHD
         XrrTUEra4gbG/Nc+BuwJ/4FJ95a4nGSKR1d0lmesYxQZgreDEcnJ5boZFgGhL4vWq7as
         Q/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=hU3DkIXyJYQmHH2nQ9En6cL1I4MCktg6zlXWBcKigZ4=;
        b=erjdIV3uaBoJ62akOh460s2lbH1lMUXzF4Uivw6dXxQ3Kf025TrZj/b7bZAqpXhVAp
         fq/HKPXbNxbl3pmDXSkp0IQcSOJBrLoKHwPwJBzXW6wXHTbEyEYB+c52OQTFULE+4aUP
         HM1aZFCGjfqwFpC8mhvjxZxkpanZ1A1g0IuE3/O/ftERm3fqLAvNYvnK8tuuCHtvznqb
         V2+IfzNSwr0iEVlyHlRgfugCoEhoNtVEPkQ3iKrS6mqVVd7pEBLuj68RNOR1Zv4W76el
         9Vo3C5GYDyL1j6aCPvSX17y1lR/nkslrAVVxpL7ZgUF8erY64WftQC/Ro60cEUnPuoxz
         MVAA==
X-Gm-Message-State: APjAAAVjGsnz/wttSVoeX3xWEnUfjdaY6g+5DeNz68yq9mRZPbBmVApe
        zFOcY0Wu/cJYLtl3rzkY1vBV64jF9VQ=
X-Google-Smtp-Source: APXvYqzYYjfoIZlSfn6vI9A6lm9rafj9coDyq7qPJQanuKgRpyICbEKXtalxddK3MjkH99lQRGwImg==
X-Received: by 2002:a5d:4cc3:: with SMTP id c3mr16331818wrt.259.1561037198513;
        Thu, 20 Jun 2019 06:26:38 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id o126sm6481084wmo.1.2019.06.20.06.26.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 06:26:37 -0700 (PDT)
Date:   Thu, 20 Jun 2019 15:26:30 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Linux RT Users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
cc:     Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] New release rt-tests-1.4
Message-ID: <alpine.LFD.2.21.1906201444220.6702@planxty>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We haven't had a release in a while as people were content to work from 
git. However, in order to make it easier to use, test, and put into 
distributions, now would be a good time for an official release.

There have been a number of interesting changes since 1.3

I'm happy with the way the removal of the --numa from cyclictest is 
working now. What this means is that numa is dectected automatically, so 
you don't have to specify it. You can still force smp with --smp though.

In addition, cpu affinity should work correctly now. Historically there 
were combinations of options in which you couldn't specify cpu affinity, 
but these restrictions have been removed.

We have added a number of new programs to the rt-tests suite

- queuelat
- cyclicdeadline
- deadline_test
- ssdd

queuelat simulates a network queue checking for latency violations in
packet processing.

deadline_test is used to test the deadline scheduler (SCHED_DEADLINE)
cyclicdeadline also tests the deadline scheduler in a cyclictest manner

ssdd has a tracer do a bunch of PTRACE_SINGLESTEPs

There is a new feature that adds a duration option to many of the tests
as a more natural way that iterations to determine how long to test for.

There have also been a number of fix and updates, such as an update.
hwlatdetect no-longer requires a kernel module, instead it uses ftrace.
It also works with python3

CPU counters with SMI counter support has been updated, although I think 
we're due for another. Hint to Daniel :)

So the latest stable / unstable branch (yes the naming is confusing, and 
this will be changed in the future too) is

unstable/devel/latest
If you just to want to use or test the latest then use that

Development for the above is happening here
unstable/devel/latest-devel

This already has some new patches for the deadline tests
This is what developers should development against until
I merge it back into the latest.

Bug reports and patches, are all welcome.

I'd like to step up development, especially bug fixes, and
harden this up. Everything is working reasonably well, but
I'm sure with everyone working the code we can flush out some bugs
and aim for a new stable branch.


So, have fun, and send in your patches and reports!

John Kacur

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
branches

Branches
unstable/devel/latest (rt-tests: Version 1.4)
unstable/devel/latest-devel (for latest development of Version 1.4)

tarballs are available here
https://kernel.org/pub/linux/utils/rt-tests/
